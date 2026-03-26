// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup

include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_basic_cup!!>*/
/* [通用杯体 / General Cup] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z轴 / Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// 填充实心块 / Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// 外壁壁厚 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// 顶部预留间隙，缩小顶部尺寸以便更好堆叠 / under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [卡口 / Cup Lip] */
// 卡口样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, reduced_double, minimum, none:not stackable ]
// 低于此尺寸时缩减卡口内侧以便取物 / Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// 卡口顶部凹槽高度 / Create a relief in the lip
lip_top_relief_height = -1; // 0.1
// 每端保留的卡口宽度 / how much of the lip to retain on each end
lip_top_relief_width = -1; // 0.1
// 在卡口添加防滑缺口 / add a notch to the lip to prevent sliding.
lip_top_notches  = true;
// 启用卡口夹扣（用于连接杯体）/ enable lip clip for connection cups
lip_clip_position = "disabled"; //[disabled, intersection, center_wall, both]
// 非42整数倍时仍允许堆叠 / allow stacking when bin is not multiples of 42
lip_non_blocking = false;
height_includes_lip = false;

/* [分隔 / Subdivisions] */
// 隔墙壁厚 [底部, 顶部] / Wall thickness [bottom, top]
chamber_wall_thickness = [1.2, 1.2]; //0.1
// 隔墙高度缩减量 / Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// 隔墙顶部圆角半径，负值为顶部壁厚的比率（弯折隔墙不生效）/ Radius of the top of the chamber wall, -ve is ratio of top wall thickenss. (disabled for bent walls)
chamber_wall_top_radius = 0; //0.1
// 竖向隔室数量 / Vertical chambers count
vertical_chambers = 1;
vertical_separator_bend_separation = 0;
vertical_separator_bend_angle = 45;
vertical_separator_bend_position = 0;
vertical_separator_cut_depth=0;
// 横向隔室数量 / Horizontal chambers count
horizontal_chambers = 1;
horizontal_separator_bend_separation = 0;
horizontal_separator_bend_angle = 45;
horizontal_separator_bend_position = 0;
horizontal_separator_cut_depth=0;
// 启用不规则竖向分隔 / Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// 分隔位置（以网格单位从左端计算）/ Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// 启用不规则横向分隔 / Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// 分隔位置（以网格单位从左端计算）/ Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";

/* [底部 / Base] */
// 启用磁铁 / Enable magnets
enable_magnets = false;
// 启用螺钉 / Enable screws
enable_screws = false;
// 磁铁尺寸，直径和高度。Zack原版使用6.5和2.4 / size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
// 磁铁取出辅助槽 / create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
// 侧面磁铁入口（配合内嵌磁铁使用）/ Use with captive magnet for a 'refinded style' magnet
magnet_side_access = "disabled";//[disabled,left:"↰ left",right:"⬑ right"]
// 磁铁孔内抬高量（用于打印嵌入磁铁）/ raise the magnet void inside the part for print-in-magnets
magnet_captive_height = 0; // .1
// 磁铁孔波纹深度 / add a wavy pattern to the magnet hole
magnet_crush_depth = 0; //0.1
// 磁铁孔倒角 / add a chamfer to the magent hole
magnet_chamfer = 0; //0.1
// 螺钉尺寸，直径和深度。Zack原版使用3和6 / size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
// 中心磁铁尺寸，直径和高度 / size of center magnet, diameter and height.
center_magnet_size = [0,0];
// 悬空修复（螺钉和磁铁均非零时启用）/ Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
// 仅在角部添加磁铁和螺钉（加速打印）/ Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// 底部最小壁厚（Zack原版约1.2mm）/ Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// 高效底板（节省材料但底面不平整）/ Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// 半节距，允许底部垫块以半格偏移 / AKA half pitch. Enable to subdivide bottom pads to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// 平底模式 / Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// 移除底板创建竖向垫片 / Remove floor to create a vertical spacer
spacer = false;
// 小于此尺寸的垫块不渲染（会影响与底板配合）/ Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// 圆角平底半径，-1使用角部半径 / Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// 圆角底部倒角（便于打印），-1自动添加45度 / Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;
// 网格X轴对齐方式 / grid position x
align_grid_x = "near";//[near, far]
// 网格Y轴对齐方式 / grid position y
align_grid_y = "near";//[near, far]

