// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_baseplate_common.scad>

/* [FLSUN Q5 底板参数 / FLSUN Q5 Baseplate Parameters] */
// FLSUN Q5 螺丝孔间距 / distance between existing screw holes on FLSUN q5.
ear_hole_x = 182.5;
// 螺丝孔距前板距离 / distance of screw hole from the front panel.
ear_hole_y = 7;
// 底板高度（从上方测量）/ ht from above.
cube_z = 4.4;
// M4 螺栓所需孔径 / diameter needed for an M4 bolt.
M4_d = 4.2;
// 延伸嵌入墙体以贴合转角 / Extend and imbed in to wall to fit around corner
wallThickness = 0.2;

/* [Hidden] */
module end_of_customizer_opts() {}

from_ends = (ear_hole_x - gf_pitch*4) / 2;

union(){
  frame_plain(4, 1, height = cube_z);

  for (i = [0,1]) {
    x = i * ear_hole_x - from_ends-wallThickness;
    difference() {
      hull() {
        translate([x, ear_hole_y, 0])
          cylinder(h=cube_z, d=M4_d*2, $fn=20);
        translate([x - from_ends * i, ear_hole_y - M4_d, 0])
          cube([from_ends+wallThickness, M4_d*2, cube_z]);
      }
        translate([x, ear_hole_y, -0.01])
          cylinder(h=cube_z + 0.02, d=M4_d, $fn=20);
    }
  }
}
