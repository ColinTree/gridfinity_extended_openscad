include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_cup.scad>
use <modules/module_gridfinity_block.scad>

/*<!!start gridfinity_sieve!!>*/
/* [Sieve] */
// 孔洞形状（方形/六边形） / Should the grid be square or hex
sieve_grid_style = "hexgrid"; //[grid, hexgrid]
// Spacing around the holes
sieve_strength = 3; //0.1
// 旋转图案网格 / rotate the grid
sieve_rotate_grid = false;
// 孔洞顶部45度倒角（mm） / 45 deg chamfer added to the top of the hole (mm)
sieve_hole_chamfer = 0; //0.5
// The number of sides for the hole, when custom is selected
sieve_hole_sides = 6;
// The size the hole, when custom is selected
sieve_cell_size = [10, 10]; //0.1
// 隔间间距 / Spacing around the compartments
sieve_compartment_clearance= 7; //0.1
sieve_compartment_fill = "none"; //["none", "space", "crop"]
/*<!!end gridfinity_sieve!!>*/

/*<!!start gridfinity_basic_cup!!>*/
/* [通用设置 / General Cup] */
// X轴 / X dimension.
width = [2, 0]; //0.5
// Y轴 / Y dimension.
depth = [1, 0]; //0.5
// Z轴 / Z dimension
height = [3, 0]; //0.1
// 外壁厚度 / Wall thickness of outer walls.
wall_thickness = 0;  // .01
//顶部余量（允许堆叠） / under size the bin top
headroom = 0.8; // 0.1

/* [唇边 / Cup Lip] */
// 唇边样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 唇边内侧减料触发尺寸 / Below this the inside of the lip will be reduced
lip_side_relief_trigger = [1,1]; //0.1
// 唇边顶部缺口高度 / Create a relie
lip_top_relief_height = -1; // 0.1
// 添加唇边防滑凸点 / add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [底座 / Base] */
// (Zack's design uses magnet diameter of 6.5)
// 底座开孔上方最小厚度 / Minimum thickness above cutouts in base
floor_thickness = 2;
cavity_floor_radius = -1;// .1
// 高效底板（省料省时，但底面不平整） / Efficient floor option saves material and time
efficient_floor = "smooth";//[off,on,rounded,smooth]
// 移除底座内部网格 / Removes the internal grid from base the shape
flat_base = true;

/* [标签 / Label] */
label_style = "disabled"; //[disabled: no label, normal:normal, gflabel:gflabel basic label, pred:pred - labels by pred, cullenect:Cullenect click labels V2,  cullenect_legacy:Cullenect click labels v1]
// 标签悬出方向 / Include overhang for labeling
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// 标签尺寸（宽度/深度/高度/圆角） / Width, Depth, Height, Radius. Width in Gridfinity units
label_size = [0,14,0,0.6]; // 0.01
// 标签浮雕尺寸（mm） / Size in mm of relief where appropriate.
label_relief = [0,0,0,0.6]; // 0.1
// 启用标签的墙面（前/后/左/右，0关闭 1开启） / wall to enable on, front, back, left, right. 0: disabled; 1: enabled;
label_walls=[0,1,0,0];  //[0:1:1]

/* [调试 / debug] */
//Slice the bin
cut = [0,0,0]; //0.1
// 渲染时输出帮助信息 / enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
//为收纳盒着色 / assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//模型渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 最小圆弧角度（越小越精细） / minimum angle for a fragment
fa = 6;
// 最小面尺寸（越小越精细） / minimum size of a fragment.
fs = 0.1;
// 圆弧段数（覆盖 $fa 和 $fs） / number of fragments, overrides $fa and $fs
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

function addClearance(dim, clearance) =
    [dim.x > 0 ? dim.x+clearance : 0
    ,dim.y > 0 ? dim.y+clearance : 0
    ,dim.z];

// Generates the gridfinity bin with cutouts.
// Runs the function without needing to pass the variables.
module gridfinity_sieve(
  //sieve settings
  sieve_grid_style = sieve_grid_style,
  sieve_hole_sides = sieve_hole_sides,
  sieve_rotate_grid = sieve_rotate_grid,
  sieve_cell_size = sieve_cell_size,
  sieve_strength = sieve_strength,
  sieve_hole_chamfer = sieve_hole_chamfer,
  sieve_compartment_clearance = sieve_compartment_clearance,
  sieve_compartment_fill  = sieve_compartment_fill,

  //gridfinity settings
  width=width, depth=depth, height=height,
  position=render_position,
  label_settings=LabelSettings(
    labelStyle=label_style,
    labelPosition=label_position,
    labelSize=label_size,
    labelRelief=label_relief,
    labelWalls=label_walls),
  cupBase_settings = CupBaseSettings(
    magnetSize = [0,0],
    centerMagnetSize = [0,0],
    screwSize = [0,0],
    floorThickness = floor_thickness,
    cavityFloorRadius = cavity_floor_radius,
    efficientFloor=efficient_floor,
    subPitch=1,
    flatBase=flat_base,
    spacer=false),
  wall_thickness=wall_thickness,
  lip_settings = LipSettings(
    lipStyle=lip_style,
    lipSideReliefTrigger=lip_side_relief_trigger,
    lipTopReliefHeight=lip_top_relief_height,
    lipNotch=lip_top_notches)) {

  difference() {
    num_x = calcDimensionWidth(width);
    num_y = calcDimensionDepth(depth);
    num_z = calcDimensionHeight(height);

    cellSize = is_list(sieve_cell_size) ? sieve_cell_size : [sieve_cell_size, sieve_cell_size];
    /*<!!start gridfinity_basic_cup!!>*/
    gridfinity_cup(
      width=width, depth=depth, height=height,
      label_settings=label_settings,
      filled_in=false,
      cupBase_settings=cupBase_settings,
      wall_thickness=wall_thickness,
      lip_settings=lip_settings,
      headroom=headroom,
        floor_pattern_settings = PatternSettings(
          patternEnabled = true,
          patternStyle = sieve_grid_style,
          patternFill = sieve_compartment_fill,
          patternBorder = sieve_compartment_clearance,
          patternCellSize = cellSize,
          patternStrength = sieve_strength,
          patternHoleSides = 6,
          patternRotate = sieve_rotate_grid,
          patternGridChamfer = sieve_hole_chamfer));
    /*<!!end gridfinity_basic_cup!!>*/
  }
}

set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  cut = cut)
gridfinity_sieve();