/* [标签 / Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 标签位置（含左/右/居中对齐）/ Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// 标签尺寸：宽、深、高、圆角半径。宽度为Gridfinity单位(42mm)，深度和高度为mm，半径为mm。宽度0=全宽，高度0=深度值，高度-1=深度*3/4 / Width, Depth, Height, Radius.
// 在内部隔墙上启用标签 / Enable labels on internal divider walls
label_dividers = "disabled"; //[disabled, horizontal, vertical, both]

label_size = [0,14,0,0.6]; // 0.01
// 凹陷标签尺寸（宽、深、高、圆角半径），单位mm / Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// 启用标签的墙面（前、后、左、右），0禁用，1启用 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]


/* [滑盖 / Sliding Lid] */
sliding_lid_enabled = false;
// 滑盖厚度，0=壁厚×2 / 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 最小壁厚，0=壁厚/2 / 0 = wall_thickness/2
sliding_lid_min_wall_thickness = 0;//0.1
// 最小支撑，0=默认滑盖厚度/2 / 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_clearance = 0.1;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_nub_size = 0.5; //

/* [取物槽 / Finger Slide] */
// 添加较大的角部圆角以便取物 / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 角部圆角半径，0无，>1为mm值，<0为尺寸/abs(n) / Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
// 启用取物槽的墙面（前、后、左、右），0禁用，1用半径，>1覆盖半径 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
// 取物槽与卡口对齐 / Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [锥形角 / Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// 锥形角退缩量，默认使用Gridfinity角半径 / Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [墙壁纹样 / Wall Pattern] */
// 启用墙壁网格纹样 / Grid wall patter
wallpattern_enabled=false;
// 纹样样式 / Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 纹样间距 / Spacing between pattern
wallpattern_strength = 2; //0.1
// 启用纹样的墙面（前、后、左、右）/ wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// 旋转网格 / rotate the grid
wallpattern_rotate_grid=false;
// 孔洞尺寸 / Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// 在隔墙上添加纹样 / Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
// 孔洞边数 / Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
// 孔洞角部圆角半径 / Radius of corners
wallpattern_hole_radius = 0.5;
// 纹样填充模式 / pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 纹样边框宽度，默认为壁厚 / border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// 压印深度（mm），0=整墙厚度 / depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
// 网格孔锥形倒角 / grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
// Voronoi纹样噪声 / voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
// 砖块纹样中心权重 / brick pattern center weight
wallpattern_pattern_brick_weight = 5;
// 底板纹样最小面尺寸（$fs）/ $fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2
wallpattern_colored = "disabled"; //[disabled, enabled]


/* [底板纹样 / Floor Pattern] */
// 启用底板网格纹样 / enable Grid floor patter
floorpattern_enabled=false;
// 纹样样式 / Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 纹样间距 / Spacing between pattern
floorpattern_strength = 2; //0.1
// 旋转网格 / rotate the grid
floorpattern_rotate_grid = false;
// 孔洞尺寸 / Size of the hole
floorpattern_cell_size = [10,10]; //0.1
// 孔洞边数 / Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
// 孔洞角部圆角半径 / Radius of corners
floorpattern_hole_radius = 0.5;
// 纹样填充模式 / pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 纹样边框宽度，默认为壁厚 / border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// 压印深度（mm），0=整墙厚度 / depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
// 网格孔锥形倒角 / grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
// Voronoi纹样噪声 / voronoi pattern noise,
floorpattern_pattern_voronoi_noise = 0.75; //0.01
// 砖块纹样中心权重 / brick pattern center weight
floorpattern_pattern_brick_weight = 5;
// 底板纹样最小面尺寸（$fs）/ $fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [墙壁镂空 / Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// 竖向镂空位置，-0.5禁用；正值为GF单位；负值为长度/abs(值)的比率 / wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=[-2,-0.5,-0.5,-0.5];  //0.01
// 默认为仓宽/2 / default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
// 默认为仓高。0=圆弧，-1=底板，正值=从顶部的深度，负值=高度/abs(值)的比率 / default will be binHeight. 0: radius, -1 floor, Positive: depth from top; Negative: ratio height/abs(value)
wallcutout_vertical_height=0; //0.1
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// 横向镂空位置，-0.5禁用；正值为GF单位；负值为长度/abs(值)的比率 / wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
// 默认为仓宽/2 / default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
// 默认为仓高 / default will be binHeight
wallcutout_horizontal_height=0; //0.1
wallcutout_horizontal_corner_radius=5;

