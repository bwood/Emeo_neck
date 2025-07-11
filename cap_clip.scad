include <./Emeo_neck_library.scad>
// A clip to secure the cap
module capClip() {
  extra = 10;
  difference() {
    difference() {
      cap();
      translate([0, 0, -topToMinuetBottom])
        cylinder(h = (capThickness * 2)  + topToMinuetBottom + extra,
                 r = capRadius + capThickness + extra
                 );
   }
    translate([0, 0, -capHeight - eps])
      cylinder(h = capHeight - topToMinuetBottom - clipThickness + eps,
               r = capRadius + capThickness + extra
               );
 }
}

capClip();
