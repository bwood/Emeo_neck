include <./Emeo_neck_library.scad>


module cylindarBend(xpoint, diameter, angle) {
  rotate_extrude(angle=angle, convexity=10)
    translate([xpoint, 0])
        circle(d = diameter);

}

module tubeBend() {
    difference() {
        cylindarBend(xpoint = cbXpoint,
                     diameter = insTubeDiameterTop,
                     angle = cbAngle);
        
        cylindarBend(xpoint = cbXpoint,
                     diameter = insTubeDiameterInterior,
                     angle = cbAngle);
    }
    
}

module neckBentTop() {
  union() {
    neckTube(length = tubeLength);
    
    color("LimeGreen")
        translate([0, 0, tubeLength - eps]) 
            insTubeMpc();
  }
}

module neckBent() {
    
    tubeLength = tubeLength + 6;
    
    union() {
        color("LimeGreen")
            translate([0, 0, -insTubeBottomLength]) 
                insTubeBottom();
        
        neckDisc();

        translate([0, 0, -eps])
        neckTube(length = tubeLength);
        
        translate([0, cbXpoint, tubeLength - (eps * 2)])
            rotate([90, 0, -90])
                tubeBend();
        
        // Position the top section.
        translate([0, -10.5, insTubeDiameterTop - 0.25])
            rotate([-cbAngle, 0, 0])
                translate([0, 0, tubeLength +6 - (eps * 2)])
                    neckBentTop();    
    }

}



neckBent();
