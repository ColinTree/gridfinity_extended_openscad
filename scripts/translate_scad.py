#!/usr/bin/env python3
"""
Translate SCAD file parameter comments to Chinese.
Format: 中文 / English
"""
import re
import os
import glob

SECTION_TRANSLATIONS = {
    "General Cup": "杯型基础",
    "Cup Lip": "杯口边沿",
    "Subdivisions": "内部分隔",
    "Base": "底座",
    "Label": "标签",
    "Sliding Lid": "滑动盖",
    "Sliding Cutout": "滑盖镂空",
    "Sliding Text": "滑盖文字",
    "Finger Slide": "取物槽",
    "Tapered Corner": "斜角边",
    "Wall Pattern": "墙体图案",
    "Floor Pattern": "底板图案",
    "Wall Cutout": "墙体镂空",
    "Extendable": "可延伸",
    "Bottom Text": "底部文字",
    "debug": "调试",
    "Debug": "调试",
    "Model detail": "模型细节",
    "model detail": "模型细节",
    "Hidden": "隐藏",
    "Render": "渲染",
    "Chest": "抽屉柜",
    "Drawer": "抽屉",
    "Chest Top Plate": "柜顶板",
    "Chest Base": "柜底",
    "Chest Wall Pattern": "柜体墙面图案",
    "Item Holder": "物品固定器",
    "Item Holder - Sample Item": "物品固定器 - 样品",
    "Item Holder - Multi Card": "物品固定器 - 多卡槽",
    "Item Holder - Custom Item": "物品固定器 - 自定义",
    "Item Holder - Item Layout": "物品固定器 - 布局",
    "Base Plate Options": "底板设置",
    "Printer bed options": "打印床设置",
    "Base Plate Clips": "底板连接件",
    "Custom Grid": "自定义网格",
    "Tray": "托盘",
    "Marble": "弹珠轨道",
    "Silverware": "餐具",
    "Chess": "国际象棋",
    "Lid": "盖子",
    "Sieve": "筛子",
    "Socket": "套筒",
    "Vertical Divider": "垂直隔板",
    "Glue Stick": "胶棒",
    "Stanley Cup": "Stanley杯",
}

