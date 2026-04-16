// include instead of use, so we get the pitch
include <modules/gridfinity_constants.scad>
use <modules/module_gridfinity_baseplate_common.scad>

/* [FLSUN Q5 底板 / FLSUN Q5 Baseplate] */
// 螺孔间距（mm），FLSUN Q5 现有螺孔间距 / Distance between existing screw holes on FLSUN Q5
ear_hole_x = 182.5; // distance between existing screw holes on FLSUN q5.
// 前面板螺孔距离（mm） / Distance of screw hole from the front panel
ear_hole_y = 7; // distance of screw hole from the front panel.
// 底板高度（mm） / Height from top
cube_z = 4.4; // ht from above.
// M4 螺栓直径（mm） / Diameter needed for an M4 bolt
M4_d = 4.2; // diameter needed for an M4 bolt.
// 壁厚延伸量（mm），嵌入墙角 / Extend and imbed into wall to fit around corner
wallThickness = 0.2; //Extend and imbed in to wall to fit around corner

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
