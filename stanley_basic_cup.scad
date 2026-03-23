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
/* [杯型基础 / General Cup] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
stanley_model = "proshallow"; //[proshallow:Pro Shallow,prodeep:Pro Deep,fatmaxshallow:FatMax Pro 1-97-519,fatmaxdeep:FatMax Pro Deep 1-97-521,compartment25:25-Compartment 1-92-762,compartment25front:25-Compartment Front 1-92-762]

// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [1, 0]; //0.1
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z轴 / Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [1, 0]; //0.1
// 填实 / Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// 外壁厚度 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 1.2;  // .01
//顶部余量 / under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [杯口边沿 / Cup Lip] */
// 边沿样式 / Style of the cup lip
lip_style = "reduced";  // [ normal, reduced, reduced_double, minimum, none:not stackable ]
// 内沿收缩阈值 / Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [0,0]; //0.1
// 边沿镂空高度 / Create a relief in the lip
lip_top_relief_height = -1; // 0.1
// 边沿镂空宽度 / how much of the lip to retain on each end
lip_top_relief_width = -1; // 0.1
// 防滑凸起 / add a notch to the lip to prevent sliding.
lip_top_notches  = false;
// 连接卡扣 / enable lip clip for connection cups
lip_clip_position = "disabled"; //[disabled, intersection, center_wall, both]
//非标准尺寸堆叠 / allow stacking when bin is not multiples of 42
lip_non_blocking = false;
height_includes_lip = true;

/* [内部分隔 / Subdivisions] */
chamber_wall_thickness = 1.2;
//隔壁顶部余量 / Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// X轴 / X dimension subdivisions
vertical_chambers = 1;
vertical_separator_bend_position = 0;
vertical_separator_bend_angle = 0;
vertical_separator_bend_separation = 0;
vertical_separator_cut_depth=0;
horizontal_chambers = 1;
horizontal_separator_bend_position = 0;
horizontal_separator_bend_angle = 0;
horizontal_separator_bend_separation = 0;
horizontal_separator_cut_depth=0;
// 启用不规则分隔 / Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// 分隔位置配置 / Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// 启用不规则分隔 / Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// 分隔位置配置 / Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";

/* [底座 / Base] */
// 底板最小厚度 / Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 1.2;
cavity_floor_radius = -1;// .1
// 平底圆角半径 / Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = 4;
// 平底打印辅助 / Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;

/* [标签 / Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 标签位置 / Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// 标签尺寸 / Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4. 
label_size = [0,10,0,0.6]; // 0.01
// 标签浮雕尺寸 / Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]
    
/* [滑动盖 / Sliding Lid] */
sliding_lid_enabled = false;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_lid_min_wall_thickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_clearance = 0.1;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_nub_size = 0.5; //

/* [取物槽 / Finger Slide] */
// 取物圆角 / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 圆角半径 / Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the min(width,height))
fingerslide_radius = -3;
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
//与边沿对齐 / Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [斜角边 / Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// 斜角退缩量 / Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [墙体图案 / Wall Pattern] */
// 墙体图案 / Grid wall patter
wallpattern_enabled=false;
// 图案样式 / Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
wallpattern_strength = 2; //0.1
// 启用墙面 / wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// 旋转网格 / rotate the grid
wallpattern_rotate_grid=false;
//孔尺寸 / Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// 隔板图案 / Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both] 
//孔形状边数 / Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//孔圆角半径 / Radius of corners
wallpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 图案边框 / border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// 图案深度 / depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//网格孔倒角 / grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//Voronoi噪点 / voronoi pattern noise, 
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//砖形图案权重 / brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [底板图案 / Floor Pattern] */
// 启用底板图案 / enable Grid floor patter
floorpattern_enabled=false;
// 图案样式 / Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
floorpattern_strength = 2; //0.1
// 旋转网格 / rotate the grid
floorpattern_rotate_grid = false;
//孔尺寸 / Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//孔形状边数 / Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//孔圆角半径 / Radius of corners
floorpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 图案边框 / border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// 图案深度 / depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//网格孔倒角 / grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//Voronoi噪点 / voronoi pattern noise, 
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//砖形图案权重 / brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [墙体镂空 / Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//镂空宽度 / default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//镂空高度 / default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//镂空宽度 / default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//镂空高度 / default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;

/* [可延伸 / Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5; 
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5; 
extension_tabs_enabled = true;
//连接片尺寸 / Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [底部文字 / Bottom Text] */
// 底部尺寸文字 / Add bin size to bin bottom
text_1 = false;
// 字体大小 / Font Size of text, in mm (0 will auto size)
text_size = 0; // 0.1
// 文字深度 / Depth of text, in mm
text_depth = 0.3; // 0.01
// 字体 / Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// 底部自定义文字 / Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// 文字内容 / Actual text to add
text_2_text = "Gridfinity Extended";

