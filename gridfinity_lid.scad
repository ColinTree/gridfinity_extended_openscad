// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_block.scad>
use <modules/module_gridfinity_lid.scad>

/* [Size / 尺寸] */
// X轴 / X dimension. grid units (multiples of 42mm) or mm.
width = [2, 0]; //0.1
// Y轴 / Y dimension. grid units (multiples of 42mm) or mm.
depth = [1, 0]; //0.1
center_fill_grid_x = true;
center_fill_grid_y = true;

/* [Lid / 盖板] */
// 盖板样式 / Plate Style
Lid_Options = "default";//[default, flat:Flat Removes the internal grid from base, halfpitch: halfpitch base, efficient]

/* [Base Plate Options / 底板选项] */
// 启用磁铁 / Enable magnets in the bin corner
Enable_Magnets = true;
// 磁铁尺寸（直径和高度） / size of magnet, diameter and height. Zacks original used 6.5 and 2.4
Magnet_Size = [6.5, 2.4];  // .1
// 框架墙高度限制 / Reduce the frame wall size to this value
Reduced_Wall_Height = -1; //0.1

/* [Lid Options / 盖板选项] */
Lid_Include_Magnets = true;
// 高效底座高度（GF单位） / Base height, when the bin on top will sit, in GF units
Lid_Efficient_Base_Height = 0.4;// [0.4:0.1:1]
// 高效底面厚度 / Thickness of the efficient floor
Lid_Efficient_Floor_Thickness = 0.7;// [0.7:0.1:7]

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