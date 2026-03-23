include <modules/module_item_holder.scad>
include <modules/gridfinity_constants.scad>
include <modules/functions_general.scad>
use <modules/module_gridfinity_cup.scad>
include <modules/module_gridfinity_cup_base.scad>
use <modules/module_gridfinity_block.scad>
include <modules/module_patterns.scad>

/* [Divider] */
divider_count = 4;
divider_height = 50;
divider_width = 3;
divider_base_height = 10;
divider_radius = 5;
divider_front_top_inset=20;
divider_front_top_angle=45;
divider_back_top_inset=20;
divider_back_top_angle=45;

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

/* [杯型基础 / General Cup] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [3, 0]; //0.5
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [2, 0]; //0.5
// Z轴 / Z dimension excluding. grid units (multiples of 7mm) or mm.
height = [1, 0]; //0.1
// 填实 / Fill in solid block (overrides all following options)
filled_in = false;
// 外壁厚度 / Wall thickness of outer walls. default, height < 8 0.95, height < 16 1.2, height > 16 1.6 (Zack's design is 0.95 mm)
wall_thickness = 0;  // .01
position = "center"; //[default,center,zero]

/* [杯口边沿 / Cup Lip] */
// 边沿样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 内沿收缩阈值 / Below this the inside of the lip will be reduced for easier access.
lip_side_relief_trigger = [1,1]; //0.1
// Create a relie
lip_top_relief_height = -1; // 0.1
// 防滑凸起 / add a notch to the lip to prevent sliding.
lip_top_notches  = false;

/* [底座 / Base] */
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
flat_base = "off";

/* [调试 / debug] */
//Slice along the x axis
cutx = 0; //0.1
//Slice along the y axis
cuty = 0; //0.1
// 调试日志 / enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
//颜色显示 / assign colours to the bin, will may
set_colour = "enable"; //[disabled, enable, preview, lip]
//渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 最小角度精度 / minimum angle for a fragment (fragments = 360/fa).  Low is more fragments
fa = 6;
// 最小面精度 / minimum size of a fragment.  Low is more fragments
fs = 0.1;
// 段数精度 / number of fragments, overrides $fa and $fs
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001

