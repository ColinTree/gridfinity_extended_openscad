include <modules/module_gridfinity.scad>
use <modules/module_gridfinity_cup.scad>

/* [Utensil count and measurements] */
// Utensil definitions above this number are ignored
number_of_utensils = 5;

//utensil, narrow, wide, length, position
utensil_1 = [30, 0, 202, 1];
utensil_2 = [35, 0, 181, 2];
utensil_3 = [14, 37, 181, 3];
utensil_4 = [12, 33, 155, 4];
utensil_5 = [15, 32, 191, 5];
utensil_6 = [15, 32, 150, 6];
utensil_7 = [16, 24, 180, 7];
utensil_8 = [15, 28, 202, 8];
utensil_9 = [14, 24, 181, 9];
utensil_10 = [14, 37, 181, 10];
utensil_11 = [12, 33, 155, 11];
utensil_12 = [15, 32, 191, 12];
utensil_13 = [15, 32, 150, 13];
utensil_14 = [16, 24, 180, 14];

// Clearance on sides and ends of utensils
utensil_margin = 5;  // .1

// Height upper surface excluding perimeter lip. . grid units (multiples of 7mm) or mm.
height = [0, 42];

/* [Other parameters] */
// 壁厚 [底部, 顶部] / Wall thickness [bottom, top]
chamber_wall_thickness = [4, -2]; //0.1
//隔间壁高缩减量 / Reduce the wall height by this amount
chamber_wall_headroom = 0;//0.1
// 隔间壁顶部圆角 / Radius of the top of the chamber wall
chamber_wall_top_radius = -2; //0.1
vertical_separator_bend_angle = 45;
vertical_separator_bend_position = 0;
vertical_separator_cut_depth=0;

/*<!!start gridfinity_basic_cup!!>*/
/* [通用设置 / General Cup] */
// 填实为实心块 / Fill in solid block
filled_in = "disabled"; //[disabled, enabled, enabledfilllip:"Fill cup and lip"]
// 外壁厚度 / Wall thickness of outer walls.
wall_thickness = 0;  // .01
//顶部余量（允许堆叠） / under size the bin top
headroom = 0.8; // 0.1

/* [唇边 / Cup Lip] */
// 唇边样式 / Style of the cup lip
lip_style = "normal";  // [ normal, reduced, minimum, none:not stackable ]
// 唇边内侧减料触发尺寸 / Below this the inside of the lip will be reduced
lip_side_relief_trigger = [1,1]; //0.1
// Create a relief
lip_top_relief_height = -1; // 0.1
// 添加唇边防滑凸点 / add a notch to the lip to prevent sliding.
lip_top_notches  = true;

/* [底座 / Base] */
// 启用磁铁 / Enable magnets
enable_magnets = false;
// 启用螺丝 / Enable screws
enable_screws = false;
//磁铁尺寸（直径和高度） / size of magnet, diameter and height.
magnet_size = [6.5, 2.4];  // .1
//磁铁取出缺口 / create relief for magnet removal
magnet_easy_release = "auto";//["off","auto","inner","outer"]
//螺丝尺寸（直径和高度） / size of screw, diameter and height.
screw_size = [3, 6]; // .1
//中心磁铁尺寸（直径和高度） / size of center magnet, diameter and height.
center_magnet_size = [0,0];
// 桥接过渡孔悬空补救方式 / Sequential Bridging hole overhang remedy
hole_overhang_remedy = 2;
//仅在角落添加磁铁/螺丝（加快打印） / Only add attachments (magnets and screw) to box corners
box_corner_attachments_only = "enabled"; //["disabled","enabled","aligned"]
// 底座开孔上方最小厚度 / Minimum thickness above cutouts in base
floor_thickness = 0.7;
cavity_floor_radius = -1;// .1
// 高效底板（省料省时，但底面不平整） / Efficient floor option saves material and time
efficient_floor = "off";//[off,on,rounded,smooth]
// 半间距（细分底部格）/ AKA half pitch.
sub_pitch = 1; //[1:"disabled",2:"half pitch",3:"third pitch",4:"quarter pitch"]
// 移除底座内部网格 / Removes the internal grid from base the shape
flat_base = "off"; // [off, gridfinity:gridfinity stackable, rounded]
// 移除底板以创建垫片 / Remove floor to create a vertical spacer
spacer = false;
//小于此尺寸的底脚不渲染 / Pads smaller than this will not be rendered
minimum_printable_pad_size = 0.2;
// 圆形平底半径（-1 使用角半径） / Adjust the radius of the rounded flat base.
flat_base_rounded_radius = -1;
// 圆底角倒角（便于打印） / Add chamfer to the rounded bottom corner
flat_base_rounded_easyPrint = -1;

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