/* [可扩展 / Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
// 扣片尺寸：高、宽、厚、样式。宽默认=高，厚默认=1.4，样式{0,1,2} / Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [底部文字 / Bottom Text] */
// 在底部添加仓体尺寸 / Add bin size to bin bottom
text_1 = false;
// 文字字号（mm），0自动 / Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// 文字深度（mm）/ Depth of text, in mm
text_depth = 0.3; // 0.01
// 文字偏移（mm）/ Offset of text , in mm
text_offset = [0, 0]; // 0.1
// 字体 / Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// 在底部添加自定义文字（如日期、编号等）/ Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// 自定义文字内容 / Actual text to add
text_2_text = "Gridfinity Extended";

/* [调试 / debug] */
// 调试切片 / Debug slice
cut = [0,0,0]; //0.1

// 启用渲染时的帮助信息 / Enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
// 修改默认网格尺寸（将破坏兼容性）/ Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
// 仓体周围间隙（mm）/ clearance around the bin, will reduce the bin by this amount in mm.
clearance = [0.5, 0.5, 0];
// 仓体配色 / Assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
// 模型渲染位置 / Where to render the model
render_position = "center"; //[default,center,zero]
// 最小片段角度（值越小片段越多）/ Minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// 最小片段尺寸（值越小片段越多）/ minimum size of a fragment.  Low is more fragments
fs = 0.4;
// 片段数量（覆盖$fa和$fs）/ number of fragments, overrides $fa and $fs
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001
// 强制渲染耗时组件 / force render on costly components
force_render = true;

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

