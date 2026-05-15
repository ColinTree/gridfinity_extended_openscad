// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_baseplate_common.scad>

/* [FLSUN Q5 底板 / FLSUN Q5 Baseplate] */
// 耳孔X轴间距 / Distance between existing screw holes on FLSUN Q5 (mm)
ear_hole_x = 182.5;
// 耳孔Y轴偏移 / Distance of screw hole from the front panel (mm)
ear_hole_y = 7;
// 底板厚度 / Height/thickness of the base (mm)
cube_z = 4.4;
// M4孔径 / Diameter for M4 bolt hole (mm)
M4_d = 4.2;
// 墙体嵌入厚度 / Extend and embed into wall to fit around corner (mm)
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
