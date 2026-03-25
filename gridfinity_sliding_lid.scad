// Gridfinity extended basic cup
// version 2024-02-17
//
// Source
// https://www.printables.com/model/630057-gridfinity-extended-openscad
//
// Documentation
// https://docs.ostat.com/docs/openscad/gridfinity-extended/basic-cup

include <modules/gridfinity_constants.scad>
include <modules/module_gridfinity_sliding_lid.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/* [Sliding Lid] */
// 选择渲染内容 / select what to render
render_choice = "both";//[both, lid, cup, both connected]
sliding_lid_enabled = true;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = 壁厚 / wall_thickness/2
sliding_lid_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_clearance = 0.1;//0.1
sliding_lid_lip_clearance = 0.1;//0.1
sliding_lid_nub_size = 0.5; //

/* [Sliding Cutout] */
sliding_lid_cutout_enabled = false; //
sliding_lid_cutout_size = [-2,-2]; //0.1
sliding_lid_cutout_radius = -4; //0.1
sliding_lid_cutout_position = [0,0]; //0.1

/* [Sliding Text] */
// 在滑盖顶部添加文字 / Add text to the sliding lid top
sliding_lid_text_enabled = false;
// 盖子上显示的文字 / Text to display on the lid
sliding_lid_text = "Gridfinity";
// 盖子文字字号 / Font size for the lid text (0 = auto-size)
sliding_lid_text_size = 0; // 0.1
// 文字雕刻深度（mm） / Depth of text engraving
sliding_lid_text_depth = 0.3; // 0.01
// 盖子文字字体 / Font for the lid text
sliding_lid_text_font = "Aldo"; // [Aldo, B612, "Open Sans", Ubuntu]
// 文字在盖子上的位置 / Text position on lid (left, center, right)
sliding_lid_text_position = "center"; // [left, center, right]

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup] */
// X轴 / X dimension. 网格单位（42mm倍数）或mm.
width = [2, 0]; //0.1
// Y轴 / Y dimension. 网格单位（42mm倍数）或mm.
depth = [1, 0]; //0.1
// Z轴高度（不含） / Z dimension excluding. 网格单位（7mm倍数）或mm.
height = [3, 0]; //0.1
// Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// 外壁厚度 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//收缩顶部尺寸以便叠放 / under size the bin top
headroom = 0.8; // 0.1

/* [Cup Lip] */
// 杯沿样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 低于此值将缩减内侧杯沿以便拿取 / Below this the inside of the lip will be reduced.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relief cut in the lip
lip_top_relief_height = -1; // 0.1
// 添加防滑缺口 / add a notch to the lip.
lip_top_notches  = true;

/* [Subdivisions] */
chamber_wall_thickness = 1.2;
//减少隔壁高度 / Reduce the wall height
chamber_wall_headroom = 0;//0.1
// X轴分隔数 / X dimension subdivisions
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
// 分隔位置以网格单位从左端定义 / Separator positions
vertical_separator_config = "10.5|21|42|50|60";
// 启用不规则分隔 / Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// 分隔位置以网格单位从左端定义 / Separator positions
horizontal_separator_config = "10.5|21|42|50|60";

/* [Base] */
// 启用磁铁 / Enable magnets
enable_magnets = true;
// 启用螺丝 / Enable screws
enable_screws = true;
//磁铁尺寸，直径和高度 / size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//为磁铁取出创建凹槽 / create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
//螺丝尺寸，直径和高度 / size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//中心磁铁尺寸，直径和高度 / size of center magnet, diameter and height.
center_magnet_size = [0,0];
// 顺序桥接悬空修正 / Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//仅在箱角添加附件（磁铁和螺丝） / Only add attachments to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// 底座镂空上方最小厚度 / Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// 节省材料的底板模式 / Efficient floor option, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// 子间距（半间距）/ AKA half pitch to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// 去除底部内部网格 / Removes the internal grid
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// 去除底面以创建垂直间隔 / Remove floor to create a vertical spacer
spacer = false;
//小于此尺寸的凸台将不被渲染 / Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// 调整平底圆角半径 / Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// 为圆角底部添加倒角以便打印 / Add chamfer to the rounded bottom corner. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;