# Each entry: (regex_pattern, chinese_prefix)
# The pattern is matched against the comment text (without leading // or spaces)
COMMENT_TRANSLATIONS = [
    # Dimensions
    (r"X dimension", "X轴"),
    (r"Y dimension", "Y轴"),
    (r"Z dimension", "Z轴"),
    (r"X outer dimension", "X轴外部尺寸"),
    (r"Y outer dimension", "Y轴外部尺寸"),
    (r"z outer dimension", "Z轴外部尺寸"),
    # Wall parameters
    (r"Wall thickness of outer walls", "外壁厚度"),
    (r"under size the bin top", "顶部余量"),
    (r"Fill in solid block", "填实"),
    (r"Remove some or all of lip", "边沿设置"),
    # Lip parameters
    (r"Style of the cup lip", "边沿样式"),
    (r"Below this the inside of the lip", "内沿收缩阈值"),
    (r"Create a relief", "边沿镂空高度"),
    (r"how much of the lip to retain", "边沿镂空宽度"),
    (r"add a notch to the lip", "防滑凸起"),
    (r"enable lip clip", "连接卡扣"),
    (r"allow stacking when bin", "非标准尺寸堆叠"),
    # Subdivisions
    (r"Wall thickness \[bottom, top\]", "隔壁厚度"),
    (r"Radius of the top of the chamber wall", "隔壁顶部圆角"),
    (r"Reduce the wall height by this amount", "隔壁顶部余量"),
    (r"X dimension subdivisions", "X轴分隔数"),
    (r"Enable irregular subdivisions", "启用不规则分隔"),
    (r"Separator positions are defined", "分隔位置配置"),
    # Base / Magnets
    (r"Enable magnets$", "启用磁铁"),
    (r"Enable magnets in the bin corner", "启用角落磁铁"),
    (r"Enable screws$", "启用螺丝"),
    (r"Enable screws in the bin corner", "角落螺丝"),
    (r"size of magnet, diameter and height\. Zacks", "磁铁尺寸"),
    (r"size of magnet, diameter and height", "磁铁尺寸"),
    (r"create relief for magnet removal", "磁铁取出槽"),
    (r"Use with captive magnet", "磁铁侧面通道"),
    (r"raise the magnet void", "内嵌磁铁高度"),
    (r"add a wavy pattern to the magnet hole", "磁铁孔波浪纹"),
    (r"add a chamfer to the magent hole", "磁铁孔倒角"),
    (r"raises the magnet, and creates a floor", "磁铁Z轴偏移"),
    (r"raises the magnet, and creates a ceiling", "磁铁顶盖"),
    (r"Method to help remove magnets", "磁铁取出方式"),
    (r"size of screw, diameter and height", "螺丝尺寸"),
    (r"size of center magnet", "中心磁铁尺寸"),
    (r"Sequential Bridging hole overhang remedy", "悬空孔补偿"),
    (r"Only add attachments.*to box corners", "仅角落安装磁铁螺丝"),
    (r"Only add attachments.*to chest corners", "仅角落安装磁铁螺丝"),
    (r"Minimum thickness above cutouts in base", "底板最小厚度"),
    (r"Efficient floor option", "省材底板"),
    (r"AKA half pitch", "底部网格细分"),
    (r"Removes the internal grid from base", "平整底部"),
    (r"Remove floor to create a vertical spacer", "作为垫片"),
    (r"Adjust the radius of the rounded flat base", "平底圆角半径"),
    (r"Add chamfer to the rounded bottom corner", "平底打印辅助"),
    (r"grid position x", "网格X对齐"),
    (r"grid position y", "网格Y对齐"),
    (r"Pads smaller than this", "最小打印底脚"),
    (r"Enable hold down screw in the center", "中心固定螺丝"),
    (r"Enable cavity to place frame weights", "配重腔"),
    (r"Removes the bottom taper", "移除底部锥角"),
    # Label
    (r"Include overhang for labeling", "标签位置"),
    (r"Enable labels on internal divider walls", "隔板标签"),
    (r"Width, Depth, Height, Radius.*Width in Gridfinity", "标签尺寸"),
    (r"Size in mm of relief where appropriate", "标签浮雕尺寸"),
    (r"wall to enable on, front, back, left, right", "启用墙面"),
    # Finger slide
    (r"Include larger corner fillet", "取物圆角"),
    (r"Radius of the corner fillet", "圆角半径"),
    (r"Align the fingerslide with the lip", "与边沿对齐"),
    # Tapered corner
    (r"Set back of the tapered corner", "斜角退缩量"),
    # Wall pattern
    (r"Grid wall patter", "墙体图案"),
    (r"Style of the pattern", "图案样式"),
    (r"Spacing between pattern", "图案间距"),
    (r"rotate the grid", "旋转网格"),
    (r"Size of the hole", "孔尺寸"),
    (r"Add the pattern to the dividers", "隔板图案"),
    (r"Number of sides of the hole op", "孔形状边数"),
    (r"Radius of corners", "孔圆角半径"),
    (r"pattern fill mode", "图案填充模式"),
    (r"border around the wall pattern", "图案边框"),
    (r"depth of imprint in mm", "图案深度"),
    (r"grid pattern hole taper", "网格孔倒角"),
    (r"voronoi pattern noise", "Voronoi噪点"),
    (r"brick pattern center weight", "砖形图案权重"),
    (r"\$fs for floor pattern", "图案质量"),
    (r"enable Grid floor patter", "启用底板图案"),
    (r"wall pattern border width", "图案边框宽度"),
    # Wall cutout
    (r"wallcoutout position", "镂空位置"),
    (r"default will be binwidth", "镂空宽度"),
    (r"default will be binHeight", "镂空高度"),
    # Extendable
    (r"Tab size, height, width, thickness", "连接片尺寸"),
    # Bottom text
    (r"Add bin size to bin bottom", "底部尺寸文字"),
    (r"Font Size of text", "字体大小"),
    (r"Depth of text, in mm", "文字深度"),
    (r"Offset of text", "文字偏移"),
    (r"Font to use", "字体"),
    (r"Add free-form text line to bin bottom", "底部自定义文字"),
    (r"Actual text to add", "文字内容"),
    # Debug
    (r"Debug slice", "调试切片"),
    (r"Enable loging of help messages", "调试日志"),
    # Model detail
    (r"Work in progress.*Modify the default grid size", "网格尺寸"),
    (r"clearance around the bin", "配合间隙"),
    (r"Assign colours to the bin", "颜色显示"),
    (r"Where to render the model", "渲染位置"),
    (r"[Mm]inimum angle for a fragment", "最小角度精度"),
    (r"[Mm]inimum size of a fragment", "最小面精度"),
    (r"number of fragments, overrides", "段数精度"),
    (r"set random seed for", "随机种子"),
    (r"force render on costly components", "强制渲染"),
    # Drawers specific
    (r"select what to render", "渲染对象"),
    (r"Inner width of drawer", "抽屉内宽"),
    (r"Inner depth of drawer", "抽屉内深"),
    (r"Inner height of drawer", "抽屉内高"),
    (r"Number of drawers", "抽屉数量"),
    (r"Add clearance inside the drawers", "抽屉配合间隙"),
    (r"Add clearance inside the chest", "柜体配合间隙"),
    (r"Wall thickness of the chest", "柜体壁厚"),
    (r"Thickness of drawer slides", "抽屉滑轨厚度"),
    (r"Width of drawer sli", "抽屉滑轨宽度"),
    (r"Handle size", "拉手尺寸"),
    # Tray specific
    (r"Height above the base height", "托盘离地高度"),
    (r"Debug, Color Compartments", "调试：分区着色"),
    (r"Debug, Highlight Compartments", "调试：高亮分区"),
    # Item holder
    (r"Enlarge the holes by this amount for clearance", "孔配合间隙"),
    (r"Depth of hole, Overrides", "孔深度"),
    (r"45 deg chamfer added to the top", "孔顶部倒角"),
    (r"Render just a sample of the item hole", "样品模式"),
    (r"Wall thickness of the sample", "样品壁厚"),
    (r"cards to use when multi card is selected", "多卡卡种"),
    (r"Force nesting of multi cards", "多卡紧凑排列"),
    (r"Should the grid be square or hex", "网格样式"),
    (r"The number of sides for a round hole", "孔边数"),
    (r"Diameter of, round hole", "孔直径"),
    (r"Radius of the bottom of the custom shape", "孔底圆角"),
    (r"The size the hole", "孔尺寸"),
    (r"Spacing around the holes", "孔间距"),
    (r"Number of holes in the x and y dimension", "X方向孔数"),
    (r"Number of holes in the y dimension", "Y方向孔数"),
    (r"Auto set the bin height based on the hole size", "自动高度"),
    (r"Spacing around the compartments", "分区间距"),
    (r"Center the holes within the compartments", "居中对齐"),
    # Baseplate specific
    (r"Plate Style", "底板样式"),
    (r"Reduce the frame wall size to this value", "框架壁高"),
    (r"spread out the plates", "均匀分布板块"),
    (r"Will split the plate", "分割板块"),
    # Sliding lid specific
    (r"Add text to the sliding lid top", "滑盖文字"),
    (r"Text to display on the lid", "盖面文字内容"),
    (r"Font size for the lid text", "字体大小"),
    (r"Depth of text engraving in mm", "文字深度"),
    (r"Font for the lid text", "字体"),
    (r"Text position on lid", "文字位置"),
]


