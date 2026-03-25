#!/usr/bin/env python3
"""
Translate OpenSCAD parameter comments from English to Chinese.
Chinese translation is placed BEFORE English, separated by " / ".
Example: "X dimension" -> "X轴 / X dimension"
"""

import re
import sys

# Translation dictionary for common terms
TRANSLATIONS = {
    # Dimensions
    r'\bX dimension\b': 'X轴 / X dimension',
    r'\bY dimension\b': 'Y轴 / Y dimension',
    r'\bZ dimension\b': 'Z轴 / Z dimension',
    r'\bX outer dimension\b': 'X轴外尺寸 / X outer dimension',
    r'\bY outer dimension\b': 'Y轴外尺寸 / Y outer dimension',
    r'\bz outer dimension\b': 'Z轴外尺寸 / z outer dimension',
    r'\bgrid units \(multiples of 42mm\) or mm\b': '网格单位（42mm倍数）或mm',
    r'\bGrid units \(multiples of 42mm\) or mm\b': '网格单位（42mm倍数）或mm',
    r'\bZ dimension excluding\b': 'Z轴高度（不含） / Z dimension excluding',
    r'\bgrid units \(multiples of 7mm\) or mm\b': '网格单位（7mm倍数）或mm',

    # Wall thickness
    r'\bWall thickness of outer walls\b': '外壁厚度 / Wall thickness of outer walls',
    r'\bwall_thickness\b': '壁厚 / wall_thickness',
    r'\bWall thickness\b': '壁厚 / Wall thickness',
    r'\bwall thickness\b': '壁厚 / wall thickness',

    # Cup/Base
    r'\bFill in solid block \(overrides all following options\)\b': '填充实心块（覆盖以下所有选项） / Fill in solid block',
    r'\bunder size the bin top by this amount to allow for better stacking\b': '收缩顶部尺寸以便叠放 / under size the bin top',
    r'\bEnable magnets\b': '启用磁铁 / Enable magnets',
    r'\bEnable screws\b': '启用螺丝 / Enable screws',
    r'\bsize of magnet, diameter and height\b': '磁铁尺寸，直径和高度 / size of magnet, diameter and height',
    r'\bsize of screw, diameter and height\b': '螺丝尺寸，直径和高度 / size of screw, diameter and height',
    r'\bsize of center magnet, diameter and height\b': '中心磁铁尺寸，直径和高度 / size of center magnet, diameter and height',
    r'\bcreate relief for magnet removal\b': '为磁铁取出创建凹槽 / create relief for magnet removal',
    r'\bSequential Bridging hole overhang remedy\b': '顺序桥接悬空修正 / Sequential Bridging hole overhang remedy',
    r'\bOnly add attachments \(magnets and screw\) to box corners\b': '仅在箱角添加附件（磁铁和螺丝） / Only add attachments to box corners',
    r'\bMinimum thickness above cutouts in base\b': '底座镂空上方最小厚度 / Minimum thickness above cutouts in base',
    r'\bEfficient floor option saves material and time\b': '节省材料的底板模式 / Efficient floor option',
    r'\bAKA half pitch\. Enable to subdivide bottom pads\b': '子间距（半间距）/ AKA half pitch',
    r'\bRemoves the internal grid from base the shape\b': '去除底部内部网格 / Removes the internal grid',
    r'\bRemove floor to create a vertical spacer\b': '去除底面以创建垂直间隔 / Remove floor to create a vertical spacer',

    # Lip
    r'\bStyle of the cup lip\b': '杯沿样式 / Style of the cup lip',
    r'\bBelow this the inside of the lip will be reduced for easier access\b': '低于此值将缩减内侧杯沿以便拿取 / Below this the inside of the lip will be reduced',
    r'\bCreate a relief in the lip\b': '在杯沿创建缺口 / Create a relief in the lip',
    r'\badd a notch to the lip to prevent sliding\b': '添加防滑缺口 / add a notch to the lip',
    r'\benable lip clip for connection cups\b': '启用唇夹连接托盒 / enable lip clip',
    r'\ballow stacking when bin is not multiples of 42\b': '非42mm倍数时允许叠放 / allow stacking when bin is not multiples of 42',

    # Subdivisions
    r'\bX dimension subdivisions\b': 'X轴分隔数 / X dimension subdivisions',
    r'\bEnable irregular subdivisions\b': '启用不规则分隔 / Enable irregular subdivisions',
    r'\bSeparator positions are defined in terms of grid units from the left end\b': '分隔位置以网格单位从左端定义 / Separator positions',
    r'\bReduce the wall height by this amount\b': '减少隔壁高度 / Reduce the wall height',
    r'\bRadius of the top of the chamber wall\b': '隔室顶部圆角 / Radius of the top of the chamber wall',

    # Label
    r'\bInclude overhang for labeling\b': '包含标签悬挑 / Include overhang for labeling',
    r'\bEnable labels on internal divider walls\b': '在内部隔板上启用标签 / Enable labels on internal divider walls',

    # Sliding lid
    r'\bselect what to render\b': '选择渲染内容 / select what to render',
    r'\bAdd text to the sliding lid top\b': '在滑盖顶部添加文字 / Add text to the sliding lid top',
    r'\bText to display on the lid\b': '盖子上显示的文字 / Text to display on the lid',
    r'\bFont size for the lid text\b': '盖子文字字号 / Font size for the lid text',
    r'\bDepth of text engraving in mm\b': '文字雕刻深度（mm） / Depth of text engraving',
    r'\bFont for the lid text\b': '盖子文字字体 / Font for the lid text',
    r'\bText position on lid\b': '文字在盖子上的位置 / Text position on lid',

    # Finger slide
    r'\bInclude larger corner fillet\b': '添加大圆角（手指滑动槽） / Include larger corner fillet',
    r'\bRadius of the corner fillet\b': '圆角半径 / Radius of the corner fillet',
    r'\bAlign the fingerslide with the lip\b': '指滑槽与杯沿对齐 / Align the fingerslide with the lip',

    # Tapered corner
    r'\bSet back of the tapered corner, default is the gridfinity corner radius\b': '锥形角退缩量 / Set back of the tapered corner',

    # Wall pattern
    r'\bGrid wall patter\b': '墙面图案 / Grid wall pattern',
    r'\bStyle of the pattern\b': '图案样式 / Style of the pattern',
    r'\bSpacing between pattern\b': '图案间距 / Spacing between pattern',
    r'\bwall to enable on, front, back, left, right\b': '启用墙面，前、后、左、右 / wall to enable on, front, back, left, right',
    r'\brotate the grid\b': '旋转网格 / rotate the grid',
    r'\bSize of the hole\b': '孔尺寸 / Size of the hole',
    r'\bAdd the pattern to the dividers\b': '将图案添加到分隔板 / Add the pattern to the dividers',
    r'\bNumber of sides of the hole op\b': '孔的边数 / Number of sides of the hole',
    r'\bRadius of corners\b': '圆角半径 / Radius of corners',
    r'\bpattern fill mode\b': '图案填充模式 / pattern fill mode',
    r'\bborder around the wall pattern, default is wall thickness\b': '图案边框宽度（默认为壁厚） / border around the wall pattern',
    r'\bdepth of imprint in mm, 0 = is wall width\b': '浮雕深度（mm），0表示整个壁厚 / depth of imprint',
    r'\bgrid pattern hole taper\b': '网格图案孔锥角 / grid pattern hole taper',
    r'\bvoronoi pattern noise,\b': 'Voronoi图案噪声 / voronoi pattern noise',
    r'\bbrick pattern center weight\b': '砖块图案中心权重 / brick pattern center weight',
    r'\bpattern quality\b': '图案质量 / pattern quality',

    # Floor pattern
    r'\benable Grid floor patter\b': '启用底面图案 / enable Grid floor pattern',

    # Wall cutout
    r'\bwallcoutout position\b': '墙切口位置 / wallcutout position',
    r'\bdefault will be binwidth/2\b': '默认为托盒宽度/2 / default will be binwidth/2',
    r'\bdefault will be binHeight\b': '默认为托盒高度 / default will be binHeight',

    # Extendable
    r'\bTab size, height, width, thickness, style\b': '卡扣尺寸，高、宽、厚、样式 / Tab size, height, width, thickness, style',

    # Bottom text
    r'\bAdd bin size to bin bottom\b': '在底部添加托盒尺寸 / Add bin size to bin bottom',
    r'\bFont Size of text, in mm\b': '文字字号（mm） / Font Size of text',
    r'\bDepth of text, in mm\b': '文字深度（mm） / Depth of text',
    r'\bOffset of text , in mm\b': '文字偏移（mm） / Offset of text',
    r'\bFont to use\b': '使用字体 / Font to use',
    r'\bAdd free-form text line to bin bottom\b': '在底部添加自定义文字 / Add free-form text line to bin bottom',
    r'\bActual text to add\b': '要添加的文字 / Actual text to add',

    # Debug/model detail
    r'\bDebug slice\b': '调试切片 / Debug slice',
    r'\bEnable loging of help messages during render\b': '渲染时启用帮助日志 / Enable logging of help messages',
    r'\bEnable logging of help messages during render\b': '渲染时启用帮助日志 / Enable logging of help messages',
    r'\benable loging of help messages during render\b': '渲染时启用帮助日志 / enable logging of help messages',
    r'\bWork in progress,  Modify the default grid size\. Will break compatibility\b': '修改默认网格尺寸（实验性，影响兼容性） / Work in progress, Modify the default grid size',
    r'\bclearance around the bin, will reduce the bin by this amount in mm\b': '托盒间隙（mm） / clearance around the bin',
    r'\bAssign colours to the bin\b': '为托盒指定颜色 / Assign colours to the bin',
    r'\bWhere to render the model\b': '模型渲染位置 / Where to render the model',
    r'\bMinimum angle for a fragment\b': '片段最小角度 / Minimum angle for a fragment',
    r'\bminimum angle for a fragment\b': '片段最小角度 / minimum angle for a fragment',
    r'\bminimum size of a fragment\b': '片段最小尺寸 / minimum size of a fragment',
    r'\bnumber of fragments, overrides \$fa and \$fs\b': '片段数量（覆盖$fa和$fs） / number of fragments',
    r'\bset random seed for\b': '随机种子 / set random seed for',
    r'\bforce render on costly components\b': '强制渲染复杂组件 / force render on costly components',

    # Baseplate specific
    r'\bPlate Style\b': '底板样式 / Plate Style',
    r'\boversize_method\b': '超尺寸处理方式 / oversize_method',
    r'\bEnable magnets in the bin corner\b': '在托盒角落启用磁铁 / Enable magnets in the bin corner',
    r'\braises the magnet, and creates a floor \(for gluing\)\b': '抬高磁铁并创建胶合底座 / raises the magnet and creates a floor',
    r'\braises the magnet, and creates a ceiling to capture the magnet\b': '抬高磁铁并创建固定顶盖 / raises the magnet and creates a ceiling',
    r'\bMethod to help remove magnets\b': '磁铁取出辅助方式 / Method to help remove magnets',
    r'\bEnable hold down screw in the center\b': '在中心启用固定螺丝 / Enable hold down screw in the center',
    r'\bEnable cavity to place frame weights\b': '启用配重腔 / Enable cavity to place frame weights',
    r'\bRemoves the bottom taper\b': '去除底部锥面 / Removes the bottom taper',
    r'\bReduce the frame wall size to this value\b': '将框架墙高减小到此值 / Reduce the frame wall size to this value',
    r'\bCorner radius for the inner corners\b': '内角圆角半径 / Corner radius for the inner corners',
    r'\bspread out the plates, use if last row is small\b': '展开底板（最后一行较小时使用） / spread out the plates',
    r'\bWill split the plate in to the\b': '将底板分割 / Will split the plate',

    # Drawer specific
    r'\bInner width of drawer in Gridfinity units\b': '抽屉内宽（Gridfinity单位） / Inner width of drawer',
    r'\bInner depth of drawer in Gridfinity units\b': '抽屉内深（Gridfinity单位） / Inner depth of drawer',
    r'\bInner height of drawer in Gridfinity units\b': '抽屉内高（Gridfinity单位） / Inner height of drawer',
    r'\bNumber of drawers\b': '抽屉数量 / Number of drawers',
    r'\bAdd clearance inside the drawers for the bins\b': '为托盒添加抽屉内间隙 / Add clearance inside the drawers',
    r'\bAdd clearance inside the chest for the drawer\b': '为抽屉添加柜体内间隙 / Add clearance inside the chest',
    r'\bWall thickness of the chest\b': '柜体壁厚 / Wall thickness of the chest',
    r'\bThickness of drawer slides in mm\b': '抽屉滑轨厚度（mm） / Thickness of drawer slides',
    r'\bWidth of drawer slies in mm\b': '抽屉滑轨宽度（mm） / Width of drawer slides',
    r'\bHandle size width, depth, height, and radius\b': '手柄尺寸（宽、深、高、圆角） / Handle size width, depth, height, and radius',
    r'\bwall pattern border width\b': '墙面图案边框宽度 / wall pattern border width',

    # Lid specific
    r'\bBase height, when the bin on top will sit, in GF units\b': '基准高度（GF单位） / Base height',
    r'\bThickness of the efficient floor\b': '节省材料底板厚度 / Thickness of the efficient floor',
    r'\bSlice along the x axis\b': '沿X轴切片 / Slice along the x axis',
    r'\bSlice along the y axis\b': '沿Y轴切片 / Slice along the y axis',
    r'\bassign colours to the bin\b': '为托盒指定颜色 / assign colours to the bin',
    r'\bwhere to render the model\b': '模型渲染位置 / where to render the model',

    # Item holder
    r'\bEnlarge the holes by this amount for clearance\b': '扩大孔尺寸以保证间隙 / Enlarge the holes for clearance',
    r'\bDepth of hole, Overrides the known item depth\b': '孔深度，覆盖预设物品深度 / Depth of hole',
    r'\b45 deg chamfer added to the top of the hole\b': '孔顶部45度倒角 / 45 deg chamfer at top of hole',
    r'\bRender just a sample of the item hole\b': '仅渲染样品孔 / Render just a sample of the item hole',
    r'\bWall thickness of the sample print\b': '样品打印壁厚 / Wall thickness of the sample print',
    r'\bcards to use when multi card is selected\b': '多卡模式下使用的卡片类型 / cards to use when multi card is selected',
    r'\bForce nesting of multi cards\b': '强制多卡嵌套 / Force nesting of multi cards',
    r'\bShould the grid be square or hex\b': '网格形状：方形或六边形 / Should the grid be square or hex',
    r'\bThe number of sides for a round hole\b': '圆孔边数 / The number of sides for a round hole',
    r'\bDiameter of, round hole, or corners for square hole\b': '圆孔直径或方孔角径 / Diameter of round hole',
    r'\bRadius of the bottom of the custom shape\b': '自定义形状底部圆角 / Radius of the bottom of the custom shape',
    r'\bSpacing around the holes\b': '孔间距 / Spacing around the holes',
    r'\bNumber of holes in the x and y dimension\b': 'X和Y方向孔数 / Number of holes in x and y',
    r'\bNumber of holes in the y dimension\b': 'Y方向孔数 / Number of holes in y dimension',
    r'\bAuto set the bin height based on the hole size\b': '根据孔尺寸自动设置托盒高度 / Auto set bin height',
    r'\bSpacing around the compartments\b': '隔室间距 / Spacing around the compartments',
    r'\bCenter the holes within the compartments\b': '在隔室内居中放置孔 / Center the holes within the compartments',

    # Tray specific
    r'\bHeight above the base height\b': '高于基准高度的距离 / Height above the base height',
    r'\bDebug, Color Compartments\b': '调试：隔室着色 / Debug, Color Compartments',
    r'\bDebug, Highlight Compartments\b': '调试：高亮隔室 / Debug, Highlight Compartments',
    r'\bA wall placard is a filled-in area or a slot on the outside of a wall for placing a label\b': '墙面标签是用于放置标签的填充区域或插槽 / A wall placard',

    # Misc
    r'\bEnable loging\b': '启用日志 / Enable logging',
    r'\benable loging\b': '启用日志 / enable logging',
    r'\bLogging\b': '日志 / Logging',
    r'\brender choice\b': '渲染选择 / render choice',
    r'\bselect what to render\b': '选择渲染内容 / select what to render',
    r'\bUse with captive magnet for a .refinded style. magnet\b': '配合内嵌磁铁使用（精致风格） / Use with captive magnet',
    r'\braise the magnet void inside the part for print-in-magnets\b': '抬高磁铁内腔用于打印嵌入磁铁 / raise the magnet void',
    r'\badd a wavy pattern to the magnet hole\b': '为磁铁孔添加波纹图案 / add a wavy pattern to the magnet hole',
    r'\badd a chamfer to the magent hole\b': '为磁铁孔添加倒角 / add a chamfer to the magnet hole',
    r'\bAdjust the radius of the rounded flat base\b': '调整平底圆角半径 / Adjust the radius of the rounded flat base',
    r'\bAdd chamfer to the rounded bottom corner to make easier to print\b': '为圆角底部添加倒角以便打印 / Add chamfer to the rounded bottom corner',
    r'\bgrid position x\b': 'X轴网格对齐 / grid position x',
    r'\bgrid position y\b': 'Y轴网格对齐 / grid position y',
    r'\bPads smaller than this will not be rendered\b': '小于此尺寸的凸台将不被渲染 / Pads smaller than this will not be rendered',
}

