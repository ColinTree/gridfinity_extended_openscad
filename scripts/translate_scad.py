#!/usr/bin/env python3
"""
Translate SCAD file parameter comments to Chinese (prepend Chinese before English).
Format: Chinese / English original
"""

import re
import sys
from pathlib import Path

# Section header translations: [Name] -> [中文 / Name]
SECTION_TRANSLATIONS = {
    "General Cup": "通用设置 / General Cup",
    "Cup Lip": "唇边 / Cup Lip",
    "Subdivisions": "内部分隔 / Subdivisions",
    "Base": "底座 / Base",
    "Label": "标签 / Label",
    "Sliding Lid": "滑动盖 / Sliding Lid",
    "Sliding Cutout": "滑盖开孔 / Sliding Cutout",
    "Sliding Text": "滑盖文字 / Sliding Text",
    "Finger Slide": "手指槽 / Finger Slide",
    "Tapered Corner": "锥形角 / Tapered Corner",
    "Wall Pattern": "墙面图案 / Wall Pattern",
    "Floor Pattern": "底面图案 / Floor Pattern",
    "Wall Cutout": "墙面开孔 / Wall Cutout",
    "Extendable": "可扩展 / Extendable",
    "Bottom Text": "底部文字 / Bottom Text",
    "debug": "调试 / debug",
    "Model detail": "模型细节 / Model detail",
    "model detail": "模型细节 / model detail",
    "Size": "尺寸 / Size",
    "Lid": "盖子 / Lid",
    "Base Plate Options": "底板选项 / Base Plate Options",
    "Lid Options": "盖子选项 / Lid Options",
    "Render": "渲染 / Render",
    "Chest": "抽屉柜 / Chest",
    "Drawer": "抽屉 / Drawer",
    "Chest Top Plate": "柜顶板 / Chest Top Plate",
    "Chest Base": "柜底 / Chest Base",
    "Chest Wall Pattern": "柜壁图案 / Chest Wall Pattern",
    "Item Holder": "物品夹持器 / Item Holder",
    "Item Holder - Sample Item": "物品夹持器 - 样品 / Item Holder - Sample Item",
    "Item Holder - Multi Card": "物品夹持器 - 多卡 / Item Holder - Multi Card",
    "Item Holder - Custom Item": "物品夹持器 - 自定义 / Item Holder - Custom Item",
    "Item Holder - Item Layout": "物品夹持器 - 布局 / Item Holder - Item Layout",
    "Printer bed options": "打印床选项 / Printer bed options",
    "Base Plate Clips": "底板连接件 / Base Plate Clips",
    "Custom Grid": "自定义网格 / Custom Grid",
    "Tray": "托盘 / Tray",
}

