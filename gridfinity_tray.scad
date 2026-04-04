use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
include <modules/module_gridfinity_cup_base.scad>
include <modules/module_wallplacard.scad>

/*<!!start gridfinity_tray!!>*/
/* [Tray / 托盘] */
tray_corner_radius = 2;

// 底座高度以上的高度 / Height above the base height
tray_zpos = 0;
tray_magnet_radius = 5;
tray_magnet_thickness = 5;
tray_spacing = 2; //0.1
tray_vertical_compartments = 1;
tray_horizontal_compartments = 1;
/*
xpos,ypos,xsize,ysize,radius,depth.
dimensions of the tray cutout, a string with comma separated values, and pipe (|) separated trays.
 - xpos, ypos, the x/y position in gridfinity units.
 - xsize, ysize. the x/y size in gridfinity units.
 - radius, [optional] corner radius in mm.
 - depth, [optional] depth in mm
 - example "0,0,2,1|2,0,2,1,2,5"
*/
//[[xpos,ypos,xsize,ysize,radius,depth]]. xpos, ypos, the x/y position in gridfinity units.xsize, ysize. the x/y size in gridfinity units. radius, [optional] corner radius in mm.depth, [optional] depth in mm\nexample "0,0,2,1|2,0,2,1,2,5"
tray_custom_compartments = "0, 0, 0.5, 3, 2, 6|0.5, 0, 0.5, 3,2, 6|1, 0, 3, 1.5|1, 1.5, 3, 1.5";

// 调试：给各间隔上色 / Debug, Color Compartments
tray_color_compartments = false;
// 调试：高亮显示间隔 / Debug, Highlight Compartments
tray_highlight_compartments = false;

/*<!!end gridfinity_tray!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [General Cup / 基本杯体] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [4, 0]; //0.5
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [3, 0]; //0.5
// Z轴 / Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [3, 0]; //0.1
// 实心填充 / Fill in solid block (overrides all following options)
filled_in = true;
// 外壁厚度 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
// 渲染位置 / Remove some or all of lip
position = "center"; //[default,center,zero]
// 顶部余量 / under size the bin top by this amount to allow for better stacking
headroom = 0.8; // 0.1

/* [Cup Lip / 杯沿] */
// 杯沿样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 杯沿内侧减薄触发尺寸 / Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// 杯沿顶部凹槽高度 / Create a relie
lip_top_relief_height = -1; // 0.1
// 防滑槽 / add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [Subdivisions / 分隔] */
chamber_wall_thickness = 1.2;
// 分隔墙高度减量 / Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// 竖向分隔数 / X dimension subdivisions
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
// 启用不均匀分隔 / Enable irregular subdivisions
vertical_irregular_subdivisions = false;
// 竖向分隔位置配置 / Separator positions are defined in terms of grid units from the left end
vertical_separator_config = "10.5|21|42|50|60";
// 启用不均匀分隔 / Enable irregular subdivisions
horizontal_irregular_subdivisions = false;
// 横向分隔位置配置 / Separator positions are defined in terms of grid units from the left end
horizontal_separator_config = "10.5|21|42|50|60";

/* [Base / 底座] */
// 磁铁尺寸（直径和高度） / size of magnet, diameter and height. Zack's original used 6.5 and 2.4
magnet_size = [6.5, 2.4];  // .1
// 磁铁取出辅助 / create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
// 螺丝尺寸（直径和深度） / size of screw, diameter and height. Zack's original used 3 and 6
screw_size = [3, 6]; // .1
// 中心磁铁尺寸（直径和高度） / size of center magnet, diameter and height.
center_magnet_size = [0,0];
// 桥接孔悬空补救 / Sequential Bridging hole overhang remedy is active only when both screws and magnets are nonzero (and this option is selected)
hole_overhang_remedy = 2;
// 仅在角落添加附件 / Only add attachments (magnets and screw) to box corners (prints faster).
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// 底座最小厚度 / Minimum thickness above cutouts in base (Zack's design is effectively 1.2)
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// 高效底面 / Efficient floor option saves material and time, but the internal floor is not flat
efficient_floor = "off";//[off,on,rounded,smooth]
// 底部格网细分 / AKA half pitch. Enable to subdivide bottom pads to allow sub-cell offsets
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// 平底 / Removes the internal grid from base the shape
flat_base = "off";//[off,gridfinity,rounded]
// 垂直间隔片 / Remove floor to create a vertical spacer
spacer = false;

