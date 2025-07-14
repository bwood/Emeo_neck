include <./Emeo_neck_library.scad>

// Subtract the clip to create a groove in the outer surface of the cap.
difference () {
  cap(capRadiusBottom,capRadiusTop);
  capClip();
}
