include <./Emeo_neck_library.scad>

// The cap that fits around the top of the Emeo and clips onto the minuet holder.
module capWhole() {

    disc(thickness = capThickness * 2, radius = capRadius);

    translate ([0, 0, -capHeight])
        difference() {
            //Outer surface.
            //+ eps to ensure connection.
            cylinder(h = capHeight + eps,
                     r1 = capRadiusBottom + capThickness,
                     r2 = capRadius + capThickness
            );
            //Inner surface.
            cylinder(h = capHeight + eps,
                     r1 = capRadiusBottom,
                     r2 = capRadius
            );
        }

}

// Polygon to subtract from the cap.
module capSubtractor () {
    px = 20;
    py = -10;
    pz = px + py;

    height = capHeight + (capThickness * 2) + 2;

    translate([0, 0, -capHeight - 1])
    linear_extrude(height) {
        union() {
            color("LimeGreen")
                circle(d = insTubeDiameterTop);
            polygon(points = [
                    [0, 0],
                    [px, py],
                    [-px, py]
                ]);
            polygon(points = [
                    [px, py],
                    [-px, py],
                    [-px, py - pz],
                    [px, py - pz],
                ]);
        }
    }

}

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

// The assembled cap.
module cap() {
    difference() {
        difference() {
            // Create the spokes imprint on the underside of the cap disc.
            capWhole();
            discSpokes(
                thickness = capThickness,
                radius = capRadius - capThickness,
                numSpokes = numSpokes
            );
        }
        // Remove the side of the cap so that it can snap on the Emeo.
        capSubtractor();
    }
}

//cap();
capClip();