/* [手指槽 / Finger Slide] */
// 添加较大圆角（手指槽） / Include larger corner fillet
fingerslide = "none"; //[none, rounded, chamfered]
// 圆角半径 / Radius of the corner fillet, 0:none
fingerslide_radius = 8;
// 启用手指槽的墙面 / wall to enable on, front, back, left, right. 0: disabled; 1: enabled using radius
fingerslide_walls=[1,0,0,0];
//手指槽与唇边对齐 / Align the fingerslide with the lip
fingerslide_lip_aligned=true;

/* [锥形角 / Tapered Corner] */
tapered_corner = "none"; //[none, rounded, chamfered]
tapered_corner_size = 10;
// 锥形角退让量（默认为圆角半径） / Set back of the tapered corner, default is the gridfinity corner radius
tapered_setback = -1;//gridfinity_corner_radius/2;

/* [墙面图案 / Wall Pattern] */
// 启用网格墙面图案 / Grid wall patter
wallpattern_enabled=false;
// 图案样式 / Style of the pattern
wallpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
wallpattern_strength = 2; //0.1
// 启用图案的墙面（前/后/左/右） / wall to enable on, front, back, left, right.
wallpattern_walls=[1,1,1,1];  //[0:1:1]
// 旋转图案网格 / rotate the grid
wallpattern_rotate_grid=false;
//孔洞尺寸 / Size of the hole
wallpattern_cell_size = [10,10]; //0.1
// 将图案应用到分隔板 / Add the pattern to the dividers
wallpattern_dividers_enabled="disabled"; //[disabled, horizontal, vertical, both]
//孔洞边数 / Number of sides of the hole op
wallpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//孔洞圆角半径 / Radius of corners
wallpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
wallpattern_fill = "none"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 图案边框宽度（默认为壁厚） / border around the wall pattern, default is wall thickness
wallpattern_border = 0;
// 图案压印深度（mm，0=全壁厚） / depth of imprint in mm, 0 = is wall width.
wallpattern_depth = 0; // 0.1
//网格图案孔倒角 / grid pattern hole taper
wallpattern_pattern_grid_chamfer = 0; //0.1
//Voronoi图案噪声 / voronoi pattern noise,
wallpattern_pattern_voronoi_noise = 0.75; //0.01
//砖块图案中心权重 / brick pattern center weight
wallpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
wallpattern_pattern_quality = 0.4;//0.1:0.1:2
wallpattern_colored = "disabled"; //[disabled, enabled]


/* [底面图案 / Floor Pattern] */
// 启用底面图案 / enable Grid floor patter
floorpattern_enabled=false;
// 图案样式 / Style of the pattern
floorpattern_style = "hexgrid"; //[hexgrid, grid, voronoi, voronoigrid, voronoihexgrid, brick, brickoffset]
// 图案间距 / Spacing between pattern
floorpattern_strength = 2; //0.1
// 旋转图案网格 / rotate the grid
floorpattern_rotate_grid = false;
//孔洞尺寸 / Size of the hole
floorpattern_cell_size = [10,10]; //0.1
//孔洞边数 / Number of sides of the hole op
floorpattern_hole_sides = 6; //[4:square, 6:hex, 8:octo, 64:circle]
//孔洞圆角半径 / Radius of corners
floorpattern_hole_radius = 0.5;
// 图案填充模式 / pattern fill mode
floorpattern_fill = "crop"; //[none, space, crop, crophorizontal, cropvertical, crophorizontal_spacevertical, cropvertical_spacehorizontal, spacevertical, spacehorizontal]
// 图案边框宽度（默认为壁厚） / border around the wall pattern, default is wall thickness
floorpattern_border = 0;
// 图案压印深度（mm，0=全壁厚） / depth of imprint in mm, 0 = is wall width.
floorpattern_depth = 0; // 0.1
//网格图案孔倒角 / grid pattern hole taper
floorpattern_pattern_grid_chamfer = 0; //0.1
//Voronoi图案噪声 / voronoi pattern noise,
floorpattern_pattern_voronoi_noise = 0.75; //0.01
//砖块图案中心权重 / brick pattern center weight
floorpattern_pattern_brick_weight = 5;
//$fs for floor pattern, min size face.
floorpattern_pattern_quality = 0.4;//0.1:0.1:2

/* [墙面开孔 / Wall Cutout] */
wallcutout_horizontal ="inneronly"; //[disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// 开孔位置（-0.5:禁用，正数:GF单位，负数:比例）/ wallcoutout position -0.5: disabled;
wallcutout_horizontal_position=[-2,-0.5,-0.5,-0.5];  //0.01
//开孔宽度（默认=箱宽/2） / default will be binwidth/2
wallcutout_horizontal_width=0;
wallcutout_horizontal_angle=70;
//开孔高度（默认=箱高） / default will be binHeight
wallcutout_horizontal_height=-1.5; //0.1
wallcutout_horizontal_corner_radius=5;