/* [Label / 标签] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 标签位置 / Include overhang for labeling (and specify left/right/center justification)
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// 标签尺寸（宽、深、高、圆角） / Width, Depth, Height, Radius. Width in Gridfinity units of 42mm, Depth and Height in mm, radius in mm. Width of 0 uses full width. Height of 0 uses Depth, height of -1 uses depth*3/4.
label_size = [0,14,0,0.6]; // 0.01
// 标签凹槽尺寸 / Size in mm of relief where appropriate. Width, depth, height, radius
label_relief = [0,0,0,0.6]; // 0.1
// 启用标签的墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [Finger Slide / 取物圆角] */
// 角部大圆角 / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 圆角半径 / Radius of the corner fillet, 0:none, >1: radius in mm, <0 dimention/abs(n) (i.e. -3 is 1/3 the width)
fingerslide_radius = -3;
// 启用取物圆角的墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius; >1: override radius.
fingerslide_walls=[1,0,0,0];
// 与杯沿对齐 / Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [Tapered Corner / 锥形角] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// 锥形角退缩量 / Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [Wall Pattern / 墙面镂空] */
// 启用墙面镂空 / Grid wall patter
wallpattern_enabled=false;
// 镂空样式 / Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 镂空强度（壁厚） / Spacing between pattern
wallpattern_strength = 2; //0.1
// 启用镂空的墙面 / wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// 旋转网格 / rotate the grid
wallpattern_rotate_grid=false;
// 孔洞尺寸 / Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// 在分隔墙上应用图案 / Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
// 孔洞边数 / Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
// 孔洞圆角半径 / Radius of corners
wallpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 镂空边框宽度 / border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// 镂空深度 / depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
// 网格孔倒角 / grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
// voronoi噪声 / voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
// 砖块图案中心权重 / brick pattern center weight
wallpattern_pattern_brick_weight = 5;
// 图案质量 / $fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [Wall Cutout / 墙面开口] */
wallcutout_vertical ="disabled"; //[disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// 竖向开口位置 / wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_vertical_position=[-2,-0.5,-0.5,-0.5];  //0.01
// 竖向开口宽度（默认仓宽/2） / default will be binwidth/2
wallcutout_vertical_width=0;
wallcutout_vertical_angle=70;
// 竖向开口高度 / default will be binHeight. 0: radius, -1 floor, Positive: depth from top; Negative: ratio height/abs(value)
wallcutout_vertical_height=0;
wallcutout_vertical_corner_radius=5;
wallcutout_horizontal ="disabled"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// 横向开口位置 / wallcoutout position -0.5: disabled; Positive: GF units; Negative: ratio length/abs(value)
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
// 横向开口宽度（默认仓宽/2） / default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
// 横向开口高度 / default will be binHeight
wallcutout_horizontal_height=0;
wallcutout_horizontal_corner_radius=5;

/* [Wall Placard / 墙面铭牌] */
// 墙面铭牌（标签卡槽或填充区域） / A wall placard is a filled-in area or a slot on the outside of a wall for placing a label.
wallplacard_style ="disabled"; //[disabled, rectangle, slot, ellipse]
// 启用铭牌的墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled
wallplacard_walls=[1,0,0,0];
// 铭牌尺寸（宽、高、深） / Width, Height, Depth. All in mm. Depth of 0 uses wall thickness. For label slot, the size of the cutout.
wallplacard_size = [67.5,24.5,0]; // 0.01
// 铭牌圆角半径 / Corner radius in mm.
wallplacard_corner_radius = 3; // 0.01
// 铭牌偏移（水平、垂直、深度） / Offsets from wall center: horizontal, vertical, depth. For label slot, the depth offset is from the wall exterior surface. Negative depth moves toward the interior.
wallplacard_offset = [0,0,0]; // 0.01
// 标签卡槽框架参数（顶部露出、侧底覆盖、框宽、框深） / The label slot makes an open-top frame to hold a label. Top edge reveal, side/bottom coverage, frame width, frame depth (all in mm).
wallplacard_slot_frame = [4, 2, 3, 1.5];  // 0.01