/* [Label] */
label_style = "normal"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 包含标签悬挑 / Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
label_size = [0,14,0,0.6]; // 0.01
// Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// 启用墙面，前、后、左、右 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Finger Slide] */
// 添加大圆角（手指滑动槽） / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 圆角半径 / Radius of the corner fillet
fingerslide_radius = -3;
// 启用墙面，前、后、左、右 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
fingerslide_walls=[1,0,0,0];  //[0:1:1]
//指滑槽与杯沿对齐 / Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// 锥形角退缩量 / Set back of the tapered corner
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern] */
// 墙面图案 / Grid wall pattern
wallpattern_enabled=false;
// 图案样式 / Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
wallpattern_strength = 2; //0.1
// 启用墙面，前、后、左、右 / wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// 旋转网格 / rotate the grid
wallpattern_rotate_grid=false;
//孔尺寸 / Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// 将图案添加到分隔板 / Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
//孔的边数 / Number of sides of the hole
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//圆角半径 / Radius of corners
wallpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// 浮雕深度（mm），0表示整个壁厚 / depth of imprint.
wallpattern_depth = 0; // 0.1
//网格图案孔锥角 / grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//砖块图案中心权重 / brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Floor Pattern] */
// 启用底面图案 / enable Grid floor pattern
floorpattern_enabled=false;
// 图案样式 / Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
floorpattern_strength = 2; //0.1
// 旋转网格 / rotate the grid
floorpattern_rotate_grid = false;
//孔尺寸 / Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//孔的边数 / Number of sides of the hole
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//圆角半径 / Radius of corners
floorpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// 浮雕深度（mm），0表示整个壁厚 / depth of imprint.
floorpattern_depth = 0; // 0.1
//网格图案孔锥角 / grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//voronoi pattern noise,
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//砖块图案中心权重 / brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Wall Cutout] */
wallcutout_vertical ="disabled"; //[disabled, enabled, wallsonly, frontonly, backonly]
// 启用墙面，前、后、左、右 / wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=-2;  //0.1
//默认为托盒宽度/2 / default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
//默认为托盒高度 / default will be binHeight
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, wallsonly, leftonly, rightonly]
// 启用墙面，前、后、左、右 / wall to enable on, front, back, left, right. 0: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=-2;  //0.1
//默认为托盒宽度/2 / default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//默认为托盒高度 / default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;

/* [Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
//卡扣尺寸，高、宽、厚、样式 / Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [Bottom Text] */
// 在底部添加托盒尺寸 / Add bin size to bin bottom
text_1 = false;
// 文字字号（mm） / Font Size of text (0 will auto size)
text_size = 0; // 0.1
// 文字深度（mm） / Depth of text
text_depth = 0.3; // 0.01
// 文字偏移（mm） / Offset of text
text_offset = [0, 0]; // 0.1
// 使用字体 / Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// 在底部添加自定义文字 / Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// 要添加的文字 / Actual text to add
text_2_text = "Gridfinity Extended";

/* [debug] */
// 调试切片 / Debug slice
cut = [0,0,0]; //0.1
// 渲染时启用帮助日志 / enable logging of help messages.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail] */
//为托盒指定颜色 / assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//模型渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 片段最小角度 / minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// 片段最小尺寸 / minimum size of a fragment.  Low is more fragments
fs = 0.4;
// 片段数量（覆盖$fa和$fs） / number of fragments
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001
// 强制渲染复杂组件 / force render on costly components
force_render = true;

/* [Hidden] */
module end_of_customizer_opts() {}
/*<!!end gridfinity_basic_cup!!>*/

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