# Parameter comment translations: exact match on trimmed comment text -> translated prefix
# Format: search_pattern (prefix of comment) -> replacement (Chinese prefix to prepend)
PARAM_COMMENT_TRANSLATIONS = [
    # Dimensions
    (r"^// X dimension\.", "// X轴 / X dimension."),
    (r"^// Y dimension\.", "// Y轴 / Y dimension."),
    (r"^// Z dimension", "// Z轴 / Z dimension"),
    (r"^// X outer dimension\.", "// X轴外尺寸 / X outer dimension."),
    (r"^// Y outer dimension\.", "// Y轴外尺寸 / Y outer dimension."),
    (r"^// z outer dimension\.", "// Z轴外尺寸 / z outer dimension."),
    (r"^// X outer dimension\.", "// X轴外尺寸 / X outer dimension."),

    # Cup general
    (r"^// Fill in solid block", "// 填实为实心块 / Fill in solid block"),
    (r"^// Wall thickness of outer walls\.", "// 外壁厚度 / Wall thickness of outer walls."),
    (r"^//under size the bin top", "//顶部余量（允许堆叠） / under size the bin top"),
    (r"^// Wall thickness \[bottom, top\]", "// 壁厚 [底部, 顶部] / Wall thickness [bottom, top]"),
    (r"^//Reduce the wall height by this amount$", "//隔间壁高缩减量 / Reduce the wall height by this amount"),
    (r"^// Radius of the top of the chamber wall", "// 隔间壁顶部圆角 / Radius of the top of the chamber wall"),

    # Lip
    (r"^// Style of the cup lip", "// 唇边样式 / Style of the cup lip"),
    (r"^// Below this the inside of the lip will be reduced", "// 唇边内侧减料触发尺寸 / Below this the inside of the lip will be reduced"),
    (r"^// Create a relief in the lip", "// 唇边顶部缺口高度 / Create a relief in the lip"),
    (r"^// Create a relie$", "// 唇边顶部缺口高度 / Create a relie"),
    (r"^// how much of the lip to retain on each end", "// 唇边两端保留比例 / how much of the lip to retain on each end"),
    (r"^// add a notch to the lip to prevent sliding\.", "// 添加唇边防滑凸点 / add a notch to the lip to prevent sliding."),
    (r"^// enable lip clip for connection cups", "// 启用唇边卡扣连接 / enable lip clip for connection cups"),
    (r"^//allow stacking when bin is not multiples of 42", "//非42mm倍数时允许堆叠 / allow stacking when bin is not multiples of 42"),

    # Subdivisions
    (r"^// X dimension subdivisions$", "// X轴分隔数 / X dimension subdivisions"),
    (r"^// Enable irregular subdivisions", "// 启用不规则分隔 / Enable irregular subdivisions"),
    (r"^// Separator positions are defined in terms of grid units from the left end", "// 分隔板位置（从左端起的网格单位） / Separator positions are defined in terms of grid units from the left end"),

    # Base / Magnets / Screws
    (r"^// Enable magnets$", "// 启用磁铁 / Enable magnets"),
    (r"^// Enable screws$", "// 启用螺丝 / Enable screws"),
    (r"^//size of magnet, diameter and height\.", "//磁铁尺寸（直径和高度） / size of magnet, diameter and height."),
    (r"^//create relief for magnet removal", "//磁铁取出缺口 / create relief for magnet removal"),
    (r"^// Use with captive magnet for a 'refinded style' magnet", "// 嵌入式磁铁侧面开口 / Use with captive magnet for a 'refinded style' magnet"),
    (r"^// raise the magnet void inside the part for print-in-magnets", "// 磁铁空腔抬高（打印时嵌入磁铁） / raise the magnet void inside the part for print-in-magnets"),
    (r"^// add a wavy pattern to the magnet hole", "// 磁铁孔波浪纹（增加过盈配合） / add a wavy pattern to the magnet hole"),
    (r"^// add a chamfer to the magent hole", "// 磁铁孔倒角 / add a chamfer to the magent hole"),
    (r"^//size of screw, diameter and height\.", "//螺丝尺寸（直径和高度） / size of screw, diameter and height."),
    (r"^//size of center magnet, diameter and height\.", "//中心磁铁尺寸（直径和高度） / size of center magnet, diameter and height."),
    (r"^// Sequential Bridging hole overhang remedy", "// 桥接过渡孔悬空补救方式 / Sequential Bridging hole overhang remedy"),
    (r"^//Only add attachments \(magnets and screw\) to box corners", "//仅在角落添加磁铁/螺丝（加快打印） / Only add attachments (magnets and screw) to box corners"),
    (r"^//Only add attachments \(magnets and screw\) to chest corners", "//仅在角落添加磁铁/螺丝（加快打印） / Only add attachments (magnets and screw) to chest corners"),
    (r"^// Minimum thickness above cutouts in base", "// 底座开孔上方最小厚度 / Minimum thickness above cutouts in base"),
    (r"^// Efficient floor option saves material and time", "// 高效底板（省料省时，但底面不平整） / Efficient floor option saves material and time"),
    (r"^// AKA half pitch\.", "// 半间距（细分底部格）/ AKA half pitch."),
    (r"^// Removes the internal grid from base the shape", "// 移除底座内部网格 / Removes the internal grid from base the shape"),
    (r"^// Remove floor to create a vertical spacer", "// 移除底板以创建垫片 / Remove floor to create a vertical spacer"),
    (r"^//Pads smaller than this will not be rendered", "//小于此尺寸的底脚不渲染 / Pads smaller than this will not be rendered"),
    (r"^// Adjust the radius of the rounded flat base\.", "// 圆形平底半径（-1 使用角半径） / Adjust the radius of the rounded flat base."),
    (r"^// Add chamfer to the rounded bottom corner", "// 圆底角倒角（便于打印） / Add chamfer to the rounded bottom corner"),
    (r"^// grid position x$", "// 网格对齐方向 X / grid position x"),
    (r"^// grid position y$", "// 网格对齐方向 Y / grid position y"),

    # Label
    (r"^// Include overhang for labeling", "// 标签悬出方向 / Include overhang for labeling"),
    (r"^// Width, Depth, Height, Radius\. Width in Gridfinity units", "// 标签尺寸（宽度/深度/高度/圆角） / Width, Depth, Height, Radius. Width in Gridfinity units"),
    (r"^// Enable labels on internal divider walls", "// 启用内部分隔板标签 / Enable labels on internal divider walls"),
    (r"^// Size in mm of relief where appropriate\.", "// 标签浮雕尺寸（mm） / Size in mm of relief where appropriate."),
    (r"^// wall to enable on, front, back, left, right\. 0: disabled; 1: enabled;$", "// 启用标签的墙面（前/后/左/右，0关闭 1开启） / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;"),

    # Sliding lid
    (r"^// select what to render$", "// 选择渲染内容 / select what to render"),
    (r"^// 0 = wall thickness \*2$", "// 滑盖厚度（0=壁厚x2） / 0 = wall thickness *2"),
    (r"^// 0 = wall_thickness/2$", "// 滑盖最小壁厚（0=壁厚/2） / 0 = wall_thickness/2"),
    (r"^// 0 = default_sliding_lid_thickness/2$", "// 滑盖最小支撑（0=盖厚/2） / 0 = default_sliding_lid_thickness/2"),
    (r"^// Add text to the sliding lid top$", "// 在滑盖顶部添加文字 / Add text to the sliding lid top"),
    (r"^// Text to display on the lid$", "// 滑盖显示文字 / Text to display on the lid"),
    (r"^// Font size for the lid text", "// 滑盖文字字号 / Font size for the lid text"),
    (r"^// Depth of text engraving in mm$", "// 文字雕刻深度（mm） / Depth of text engraving in mm"),
    (r"^// Font for the lid text$", "// 滑盖文字字体 / Font for the lid text"),
    (r"^// Text position on lid", "// 文字在滑盖上的位置 / Text position on lid"),

    # Finger slide
    (r"^// Include larger corner fillet$", "// 添加较大圆角（手指槽） / Include larger corner fillet"),
    (r"^// Radius of the corner fillet, 0:none", "// 圆角半径 / Radius of the corner fillet, 0:none"),
    (r"^// wall to enable on, front, back, left, right\. 0: disabled; 1: enabled using radius", "// 启用手指槽的墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius"),
    (r"^//Align the fingerslide with the lip$", "//手指槽与唇边对齐 / Align the fingerslide with the lip"),

    # Tapered corner
    (r"^// Set back of the tapered corner, default is the gridfinity corner radius", "// 锥形角退让量（默认为圆角半径） / Set back of the tapered corner, default is the gridfinity corner radius"),

    # Wall Pattern
    (r"^// Grid wall patter$", "// 启用网格墙面图案 / Grid wall patter"),
    (r"^// Style of the pattern$", "// 图案样式 / Style of the pattern"),
    (r"^// Spacing between pattern$", "// 图案间距 / Spacing between pattern"),
    (r"^// wall to enable on, front, back, left, right\.$", "// 启用图案的墙面（前/后/左/右） / wall to enable on, front, back, left, right."),
    (r"^// rotate the grid$", "// 旋转图案网格 / rotate the grid"),
    (r"^//Size of the hole$", "//孔洞尺寸 / Size of the hole"),
    (r"^// Add the pattern to the dividers$", "// 将图案应用到分隔板 / Add the pattern to the dividers"),
    (r"^//Number of sides of the hole op$", "//孔洞边数 / Number of sides of the hole op"),
    (r"^//Radius of corners$", "//孔洞圆角半径 / Radius of corners"),
    (r"^// pattern fill mode$", "// 图案填充模式 / pattern fill mode"),
    (r"^// border around the wall pattern, default is wall thickness$", "// 图案边框宽度（默认为壁厚） / border around the wall pattern, default is wall thickness"),
    (r"^// depth of imprint in mm, 0 = is wall width\.$", "// 图案压印深度（mm，0=全壁厚） / depth of imprint in mm, 0 = is wall width."),
    (r"^//grid pattern hole taper$", "//网格图案孔倒角 / grid pattern hole taper"),
    (r"^//voronoi pattern noise,$", "//Voronoi图案噪声 / voronoi pattern noise,"),
    (r"^//brick pattern center weight$", "//砖块图案中心权重 / brick pattern center weight"),
    (r"^/\$fs for floor pattern, min size face\.$", "//$fs图案精度（面最小尺寸） / $fs for floor pattern, min size face."),

    # Floor pattern
    (r"^// enable Grid floor patter$", "// 启用底面图案 / enable Grid floor patter"),

    # Wall cutout
    (r"^// wallcoutout position -0\.5: disabled;", "// 开孔位置（-0.5:禁用，正数:GF单位，负数:比例）/ wallcoutout position -0.5: disabled;"),
    (r"^//default will be binwidth/2$", "//开孔宽度（默认=箱宽/2） / default will be binwidth/2"),
    (r"^//default will be binHeight\. 0: radius", "//开孔高度（默认=箱高）/ default will be binHeight. 0: radius"),
    (r"^//default will be binHeight$", "//开孔高度（默认=箱高） / default will be binHeight"),

    # Extendable
    (r"^//Tab size, height, width, thickness, style\.", "//延伸卡扣尺寸（高/宽/厚/样式） / Tab size, height, width, thickness, style."),

    # Bottom text
    (r"^// Add bin size to bin bottom$", "// 在底部添加尺寸文字 / Add bin size to bin bottom"),
    (r"^// Font Size of text, in mm", "// 文字字号（mm，0自动） / Font Size of text, in mm"),
    (r"^// Size of text, in mm$", "// 文字字号（mm） / Size of text, in mm"),
    (r"^// Depth of text, in mm$", "// 文字深度（mm） / Depth of text, in mm"),
    (r"^// Offset of text , in mm$", "// 文字偏移量（mm） / Offset of text , in mm"),
    (r"^// Font to use$", "// 使用字体 / Font to use"),
    (r"^// Add free-form text line to bin bottom", "// 在底部添加自定义文字 / Add free-form text line to bin bottom"),
    (r"^// Actual text to add$", "// 自定义文字内容 / Actual text to add"),

    # Debug / Model detail
    (r"^// Debug slice$", "// 调试切片 / Debug slice"),
    (r"^// Enable loging of help messages during render\.$", "// 渲染时输出帮助信息 / Enable loging of help messages during render."),
    (r"^// enable loging of help messages during render\.$", "// 渲染时输出帮助信息 / enable loging of help messages during render."),
    (r"^// enable loging of help messages during render\.$", "// 渲染时输出帮助信息 / enable loging of help messages during render."),
    (r"^//Work in progress,  Modify the default grid size\. Will break compatibility$", "//（实验性）修改默认网格尺寸，会影响兼容性 / Work in progress,  Modify the default grid size. Will break compatibility"),
    (r"^// Work in progress,  Modify the default grid size\. Will break compatibility$", "// （实验性）修改默认网格尺寸，会影响兼容性 / Work in progress,  Modify the default grid size. Will break compatibility"),
    (r"^// clearance around the bin, will reduce the bin by this amount in mm\.$", "// 收纳盒间隙（mm） / clearance around the bin, will reduce the bin by this amount in mm."),
    (r"^// Assign colours to the bin$", "// 为收纳盒着色 / Assign colours to the bin"),
    (r"^//assign colours to the bin$", "//为收纳盒着色 / assign colours to the bin"),
    (r"^// Where to render the model$", "// 模型渲染位置 / Where to render the model"),
    (r"^//where to render the model$", "//模型渲染位置 / where to render the model"),
    (r"^// Minimum angle for a fragment", "// 最小圆弧角度（越小越精细） / Minimum angle for a fragment"),
    (r"^// minimum angle for a fragment", "// 最小圆弧角度（越小越精细） / minimum angle for a fragment"),
    (r"^// minimum size of a fragment\.", "// 最小面尺寸（越小越精细） / minimum size of a fragment."),
    (r"^// number of fragments, overrides \$fa and \$fs$", "// 圆弧段数（覆盖 $fa 和 $fs） / number of fragments, overrides $fa and $fs"),
    (r"^// set random seed for$", "// 随机种子 / set random seed for"),
    (r"^// force render on costly components$", "// 强制渲染高代价组件 / force render on costly components"),

    # Baseplate specific
    (r"^// Plate Style$", "// 底板样式 / Plate Style"),
    (r"^// Enable magnets in the bin corner$", "// 启用磁铁（位于角落） / Enable magnets in the bin corner"),
    (r"^//size of magnet, diameter and height\. Zacks original used 6\.5 and 2\.4$", "//磁铁尺寸（直径和高度） / size of magnet, diameter and height. Zacks original used 6.5 and 2.4"),
    (r"^//raises the magnet, and creates a floor \(for gluing\)$", "//磁铁抬高并添加底板（用于粘合） / raises the magnet, and creates a floor (for gluing)"),
    (r"^//raises the magnet, and creates a ceiling to capture the magnet$", "//磁铁抬高并添加顶盖（固定磁铁） / raises the magnet, and creates a ceiling to capture the magnet"),
    (r"^// \[Magnet Release Options\]$", "// [磁铁取出选项] / [Magnet Release Options]"),
    (r"^// Method to help remove magnets:", "// 磁铁取出辅助方式 / Method to help remove magnets:"),
    (r"^//Enable screws in the bin corner under the magnets$", "//在磁铁下方启用螺丝 / Enable screws in the bin corner under the magnets"),
    (r"^//Enable hold down screw in the center$", "//启用中心固定螺丝 / Enable hold down screw in the center"),
    (r"^//Enable cavity to place frame weights$", "//启用配重腔 / Enable cavity to place frame weights"),
    (r"^//Removes the bottom taper$", "//移除底部锥角 / Removes the bottom taper"),
    (r"^//Reduce the frame wall size to this value$", "//将框架壁高度减小到此值 / Reduce the frame wall size to this value"),

    # Lid specific
    (r"^// Base height, when the bin on top will sit, in GF units$", "// 底座高度（收纳盒放置高度，GF单位） / Base height, when the bin on top will sit, in GF units"),
    (r"^// Thickness of the efficient floor$", "// 高效底板厚度 / Thickness of the efficient floor"),

    # Drawer specific
    (r"^//Inner width of drawer in Gridfinity units$", "//抽屉内部宽度（GF单位） / Inner width of drawer in Gridfinity units"),
    (r"^//Inner depth of drawer in Gridfinity units$", "//抽屉内部深度（GF单位） / Inner depth of drawer in Gridfinity units"),
    (r"^//Inner height of drawer in Gridfinity units$", "//抽屉内部高度（GF单位） / Inner height of drawer in Gridfinity units"),
    (r"^//Number of drawers$", "//抽屉数量 / Number of drawers"),
    (r"^//Inner height of drawer in Gridfinity units\. Edit in script for more than 4 items\.$", "//各抽屉高度（GF单位，超过4个需编辑脚本） / Inner height of drawer in Gridfinity units. Edit in script for more than 4 items."),
    (r"^//Add clearance inside the drawers for the bins\.", "//收纳盒与抽屉内壁间隙（宽/深/高） / Add clearance inside the drawers for the bins."),
    (r"^//Add clearance inside the chest for the drawer\.", "//抽屉与抽屉柜间隙（宽/深/高） / Add clearance inside the chest for the drawer."),
    (r"^//Wall thickness of the chest\.$", "//抽屉柜壁厚 / Wall thickness of the chest."),
    (r"^//Thickness of drawer slides in mm\. 0 is uses wall thickness\.$", "//抽屉滑轨厚度（mm，0=壁厚） / Thickness of drawer slides in mm. 0 is uses wall thickness."),
    (r"^//Width of drawer slies in mm\. 0 is full chest width\.$", "//抽屉滑轨宽度（mm，0=全宽） / Width of drawer slies in mm. 0 is full chest width."),
    (r"^// Handle size width, depth, height, and radius\.", "// 把手尺寸（宽/深/高/圆角） / Handle size width, depth, height, and radius."),
    (r"^// wall pattern border width\.", "// 图案边框宽度 / wall pattern border width."),

    # Item holder
    (r"^// Enlarge the holes by this amount for clearance$", "// 孔洞扩大量（配合间隙） / Enlarge the holes by this amount for clearance"),
    (r"^// Depth of hole, Overrides the known item depth\. Limited by floor height\.$", "// 孔洞深度（覆盖已知物品深度，受底板高度限制） / Depth of hole, Overrides the known item depth. Limited by floor height."),
    (r"^// 45 deg chamfer added to the top of the hole \(mm\)$", "// 孔洞顶部45度倒角（mm） / 45 deg chamfer added to the top of the hole (mm)"),
    (r"^//Render just a sample of the item hole, to be used as a test print$", "//仅渲染孔洞样品（用于测试打印） / Render just a sample of the item hole, to be used as a test print"),
    (r"^//Wall thickness of the sample print$", "//样品壁厚 / Wall thickness of the sample print"),
    (r"^// cards to use when multi card is selected", "// 多卡模式下的卡片类型列表 / cards to use when multi card is selected"),
    (r"^// Force nesting of multi cards,", "// 强制多卡嵌套紧凑排列 / Force nesting of multi cards,"),
    (r"^// Should the grid be square or hex$", "// 孔洞形状（方形/六边形） / Should the grid be square or hex"),
    (r"^// The number of sides for a round hole$", "// 圆孔边数 / The number of sides for a round hole"),
    (r"^// Diameter of, round hole, or corners for square hole$", "// 圆孔直径或方孔角圆半径 / Diameter of, round hole, or corners for square hole"),
    (r"^// Radius of the bottom of the custom shape$", "// 自定义形状底部圆角半径 / Radius of the bottom of the custom shape"),
    (r"^// The size the hole$", "// 孔洞尺寸 / The size the hole"),
    (r"^//Spacing around the holes$", "//孔洞间距 / Spacing around the holes"),
    (r"^// Number of holes in the x and y dimension, 0 is dynamic$", "// X/Y方向孔洞数量（0自动计算） / Number of holes in the x and y dimension, 0 is dynamic"),
    (r"^// Number of holes in the y dimension, 0 is dynamic", "// Y方向孔洞数量（0自动，0.5仅对六边形有效） / Number of holes in the y dimension, 0 is dynamic"),
    (r"^//Auto set the bin height based on the hole size\.$", "//根据孔洞深度自动设置收纳盒高度 / Auto set the bin height based on the hole size."),
    (r"^// Spacing around the compartments$", "// 隔间间距 / Spacing around the compartments"),
    (r"^// Center the holes within the compartments$", "// 孔洞居中于隔间 / Center the holes within the compartments"),

    # Tray
    (r"^//Height above the base height$", "//高于底座的高度 / Height above the base height"),
    (r"^// Debug, Color Compartments$", "// 调试：为隔间着色 / Debug, Color Compartments"),
    (r"^// Debug, Highlight Compartments$", "// 调试：高亮显示隔间 / Debug, Highlight Compartments"),

    # Slicer/Debug
    (r"^//Slice along the x axis$", "//沿X轴切片（调试） / Slice along the x axis"),
    (r"^//Slice along the y axis$", "//沿Y轴切片（调试） / Slice along the y axis"),
]