/* [隐藏 / Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, height])
Gridfinity_Divider();

module Divider(
  height = 50,
  length = 100,
  baseHeight = 10,
  radius = 5,
  frontTopInset=20,
  frontTopAngle=65,
  backTopInset=20,
  backTopAngle=65
){
  _baseHeight = radius > baseHeight ? radius : baseHeight;

  _backBottomHeight = max(_baseHeight,height-radius-abs(backTopInset*tan(backTopAngle)));
  _frontBottomHeight = max(_baseHeight,height-radius-abs(frontTopInset*tan(frontTopAngle)));
  if(env_help_enabled("debug")) echo("Gridfinity_Divider", height,radius, abs(backTopInset*tan(backTopAngle)),_backBottomHeight);
  if(env_help_enabled("debug")) echo("Gridfinity_Divider", _baseHeight=_baseHeight, height=height, _backBottomHeight=_backBottomHeight, _frontBottomHeight=_frontBottomHeight);

  positions = [
    [radius,_frontBottomHeight],      //front bottom
    [radius+frontTopInset,height-radius],        //front top
    [length-radius-backTopInset,height-radius],  //back top
    [length-radius,_backBottomHeight] //back bottom
  ];

  //
  hull(){
    square([length,_baseHeight]);
    for(index =[0:1:len(positions)-1])
    {
      translate(positions[index])
        circle(r=radius);
    }
  }
}

module PatternedDivider(
  height = 50,
  length = 100,
  baseHeight = 10,
  width = 5,
  radius = 5,
  frontTopInset=20,
  frontTopAngle=65,
  backTopInset=20,
  backTopAngle=65,
  wallpatternEnabled = wallpattern_enabled,
  wallpatternBorder = wallpattern_border) {

  rotate([90,0,0])
  difference(){
  linear_extrude(height = width)
  Divider(
    height = height,
    length = length,
    baseHeight = baseHeight,
    radius = radius,
    frontTopInset=frontTopInset,
    frontTopAngle=frontTopAngle,
    backTopInset=backTopInset,
    backTopAngle=backTopAngle);

  if(wallpatternEnabled){
  translate([0,0,-fudgeFactor])
  intersection(){
    linear_extrude(height = width+fudgeFactor*2)
    offset(delta = -wallpatternBorder)
    Divider(
      height = height,
      length = length,
      baseHeight = baseHeight,
      radius = radius,
      frontTopInset=frontTopInset,
      frontTopAngle=frontTopAngle,
      backTopInset=backTopInset,
      backTopAngle=backTopAngle);

      children();
      }
    }
  }
}

module Gridfinity_Divider(
  width=width, depth=depth, height=height,
  position=position,
  filled_in=filled_in,
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
    flatBase=flat_base),
  wall_thickness=wall_thickness,
  lip_settings = LipSettings(
    lipStyle=lip_style,
    lipSideReliefTrigger=lip_side_relief_trigger,
    lipTopReliefHeight=lip_top_relief_height,
    lipNotch=lip_top_notches),
  dividerCount=divider_count,
  dividerHeight=divider_height,
  baseHeight=divider_base_height,
  dividerWidth=divider_width,
  radius=divider_radius,
  frontTopInset=divider_front_top_inset,
  frontTopAngle=divider_front_top_angle,
  backTopInset=divider_back_top_inset,
  backTopAngle=divider_back_top_angle,
  wallpatternEnabled=wallpattern_enabled,
  pattern_settings = PatternSettings(
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
    patternFs = wallpattern_pattern_quality)
    ) {

  num_x = calcDimensionWidth(width);
  num_y = calcDimensionDepth(depth);
  num_z = calcDimensionHeight(height);
  floorHeight = calculateFloorHeight(magnet_depth=magnet_size[1], screw_depth=screw_size[1], floor_thickness=floor_thickness,num_z=num_z, efficient_floor=cupBase_settings[iCupBase_EfficientFloor], flat_base=flat_base);

  gridfinity_cup(
    width=width, depth=depth, height=height,
    cupBase_settings=cupBase_settings,
    wall_thickness=wall_thickness,
    lip_settings = lip_settings,
    label_settings=LabelSettings(
      labelStyle="disabled"));

  for(i = [0 : divider_count-1]){
    canvis = [dividerHeight, num_x*env_pitch().x-env_clearance().x];
    ypos = (num_y*env_pitch().y-env_corner_radius()*2-dividerWidth)/(divider_count-1)*i;
    translate([env_clearance().x/2,env_corner_radius()+dividerWidth+ypos,floorHeight])
    PatternedDivider(
      height = canvis.x,
      length = canvis.y,
      baseHeight = baseHeight,
      width = dividerWidth,
      radius = radius,
      frontTopInset=frontTopInset,
      frontTopAngle=frontTopAngle,
      backTopInset=backTopInset,
      backTopAngle=backTopAngle,
      wallpatternEnabled = wallpatternEnabled){
        //translate([0,height+baseHeight,0])
        //rotate([0,0,-90])
        if(wallpatternEnabled)
        translate([canvis.y/2,canvis.x/2])
        /*cutout_pattern(
          patternStyle = wallpatternStyle,
          canvasSize = [canvis.y,canvis.x], //Swap x and y and rotate so hex is easier to print
          border=wallpattern_border*2,
          customShape = false,
          circleFn = wallpatternHoleSides,
          holeSize = wallpatternHoleSize,
          holeSpacing = [wallpatternHoleSpacing,wallpatternHoleSpacing],
          holeHeight = dividerWidth*2,
          holeRadius = wallpatternHoleRadius,
          center = true,
          fill = wallpatternFill, //"none", "space", "crop"
          patternGridChamfer=wallpatternGridChamfer,
          patternVoronoiNoise=wallpatternVoronoiNoise,
          patternBrickWeight=wallpatternBrickWeight,
          patternFs = wallpattern_pattern_quality);*/
        cutout_pattern(
          patternStyle = pattern_settings[iPatternStyle],
          canvasSize = [canvis.y,canvis.x],
          border = (pattern_settings[iPatternBorder] == 0 ? dividerWidth : pattern_settings[iPatternBorder])*2,
          customShape = false,
          circleFn = pattern_settings[iPatternHoleSides],
          cellSize = pattern_settings[iPatternCellSize],
          strength = pattern_settings[iPatternStrength],
          holeHeight = dividerWidth*2,
          center = true,
          fill = pattern_settings[iPatternFill],
          patternGridChamfer = pattern_settings[iPatternGridChamfer],
          patternVoronoiNoise = pattern_settings[iPatternVoronoiNoise],
          patternBrickWeight = pattern_settings[iPatternBrickWeight],
          partialDepth = pattern_settings[iPatternDepth] != 0,
          holeRadius = pattern_settings[iPatternHoleRadius],
          source = "Gridfinity Divider",
          rotateGrid = pattern_settings[iPatternRotate],
          patternFs = pattern_settings[iPatternFs]);
        }
    }
}