def translate_comment_text(text):
    """Apply translations to a comment text. Longer patterns are applied first."""
    result = text
    # Sort by pattern length descending to apply more specific patterns first
    sorted_items = sorted(TRANSLATIONS.items(), key=lambda x: len(x[0]), reverse=True)
    for pattern, replacement in sorted_items:
        result = re.sub(pattern, replacement, result)
        if re.search(r'[\u4e00-\u9fff]', result):
            # Once Chinese has been added by a match, stop further substitutions
            # to avoid double-translating
            break
    return result

def process_line(line):
    """Process a single line, adding Chinese translation to comments."""
    # Match lines with a comment at the start: // Some text
    # But don't translate if line already contains Chinese
    if re.search(r'[\u4e00-\u9fff]', line):
        return line  # Already has Chinese, skip

    # Match // comment lines (not code)
    m = re.match(r'^(\s*//\s*)(.+)$', line)
    if m:
        prefix = m.group(1)
        comment_text = m.group(2)
        translated = translate_comment_text(comment_text)
        if translated != comment_text:
            return prefix + translated + '\n'
    return line

def process_file(filepath):
    """Process a single SCAD file."""
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines = []
    changed = False
    for line in lines:
        new_line = process_line(line)
        if new_line != line:
            changed = True
        new_lines.append(new_line)

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Updated: {filepath}")
    else:
        print(f"No changes: {filepath}")

if __name__ == '__main__':
    import glob
    import os
    scad_files = glob.glob('/workspace/*.scad')
    for f in sorted(scad_files):
        process_file(f)
    print("Done.")
