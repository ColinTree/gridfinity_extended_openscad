// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_baseplate_common.scad>

/* [FLSUN Q5 参数 / FLSUN Q5 Parameters] */
// 现有螺丝孔之间的距离（mm） / Distance between existing screw holes on FLSUN Q5.
ear_hole_x = 182.5;
// 螺丝孔到前面板的距离（mm） / Distance of screw hole from the front panel.
ear_hole_y = 7;
// 底板高度（mm） / Height from above.
cube_z = 4.4;
// M4螺栓所需直径（mm） / Diameter needed for an M4 bolt.
M4_d = 4.2;

// 延伸并嵌入墙体的厚度（mm） / Extend and imbed into wall to fit around corner.
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