/* [调试 / debug] */
// Slice cup
cut = [0,0,0]; //0.1
// 调试日志 / Enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
// 网格尺寸 / Work in progress,  Modify the default grid size. Will break compatibility
pitch = [55,40,41];  //[0:1:9999]
// 配合间隙 / clearance around the bin, will reduce the bin by this amount in mm.
clearance = [0.5, 0.5, 0];
corner_radius = 3.75;
// 颜色显示 / Assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
// 渲染位置 / Where to render the model
render_position = "center"; //[default,center,zero]
// 最小角度精度 / Minimum angle for a fragment (fragments = 360/fa).  Low is more fragments 
fa = 6; 
// 最小面精度 / minimum size of a fragment.  Low is more fragments
fs = 0.4; 
// 段数精度 / number of fragments, overrides $fa and $fs
fn = 0;  
// 随机种子 / set random seed for 
random_seed = 0; //0.0001
// 强制渲染 / force render on costly components
force_render = true;

/* [Stanley Pro Shallow] */
proshallow_size = [40,55,41];
proshallow_wall_thickenss = 1.2;
proshallow_corner_radius = 3.75;
proshallow_bottom_radius = 3;

/* [Stanley Pro Deep] */
prodeep_size = [40,55,81];
prodeep_wall_thickenss = 1.2;
prodeep_corner_radius = 3.75;
prodeep_bottom_radius = 3;

/* [Stanley FatMax Pro 1-97-519] */
fatmaxshallow_size = [80,110,49];
fatmaxshallow_wall_thickenss = 1.8;
fatmaxshallow_corner_radius = 10;
fatmaxshallow_bottom_radius = 4;

/* [Stanley FatMax Pro Deep 1-97-521] */
fatmaxdeep_size = [80,108,91];
fatmaxdeep_wall_thickenss = 1.8;
fatmaxdeep_corner_radius = 10;
fatmaxdeep_bottom_radius = 4;

/* [Stanley 25-Compartment 1-92-762] */
compartment25_size = [52,72,70];
compartment25_wall_thickenss = 1.2;
compartment25_corner_radius = 8;
compartment25_bottom_radius = 4;
 
compartment25front_size = [142,72,70];
compartment25front_wall_thickenss = 1.2;
compartment25front_corner_radius = 8;
compartment25front_bottom_radius = 4;
 
/* [隐藏 / Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa; 
$fs = fs; 
$fn = fn;

istanley_model_settings_pitch = 0;
istanley_model_settings_wall = 1;
istanley_model_corner_radius = 2;
istanley_model_bottom_radius = 3;

stanley_model_settings = 
  stanley_model == "proshallow" ? [proshallow_size, proshallow_wall_thickenss, proshallow_corner_radius, proshallow_bottom_radius]
  : stanley_model == "prodeep" ? [prodeep_size, prodeep_wall_thickenss, prodeep_corner_radius, prodeep_bottom_radius]
  : stanley_model == "fatmaxshallow" ? [fatmaxshallow_size, fatmaxshallow_wall_thickenss, fatmaxshallow_corner_radius, fatmaxshallow_bottom_radius]
  : stanley_model == "fatmaxdeep" ? [fatmaxdeep_size, fatmaxdeep_wall_thickenss, fatmaxdeep_corner_radius, fatmaxdeep_bottom_radius]
  : stanley_model == "compartment25" ? [compartment25_size, compartment25_wall_thickenss, compartment25_corner_radius, compartment25_bottom_radius]
  : stanley_model == "compartment25front" ? [compartment25front_size, compartment25front_wall_thickenss, compartment25front_corner_radius, compartment25front_bottom_radius]
  : [pitch, wall_thickness, corner_radius, flat_base_rounded_radius];

set_environment(
  width = width,
  depth = depth,
  height = height,
  height_includes_lip = height_includes_lip,
  lip_enabled = lip_style != "none",
  render_position = render_position,
  help = enable_help,
  pitch = stanley_model_settings[istanley_model_settings_pitch],
  clearance = clearance,
  corner_radius=stanley_model_settings[istanley_model_corner_radius],
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
    labelWalls=label_walls),
  finger_slide_settings = FingerSlideSettings(
    type = fingerslide,
    radius = fingerslide_radius,
    walls = fingerslide_walls,
    lip_aligned = fingerslide_lip_aligned),
  cupBase_settings = CupBaseSettings(
    magnetSize = [0,0],
    magnetEasyRelease = false, 
    centerMagnetSize = [0,0], 
    screwSize = [0,0],
    holeOverhangRemedy = 0, 
    cornerAttachmentsOnly = false,
    floorThickness = stanley_model_settings[istanley_model_settings_wall],
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor="off",
    subPitch=1,
    flatBase="rounded",
    spacer=false,
    minimumPrintablePadSize=0.2,
    flatBaseRoundedRadius = stanley_model_settings[istanley_model_bottom_radius],
    flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint),
  wall_thickness=stanley_model_settings[istanley_model_settings_wall],
  vertical_chambers = ChamberSettings(
    chambers_count = vertical_chambers,
    chamber_wall_thickness = chamber_wall_thickness,
    chamber_wall_headroom = chamber_wall_headroom,
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
    patternFs = wallpattern_pattern_quality), 
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
    baseTextDepth = text_depth));