set_environment(
  width = width,
  depth = depth,
  height = height,
  height_includes_lip = height_includes_lip,
  lip_enabled = lip_style != "none",
  render_position = render_position,
  help = enable_help,
  pitch = pitch,
  clearance = clearance,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
gridfinity_cup(
  filled_in=filled_in,
  label_settings=LabelSettings(
    labelStyle=label_style,
    labelPosition=label_position,
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls,
    labelDividers=label_dividers),
  finger_slide_settings = FingerSlideSettings(
    type = fingerslide,
    radius = fingerslide_radius,
    walls = fingerslide_walls,
    lip_aligned = fingerslide_lip_aligned),
  cupBase_settings = CupBaseSettings(
    magnetSize = enable_magnets?magnet_size:[0,0],
    magnetEasyRelease = magnet_easy_release,
    magnetSideAccess = magnet_side_access,
    magnetCaptiveHeight = magnet_captive_height,
    magnetCrushDepth = magnet_crush_depth,
    magnetChamfer = magnet_chamfer,
    centerMagnetSize = center_magnet_size,
    screwSize = enable_screws?screw_size:[0,0],
    holeOverhangRemedy = hole_overhang_remedy,
    cornerAttachmentsOnly = box_corner_attachments_only,
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    subPitch=sub_pitch,
    flatBase=flat_base,
    spacer=spacer,
    minimumPrintablePadSize=minimum_printable_pad_size,
    flatBaseRoundedRadius = flat_base_rounded_radius,
    flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint,
    alignGrid = [align_grid_x, align_grid_y]
    ),
  wall_thickness=wall_thickness,
  vertical_chambers = ChamberSettings(
    chambers_count = vertical_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    chamber_wall_top_radius = chamber_wall_top_radius,
    separator_bend_position = vertical_separator_bend_position,
    separator_bend_angle = vertical_separator_bend_angle,
    separator_bend_separation = vertical_separator_bend_separation,
    separator_cut_depth = vertical_separator_cut_depth,
    irregular_subdivisions = vertical_irregular_subdivisions,
    separator_config = vertical_separator_config),
  horizontal_chambers = ChamberSettings(
    chambers_count = horizontal_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
    chamber_wall_top_radius = chamber_wall_top_radius,
    separator_bend_position = horizontal_separator_bend_position,
    separator_bend_angle = horizontal_separator_bend_angle,
    separator_bend_separation = horizontal_separator_bend_separation,
    separator_cut_depth = horizontal_separator_cut_depth,
    irregular_subdivisions = horizontal_irregular_subdivisions,
    separator_config = horizontal_separator_config),
  lip_settings = LipSettings(
    lipStyle=lip_style,
    lipSideReliefTrigger=lip_side_relief_trigger,
    lipTopReliefHeight=lip_top_relief_height,
    lipTopReliefWidth=lip_top_relief_width,
    lipNotch=lip_top_notches,
    lipClipPosition=lip_clip_position,
    lipNonBlocking=lip_non_blocking),
  headroom=headroom,
  tapered_corner=tapered_corner,
  tapered_corner_size = tapered_corner_size,
  tapered_setback = tapered_setback,
  wallpattern_walls=wallpattern_walls,
  wallpattern_dividers_enabled=wallpattern_dividers_enabled,
  wall_pattern_settings = PatternSettings(
    patternEnabled = wallpattern_enabled,
    patternStyle = wallpattern_style,
    patternRotate = wallpattern_rotate_grid,
    patternFill = wallpattern_fill,
    patternBorder = wallpattern_border,
    patternDepth = wallpattern_depth,
    patternCellSize = wallpattern_cell_size,
    patternHoleSides = wallpattern_hole_sides,
    patternStrength = wallpattern_strength,
    patternHoleRadius = wallpattern_hole_radius,
    patternGridChamfer = wallpattern_pattern_grid_chamfer,
    patternVoronoiNoise = wallpattern_pattern_voronoi_noise,
    patternBrickWeight = wallpattern_pattern_brick_weight,
    patternFs = wallpattern_pattern_quality,
    patternColored = wallpattern_colored),
  floor_pattern_settings = PatternSettings(
    patternEnabled = floorpattern_enabled,
    patternStyle = floorpattern_style,
    patternRotate = floorpattern_rotate_grid,
    patternFill = floorpattern_fill,
    patternBorder = floorpattern_border,
    patternDepth = floorpattern_depth,
    patternCellSize = floorpattern_cell_size,
    patternHoleSides = floorpattern_hole_sides,
    patternStrength = floorpattern_strength,
    patternHoleRadius = floorpattern_hole_radius,
    patternGridChamfer = floorpattern_pattern_grid_chamfer,
    patternVoronoiNoise = floorpattern_pattern_voronoi_noise,
    patternBrickWeight = floorpattern_pattern_brick_weight,
    patternFs = floorpattern_pattern_quality),
  wallcutout_vertical_settings = WallCutoutSettings(
    type = wallcutout_vertical,
    position = wallcutout_vertical_position,
    width = wallcutout_vertical_width,
    angle = wallcutout_vertical_angle,
    height = wallcutout_vertical_height,
    corner_radius = wallcutout_vertical_corner_radius),
  wallcutout_horizontal_settings = WallCutoutSettings(
    type = wallcutout_horizontal,
    position = wallcutout_horizontal_position,
    width = wallcutout_horizontal_width,
    angle = wallcutout_horizontal_angle,
    height = wallcutout_horizontal_height,
    corner_radius = wallcutout_horizontal_corner_radius),
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = extension_x_enabled,
    extendablexPosition = extension_x_position,
    extendableyEnabled = extension_y_enabled,
    extendableyPosition = extension_y_position,
    extendableTabsEnabled = extension_tabs_enabled,
    extendableTabSize = extension_tab_size),
  sliding_lid_settings = SlidingLidSettings(
    enabled = sliding_lid_enabled,
    thickness = sliding_lid_thickness,
    min_wall_thickness = sliding_lid_min_wall_thickness,
    min_support = sliding_lid_min_support,
    clearance = sliding_lid_clearance,
    pull_style = sliding_lid_pull_style,
    nub_size = sliding_lid_nub_size),
  cupBaseTextSettings = CupBaseTextSettings(
    baseTextLine1Enabled = text_1,
    baseTextLine2Enabled = text_2,
    baseTextLine2Value = text_2_text,
    baseTextFontSize = text_size,
    baseTextFont = text_font,
    baseTextDepth = text_depth,
    baseTextOffset = text_offset));
