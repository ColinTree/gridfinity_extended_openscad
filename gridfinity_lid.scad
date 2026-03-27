// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_block.scad>
use <modules/module_gridfinity_lid.scad>

/* [尺寸 / Size] */
// X轴 / X dimension.
width = [2, 0]; //0.1
// Y轴 / Y dimension.
depth = [1, 0]; //0.1
center_fill_grid_x = true;
center_fill_grid_y = true;

/* [盖子 / Lid] */
// 底板样式 / Plate Style
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

/* [底板选项 / Base Plate Options] */
// 启用磁铁（位于角落） / Enable magnets in the bin corner
Enable_Magnets = true;
//磁铁尺寸（直径和高度） / size of magnet, diameter and height.
Magnet_Size = [6.5, 2.4];  // .1
//将框架壁高度减小到此值 / Reduce the frame wall size to this value
Reduced_Wall_Height = -1; //0.1

/* [盖子选项 / Lid Options] */
Lid_Include_Magnets = true;
// 底座高度（收纳盒放置高度，GF单位） / Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// 高效底板厚度 / Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

/* [调试 / debug] */
//沿X轴切片（调试） / Slice along the x axis
cutx = 0; //0.1
//沿Y轴切片（调试） / Slice along the y axis
cuty = 0; //0.1
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

/* [Hidden] */
module end_of_customizer_opts() {}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

set_environment(
  width = width,
  depth = depth,
  render_position = render_position,
  help = enable_help,
  cut = [cutx, cuty, 2],
  setColour = set_colour)
gridfinity_lid(
  num_x = calcDimensionWidth(width),
  num_y = calcDimensionWidth(depth),
  center_fill_grid_x = center_fill_grid_x,
  center_fill_grid_y = center_fill_grid_y,
  magnetSize = Enable_Magnets ? Magnet_Size : [0,0],
  reducedWallHeight = Reduced_Wall_Height,
  lidOptions = Lid_Options,
  lidIncludeMagnets = Lid_Include_Magnets,
  lidEfficientFloorThickness = Lid_Efficient_Floor_Thickness,
  lidEfficientBaseHeight = Lid_Efficient_Base_Height);