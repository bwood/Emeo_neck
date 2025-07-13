include <./Emeo_neck_library.scad>
// A clip to secure the cap
module capClip() {

  extra = 10;
  difference() {
    difference() {
      cap(clipRadius,clipRadius);
      translate([0, 0, -topToMinuetBottom])
        cylinder(h = (clipThickness * 2)  + topToMinuetBottom + extra,
                 r = clipRadius + clipThickness + extra
                 );
   }
   translate([0, 0, -capHeight - eps])
      cylinder(h = clipBottomOffset,
               r = clipRadius + clipThickness + extra
               );
 }
}

// cap(capRadiusBottom, capRadiusTop);
// color("LimeGreen")
capClip();