/* [可扩展 / Extendable] */
extension_x_enabled = "disabled"; //[disabled, front, back]
extension_x_position = 0.5;
extension_y_enabled = "disabled"; //[disabled, front, back]
extension_y_position = 0.5;
extension_tabs_enabled = true;
//延伸卡扣尺寸（高/宽/厚/样式） / Tab size, height, width, thickness, style.
extension_tab_size= [10,0,0,0];

/* [底部文字 / Bottom Text] */
// 在底部添加尺寸文字 / Add bin size to bin bottom
text_1 = false;
// 文字字号（mm，0自动） / Font Size of text, in mm
text_size = 0; // 0.1
// 文字深度（mm） / Depth of text, in mm
text_depth = 0.3; // 0.01
// 使用字体 / Font to use
text_font = "Aldo";  // [Aldo, B612, "Open Sans", Ubuntu]
// 在底部添加自定义文字 / Add free-form text line to bin bottom
text_2 = false;
// 自定义文字内容 / Actual text to add
text_2_text = "Gridfinity Extended";

/* [调试 / debug] */
// 调试切片 / Debug slice
cut = [0,0,0]; //0.1
// 渲染时输出帮助信息 / enable loging of help messages during render.
enable_help = "disabled"; //[info,debug,trace]

/* [模型细节 / Model detail] */
//（实验性）修改默认网格尺寸，会影响兼容性 / Work in progress,  Modify the default grid size. Will break compatibility
pitch = [42,42,7];  //[0:1:9999]
//为收纳盒着色 / assign colours to the bin
set_colour = "enable"; //[disabled, enable, preview, lip]
//模型渲染位置 / where to render the model
render_position = "center"; //[default,center,zero]
// 最小圆弧角度（越小越精细） / minimum angle for a fragment
fa = 6;
// 最小面尺寸（越小越精细） / minimum size of a fragment.
fs = 0.4;
// 圆弧段数（覆盖 $fa 和 $fs） / number of fragments, overrides $fa and $fs
fn = 0;
// 随机种子 / set random seed for
random_seed = 0; //0.0001
// 强制渲染高代价组件 / force render on costly components
force_render = true;


module end_of_customizer() {}
silverware_wall_clearance = 5.7;
// Maximum utensil definitions
silver_defs_all = [
  utensil_1,
  utensil_2,
  utensil_3,
  utensil_4,
  utensil_5,
  utensil_6,
  utensil_7,
  utensil_8,
  utensil_9,
  utensil_10,
  utensil_11,
  utensil_12,
  utensil_13,
  utensil_14
];

function get_utensil_def(index, defs_list) =
  let(
    matchResults = search(index, defs_list, num_returns_per_match=1, index_col_num=3),
    matchIndex = is_list(matchResults) && len(matchResults)==1 && is_num(matchResults[0]) ? matchResults[0]: undef,
    matchValue = is_num(matchIndex) ? silver_defs_all[matchIndex] : undef,
    utensil = is_undef(matchValue) ? [0,0,0] : [matchValue.x, max(matchValue.x, matchValue.y), matchValue.z]
    ) utensil;

// ##### Utility functions
// tail of a list with at least 2 elements
function cdr(list) = [ for (i=[1:len(list)-1]) list[i] ];
// sum of a bunch of values (recursive functional style)
function vecsum(vals) = len(vals) > 1 ? vals[0] + vecsum(cdr(vals)) : vals[0];
// total width of a list of utensils
function totwidth(defs, margin = utensil_margin) = vecsum(pitches(defs)) + 2*margin +
  max(defs[0][0], defs[0][1])/2 + max(defs[len(defs)-1][0], defs[len(defs)-1][1])/2;
// maximum length of list of utensils
function maxlen(defs) = len(defs) > 1 ? max(defs[0][2], maxlen(cdr(defs))) : defs[0][2];
// convert a list of utensils into a list of center-to-center distances
function pitches(defs, thickness = chamber_wall_thickness[0], margin = utensil_margin) = [ for (i=[0:len(defs)-2]) thickness + 2*margin +
  max( defs[i][1]/2 + defs[i+1][0]/2, defs[i][0]/2 + defs[i+1][1]/2) ];

// ##### Derived variables and values
// subset of all utensil definitions up to the requested number of utensils
silver_defs = [ for (i=[1:number_of_utensils]) get_utensil_def(i, silver_defs_all) ];