/* [Extendable / 可延伸] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
// 延伸卡扣尺寸 / Tab size, height, width, thickness, style. width default is height, thickness default is 1.4, style {0,1,2}.
extension_tab_size= [10,0,0,0];

/* [debug / 调试] */
// X轴切片 / Slice along the x axis
cutx = 0; //0.1
// Y轴切片 / Slice along the y axis
cuty = 0; //0.1
// 帮助日志 / enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [Model detail / 模型精度] */
// 颜色方案 / assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
// 渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 最小片段角度 / minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// 最小片段尺寸 / minimum size of a fragment.  Low is more fragments
fs = 0.1;
// 片段数量（覆盖fa和fs） / number of fragments, overrides $fa and $fs
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001
/*<!!end gridfinity_basic_cup!!>*/

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

//Index for custom config arrays
ixPos = 0;
iyPos = 1;
ixSize = 2;
iySize = 3;
iCornerRadius = 4;
iDepth = 5;

// module to build the tray cutouts
// This is what will be executed by external scripts
module tray(
  num_x=1,
  num_y=2,
  num_z,
  cornerRadius,
  trayZpos,
  spacing,
  cutoutSize,
  baseHeight,
  floorThickness,
  wallThickness,
  verticalCompartments = 1,
  horizontalCompartments = 1,
  customCompartments = "",
  tray_color_compartments = false
  )
{

  cellSpacing = spacing/2;

  verticalCompartments = verticalCompartments > 0 ? verticalCompartments : num_x ;
  horizontalCompartments = horizontalCompartments > 0 ? horizontalCompartments : num_y;
  //todo, this could be simplified, by to produce a single array for ether scenario.
  if(len(customCompartments) == 0)
  {
    //Non custom components
    if(env_help_enabled("trace")) echo(n=num_x*env_pitch().x-(verticalCompartments+1)*spacing,d=verticalCompartments);
    xSize = (num_x*env_pitch().x-(verticalCompartments+1)*spacing)/verticalCompartments;
    xStep = xSize + spacing;
    ySize = (num_y*env_pitch().y-(horizontalCompartments+1)*spacing)/horizontalCompartments;
    yStep = ySize + spacing;

    for(x =[0:1:verticalCompartments-1])
    {
      for(y =[0:1:horizontalCompartments-1])
      {
        if(env_help_enabled("trace")) echo(x=x,y=y,xStep=xStep,yStep=yStep);
        translate([spacing+x*xStep,spacing+y*yStep,baseHeight+max(trayZpos,floorThickness)])
        roundedCube(
            xSize, ySize,
            num_z*env_pitch().z,
            bottomRadius = cornerRadius,
            sideRadius = cornerRadius);
      }
    }
  }
  else
  {
    if(env_help_enabled("debug")) echo(customCompartments = splitCustomConfig(customCompartments));
    //custom components
    compartments = split(customCompartments, "|");

    scl = [
      (num_x*env_pitch().x-cellSpacing*2)/(num_x*env_pitch().x),
      (num_y*env_pitch().y-cellSpacing*2)/(num_y*env_pitch().y),1];
    translate([cellSpacing,cellSpacing,0])
    scale(scl)
    union()
      for (x =[0:1:len(compartments)-1])
      {
          comp =csv_parse(compartments[x]);
          xpos = get_related_value(comp[ixPos],num_x,0);
          ypos = get_related_value(comp[iyPos],num_y,0);
          xsize = get_related_value(comp[ixSize],num_x,0);
          ysize = get_related_value(comp[iySize],num_y,0);
          radius = len(comp) >= 5
            ? get_related_value(comp[iCornerRadius], cornerRadius, 0)
            : cornerRadius;
          depth = let(
            bin_top = num_z*env_pitch().z,
            min_depth = max(trayZpos,floorThickness),
            user_selected = (len(comp) >= 6 ? comp[iDepth] : min_depth))
            baseHeight+get_related_value(user_selected, bin_top, bin_top);

          echo("tray", xpos=xpos, ypos=ypos, xsize=xsize, ysize=ysize, radius=radius, depth=depth);
          color_conditional(tray_color_compartments && $preview, color_from_list(x), 1)
          translate([cellSpacing+xpos*env_pitch().x,cellSpacing+ypos*env_pitch().y,depth])
          roundedCube(
              xsize*env_pitch().x-cellSpacing*2,
              ysize*env_pitch().y-cellSpacing*2,
              //Added 5, as I need to deal with the lip overhang
              num_z*env_pitch().z-depth+fudgeFactor+5,
              bottomRadius = radius,
              sideRadius = radius);
    }
  }
}

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_tray(
  //tray settings
  tray_spacing = tray_spacing,
  tray_corner_radius = tray_corner_radius,
  tray_zpos = tray_zpos,
  tray_vertical_compartments = tray_vertical_compartments,
  tray_horizontal_compartments = tray_horizontal_compartments,
  tray_custom_compartments = tray_custom_compartments,
  tray_highlight_compartments=tray_highlight_compartments,
  tray_color_compartments=tray_color_compartments,
  //gridfinity settings
  width=width, depth=depth, height=height,
  position=position,
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
    magnetSize = magnet_size,
    magnetEasyRelease = magnet_easy_release,
    centerMagnetSize = center_magnet_size,
    screwSize = screw_size,
    holeOverhangRemedy = hole_overhang_remedy,
    cornerAttachmentsOnly = box_corner_attachments_only,
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    subPitch=sub_pitch,
    flatBase=flat_base,
    spacer=spacer),
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
  sub_pitch = sub_pitch,
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
  wallplacard_settings = WallplacardSettings(
    walls = wallplacard_walls,
    style = wallplacard_style,
    size = wallplacard_size,
    offset = wallplacard_offset,
    slot_frame = wallplacard_slot_frame,
    corner_radius = wallplacard_corner_radius),
  extendable_Settings = ExtendableSettings(
    extendablexEnabled = extension_x_enabled,
    extendablexPosition = extension_x_position,
    extendableyEnabled = extension_y_enabled,
    extendableyPosition = extension_y_position,
    extendableTabsEnabled = extension_tabs_enabled,
    extendableTabSize = extension_tab_size),
  cutx=cutx,
  cuty=cuty,
  help=enable_help) {

  num_x = calcDimensionWidth(width);
  num_y = calcDimensionDepth(depth);
  num_z = calcDimensionHeight(height);

  if(env_help_enabled("info")) echo("gridfinity_tray", num_x=num_x, num_y=num_y, num_z=num_z);

  difference() {
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      filled_in=filled_in,
      label_settings=label_settings,
      cupBase_settings = cupBase_settings,
      finger_slide_settings=finger_slide_settings,
      wall_thickness=wall_thickness,
      vertical_chambers = vertical_chambers,
      horizontal_chambers=horizontal_chambers,
      lip_settings=lip_settings,
      headroom=headroom,
      tapered_corner=tapered_corner,
      tapered_corner_size = tapered_corner_size,
      tapered_setback = tapered_setback,
      wallpattern_walls=wallpattern_walls,
      wallpattern_dividers_enabled=wallpattern_dividers_enabled,
      wall_pattern_settings = wall_pattern_settings,
      wallcutout_vertical_settings = wallcutout_vertical_settings,
      wallcutout_horizontal_settings = wallcutout_horizontal_settings,
      wallplacard_settings = wallplacard_settings,
      extendable_Settings = ExtendableSettings(
        extendablexEnabled = extension_x_enabled,
        extendablexPosition = extension_x_position,
        extendableyEnabled = extension_y_enabled,
        extendableyPosition = extension_y_position,
        extendableTabsEnabled = extension_tabs_enabled,
        extendableTabSize = extension_tab_size));
    /*<!!end gridfinity_basic_cup!!>*/

    highlight_conditional(tray_highlight_compartments && $preview)
    tray(
      num_x = num_x,
      num_y = num_y,
      num_z = num_z,
      floorThickness = floor_thickness,
      wallThickness = wall_thickness,
      spacing = tray_spacing,
      cornerRadius = tray_corner_radius,
      trayZpos = tray_zpos,
      baseHeight = cupBaseClearanceHeight(
                    magnet_size[iCylinderDimension_Height],
                    screw_size[iCylinderDimension_Height],
                    center_magnet_size[iCylinderDimension_Height]),
      verticalCompartments = tray_vertical_compartments,
      horizontalCompartments = tray_horizontal_compartments,
      customCompartments = tray_custom_compartments,
      tray_color_compartments=tray_color_compartments);

      //This seems like a complicated way to do this, but it guarantees order will be correct.
      configArray = [
        [ixPos, 0],
        [iyPos, 0],
        [ixSize, num_z],
        [iySize, num_x],
        [iCornerRadius, tray_corner_radius],
        [iDepth, num_z]];

      if(env_help_enabled("info")) echo(outputCustomConfig("tray", replace_Items(configArray, [])));
  }
}

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, 0],
  randomSeed = random_seed)
gridfinity_tray();