sliding_lid_settings = SlidingLidSettings(
  enabled = sliding_lid_enabled,
  thickness = sliding_lid_thickness,
  min_wall_thickness = sliding_lid_min_wallThickness,
  min_support = sliding_lid_min_support,
  clearance = sliding_lid_clearance,
  pull_style = sliding_lid_pull_style,
  nub_size = sliding_lid_nub_size,
  lip_clearance = sliding_lid_lip_clearance,
  text_enabled = sliding_lid_text_enabled,
  text_content = sliding_lid_text,
  text_size = sliding_lid_text_size,
  text_depth = sliding_lid_text_depth,
  text_font = sliding_lid_text_font,
  text_position = sliding_lid_text_position,
  cutout_enabled = sliding_lid_cutout_enabled,
  cutout_size = sliding_lid_cutout_size,
  cutout_radius = sliding_lid_cutout_radius,
  cutout_position = sliding_lid_cutout_position
);

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
  union(){
  if(render_choice == "both" || render_choice == "cup" || render_choice == "both connected")
  {
    gridfinity_cup(
      width=width, depth=depth, height=height,
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
        magnetSize = enable_magnets ? magnet_size : [0,0],
        magnetEasyRelease = magnet_easy_release,
        centerMagnetSize = center_magnet_size,
        screwSize = enable_screws ? screw_size : [0,0],
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
        flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint),
      wall_thickness=wall_thickness,
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
        lipNotch=lip_top_notches),
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
      sliding_lid_settings= sliding_lid_settings,
      cupBaseTextSettings = CupBaseTextSettings(
        baseTextLine1Enabled = text_1,
        baseTextLine2Enabled = text_2,
        baseTextLine2Value = text_2_text,
        baseTextFontSize = text_size,
        baseTextFont = text_font,
        baseTextDepth = text_depth,
        baseTextOffset = text_offset));
  }

  if(render_choice == "both" || render_choice == "lid" || render_choice == "both connected")
  {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);

    wall_thickness = wallThickness(wall_thickness, num_z);
    slidingLidSettings = ValidateSlidingLidSettings(sliding_lid_settings, wall_thickness);

    headroom = headroom + (sliding_lid_enabled ? slidingLidSettings[iSlidingLid_Thickness] : 0);

    filledInZ = env_pitch().z*num_z;
    zpoint = filledInZ-headroom;

    translate(
      render_choice == "both" && !$preview
      ? [(num_x+0.5)*env_pitch().x, 0, 0]
      : [0, 0, render_choice == "lid" ? 0 : zpoint])
      SlidingLid(
        num_x=num_x,
        num_y=num_y,
        wall_thickness,
        headroom = headroom,
        lipStyle = lip_style,
        lip_notches = lip_top_notches,
        lip_top_relief_height = lip_top_relief_height,
        limitHeight=true,
        clearance = slidingLidSettings[iSlidingLid_Clearance],
        lip_clearance = slidingLidSettings[iSlidingLid_LipClearance],
        lidThickness=slidingLidSettings[iSlidingLid_Thickness],
        lidMinSupport=slidingLidSettings[iSlidingLid_MinSupport],
        lidMinWallThickness=slidingLidSettings[iSlidingLid_MinWallThickness],
        pull_style = slidingLidSettings[iSlidingLid_PullStyle],
        cutoutEnabled = slidingLidSettings[iSlidingLid_CutoutEnabled],
        cutoutSize = slidingLidSettings[iSlidingLid_CutoutSize],
        cutoutRadius = slidingLidSettings[iSlidingLid_CutoutRadius],
        cutoutPosition = slidingLidSettings[iSlidingLid_CutoutPosition],
        nub_size = slidingLidSettings[iSlidingLid_NubSize],
        text_enabled = slidingLidSettings[iSlidingLid_TextEnabled],
        text_content = slidingLidSettings[iSlidingLid_TextContent],
        text_size = slidingLidSettings[iSlidingLid_TextSize],
        text_depth = slidingLidSettings[iSlidingLid_TextDepth],
        text_font = slidingLidSettings[iSlidingLid_TextFont],
        text_position = slidingLidSettings[iSlidingLid_TextPosition]
      );
  }
}