// X, width of combination of all silverware, in gridfinity units
width = ceil((totwidth(silver_defs) + silverware_wall_clearance)/42);
// Y, max depth of all silverware, in gridfinity units
depth = ceil((maxlen(silver_defs)+2*utensil_margin + silverware_wall_clearance)/42);
// gridfinity modules expect height in units of 7 mm (but fractions are allowed)
num_z = calcDimensionHeight(height);


function sum_(list, c = 0, end) =
  let(end = is_undef(end) ? len(list) : end)
  c < 0 || end < 0 ? 0 :
  c < len(list) - 1 && c < end
    ? list[c] + sum(list, c + 1, end=end)
    : list[c];

// convert a list of utensils into a list of center-to-center distances
function pitches_(defs, thickness = chamber_wall_thickness[0], margin=utensil_margin) =
  [ for (i=[0:len(defs)-2])
    thickness + 2*margin + max( defs[i][1]/2 + defs[i+1][0]/2, defs[i][0]/2 + defs[i+1][1]/2)
  ];

function calculate_dividers (cells, xtop=0, xbot=0, index=0, inverted=false, thickness=chamber_wall_thickness[0], margin=utensil_margin) =
    let(cell = cells[index],

      cell_top_w = thickness + margin * 2 + (inverted ? cell[1] : cell[0]),
      cell_bot_w = thickness + margin * 2 + (inverted ? cell[0] : cell[1]),
      cell_middle_pos = max(xtop+cell_top_w/2, xbot+cell_bot_w/2),
      wall_deviation = abs(cell_top_w - cell_bot_w)/2,
      wall_position = cell_middle_pos + max(cell_top_w, cell_bot_w)/2-wall_deviation/2,

      next_xtop = cell_middle_pos + cell_top_w/2,
      next_xbot = cell_middle_pos + cell_bot_w/2,
      currentDivider = [wall_position, wall_deviation, vertical_separator_bend_angle * (inverted ? 1 : -1)])
      echo("calculate_dividers", index=str(index, " of ", lenCells=len(cells)), input=cell, cell_size_needed = [cell_top_w,cell_bot_w], cell_middle_pos=cell_middle_pos, wall_position=wall_position, currentDivider)
      len(cells)-2<=index
        ? [currentDivider]
         : concat([currentDivider], calculate_dividers(cells, xtop=next_xtop, xbot=next_xbot, index=index+1, !inverted, thickness=thickness, margin=margin));

// ##### Modules
// top level generator
module silverware_pockets(defs, md=magnet_size[1], sd=screw_size[1]) {
  apply_spacing_silverware = true;
  mag_ht = md > 0 ? 2.4: 0;
  m3_ht = sd;
  part_ht = 5;  // height of bottom side groove between gridfinity units
  floorht = max(mag_ht, m3_ht, part_ht) + floor_thickness;

  utensil_margin = utensil_margin + (apply_spacing_silverware ? ((width*42-(totwidth(silver_defs) + silverware_wall_clearance))/len(defs))/2 : 0);
  echo("silverware_pockets", defs = defs);
  echo("silverware_pockets", thickness=chamber_wall_thickness[0], margin=utensil_margin);
  dividers = calculate_dividers(cells=defs, inverted=true, thickness=chamber_wall_thickness[0], margin=utensil_margin);
  echo("silverware_pockets", dividers = dividers);

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
      magnetSize = enable_magnets?magnet_size:[0,0],
      magnetEasyRelease = magnet_easy_release,
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
      flatBaseRoundedEasyPrint = flat_base_rounded_easyPrint),
    wall_thickness=wall_thickness,
    vertical_chambers = ChamberSettings(
      chamber_wall_thickness = chamber_wall_thickness,
      chamber_wall_headroom = chamber_wall_headroom,
      chamber_wall_top_radius = chamber_wall_top_radius,
      separator_bend_position = vertical_separator_bend_position,
      separator_bend_angle = vertical_separator_bend_angle,
      separator_cut_depth = vertical_separator_cut_depth,
      irregular_subdivisions = true,
      separator_config = dividers),
    horizontal_chambers = ChamberSettings(),
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
    wallcutout_vertical_settings = WallCutoutSettings(),
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
    cupBaseTextSettings = CupBaseTextSettings(
      baseTextLine1Enabled = text_1,
      baseTextLine2Enabled = text_2,
      baseTextLine2Value = text_2_text,
      baseTextFontSize = text_size,
      baseTextFont = text_font,
      baseTextDepth = text_depth));
}

//Some online generators do not like direct setting of fa,fs,fn
$fa = fa;
$fs = fs;
$fn = fn;

// ##### Top level model
set_environment(
  width = width,
  depth = depth,
  height = height,
  render_position = render_position,
  help = enable_help,
  pitch = pitch,
  cut = cut,
  setColour = set_colour,
  randomSeed = random_seed,
  force_render = force_render)
silverware_pockets(silver_defs);