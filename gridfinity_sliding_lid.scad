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

/* [滑动盖 / Sliding Lid] */
// 渲染对象 / select what to render
render_choice = "both";//[both, lid, cup, both connected]
sliding_lid_enabled = true;
// 0 = wall thickness *2
sliding_lid_thickness = 0; //0.1
// 0 = wall_thickness/2
sliding_lid_min_wallThickness = 0;//0.1
// 0 = default_sliding_lid_thickness/2
sliding_lid_min_support = 0;//0.1
sliding_lid_pull_style = "disabled"; //[disabled, lip, finger]
sliding_lid_clearance = 0.1;//0.1
sliding_lid_lip_clearance = 0.1;//0.1
sliding_lid_nub_size = 0.5; //

/* [滑盖镂空 / Sliding Cutout] */
sliding_lid_cutout_enabled = false; //
sliding_lid_cutout_size = [-2,-2]; //0.1
sliding_lid_cutout_radius = -4; //0.1
sliding_lid_cutout_position = [0,0]; //0.1

/* [滑盖文字 / Sliding Text] */
// 滑盖文字 / Add text to the sliding lid top
sliding_lid_text_enabled = false;
// 盖面文字内容 / Text to display on the lid
sliding_lid_text = "Gridfinity";
// 字体大小 / Font size for the lid text (0 = auto-size)
sliding_lid_text_size = 0; // 0.1
// 文字深度 / Depth of text engraving in mm
sliding_lid_text_depth = 0.3; // 0.01
// 字体 / Font for the lid text
sliding_lid_text_font = "Aldo"; // [Aldo, B612, "Open Sans", Ubuntu]
// 文字位置 / Text position on lid (left, center, right)
sliding_lid_text_position = "center"; // [left, center, right]

/*<!!start gridfinity_basic_cup!!>*/
/* [杯型基础 / General Cup] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
// Z轴 / Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// 填实 / Fill in solid block (overrides all following options)
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// 外壁厚度 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
//顶部余量 / under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [杯口边沿 / Cup Lip] */
// 边沿样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 内沿收缩阈值 / Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// 边沿镂空高度 / Create a relief cut in the lip
lip_top_relief_height = -1; // 0.1
// 防滑凸起 / add a notch to the lip to prevent sliding.
lip_top_notches  = true;

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
// 启用磁铁 / Enable magnets
enable_magnets = true;
// 启用螺丝 / Enable screws
enable_screws = true;
//磁铁尺寸 / size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
//磁铁取出槽 / create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
//螺丝尺寸 / size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
//中心磁铁尺寸 / size of center magnet, diameter and height.
center_magnet_size = [0,0];
// 悬空孔补偿 / Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
//仅角落安装磁铁螺丝 / Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// 底板最小厚度 / Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// 省材底板 / Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// 底部网格细分 / AKA half pitch. Enable to subdivide bottom pads to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// 平整底部 / Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// 作为垫片 / Remove floor to create a vertical spacer
spacer = false;
//最小打印底脚 / Pads smaller than this will not be rendered as it interferes with the baseplate. Ensure appropriate support is added in slicer.
minimum_printable_pad_size = 0.2;

// 平底圆角半径 / Adjust the radius of the rounded flat base. -1 uses the corner radius.
flat_base_rounded_radius = -1;
// 平底打印辅助 / Add chamfer to the rounded bottom corner to make easier to print. -1 add auto 45deg.
flat_base_rounded_easyPrint = -1;

/* [标签 / Label] */
label_style = "normal"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 标签位置 / Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// 标签尺寸 / Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
label_size = [0,14,0,0.6]; // 0.01
// 标签浮雕尺寸 / Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [取物槽 / Finger Slide] */
// 取物圆角 / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 圆角半径 / Radius of the corner fillet
fingerslide_radius = -3;
// 启用墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
fingerslide_walls=[1,0,0,0];  //[0:1:1]
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
// 文字偏移 / Offset of text , in mm
text_offset = [0, 0]; // 0.1
// 字体 / Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// 底部自定义文字 / Add free-form text line to bin bottom (printing date, serial, etc)
text_2 = false;
// 文字内容 / Actual text to add
text_2_text = "Gridfinity Extended";

/* [调试 / debug] */
// 调试切片 / Debug slice
cut = [0,0,0]; //0.1
// 调试日志 / enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
//颜色显示 / assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 最小角度精度 / minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// 最小面精度 / minimum size of a fragment.  Low is more fragments
fs = 0.4;
// 段数精度 / number of fragments, overrides $fa and $fs
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001
// 强制渲染 / force render on costly components
force_render = true;

/* [隐藏 / Hidden] */
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