def translate_section_header(line):
    """Translate /* [Section Name] */ lines."""
    m = re.match(r'^(\s*/\*\s*\[)(.*?)(\]\s*\*/\s*)$', line)
    if not m:
        return line
    prefix, section, suffix = m.group(1), m.group(2), m.group(3)
    # Check if already translated (contains Chinese characters)
    if re.search(r'[\u4e00-\u9fff]', section):
        return line
    # Look up translation
    if section in SECTION_TRANSLATIONS:
        zh = SECTION_TRANSLATIONS[section]
        return f"{prefix}{zh} / {section}{suffix}"
    return line


def translate_comment_line(line):
    """Translate // comment lines that describe parameters."""
    # Match comment lines (with optional leading spaces)
    m = re.match(r'^(\s*//+\s*)(.*?)(\s*)$', line)
    if not m:
        return line
    comment_prefix = m.group(1)
    comment_text = m.group(2)
    trailing = m.group(3)

    # Skip empty comments or already-translated ones
    if not comment_text.strip():
        return line
    if re.search(r'[\u4e00-\u9fff]', comment_text):
        return line
    # Skip lines that look like code/directives
    if comment_text.startswith('[') or comment_text.startswith('<') or comment_text.startswith('$'):
        return line

    for pattern, zh_prefix in COMMENT_TRANSLATIONS:
        if re.search(pattern, comment_text, re.IGNORECASE):
            return f"{comment_prefix}{zh_prefix} / {comment_text}{trailing}"

    return line


def translate_file(filepath):
    """Translate a single SCAD file in-place."""
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    changed = False
    new_lines = []
    for line in lines:
        stripped = line.rstrip('\n')
        new_stripped = translate_section_header(stripped)
        if new_stripped == stripped:
            new_stripped = translate_comment_line(stripped)
        if new_stripped != stripped:
            changed = True
        new_lines.append(new_stripped + '\n' if line.endswith('\n') else new_stripped)

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Translated: {filepath}")
    else:
        print(f"No changes: {filepath}")

    return changed


def main():
    workspace = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    scad_files = glob.glob(os.path.join(workspace, '*.scad'))
    total_changed = 0
    for f in sorted(scad_files):
        if translate_file(f):
            total_changed += 1
    print(f"\nDone. {total_changed}/{len(scad_files)} files translated.")


if __name__ == '__main__':
    main()