def translate_section_header(line):
    """Translate /* [Section Name] */ style headers."""
    m = re.match(r'^(/\* \[)(.+?)(\]\*/)$', line.rstrip()) or re.match(r'^(/\* \[)(.+?)(\] \*/)$', line.rstrip())
    if m:
        name = m.group(2)
        if name in SECTION_TRANSLATIONS:
            return m.group(1) + SECTION_TRANSLATIONS[name] + m.group(3) + '\n'
    return line


def translate_param_comment(line):
    """Translate // parameter comment lines."""
    stripped = line.rstrip()
    # Only translate lines that start with // or //
    if not (stripped.startswith('//') or stripped.startswith('\t//')):
        return line
    # Get leading whitespace
    leading = len(stripped) - len(stripped.lstrip())
    content = stripped.lstrip()

    for pattern, replacement in PARAM_COMMENT_TRANSLATIONS:
        if re.match(pattern, content):
            return stripped[:leading] + replacement + '\n'
    return line


def translate_file(filepath):
    """Apply translations to a single SCAD file."""
    path = Path(filepath)
    if not path.exists():
        print(f"File not found: {filepath}")
        return False

    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    new_lines = []
    changed = False
    for line in lines:
        new_line = translate_section_header(line)
        new_line = translate_param_comment(new_line)
        if new_line != line:
            changed = True
        new_lines.append(new_line)

    if changed:
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Translated: {filepath}")
    else:
        print(f"No changes: {filepath}")

    return changed


def main():
    scad_files = list(Path('/workspace').glob('*.scad'))
    total_changed = 0
    for f in sorted(scad_files):
        if translate_file(str(f)):
            total_changed += 1
    print(f"\nDone. {total_changed}/{len(scad_files)} files updated.")


if __name__ == '__main__':
    main()
