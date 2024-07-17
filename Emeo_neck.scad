include <./Emeo_neck_library.scad>
// https://github.com/Irev-Dev/Round-Anything
use <../Round-Anything/polyround.scad>


// Create the conical tube that inserts into the Emeo receptical at the top of the instrument.
module insTubeBottom () {
    
    difference() {
        difference() {
            // Outer cylinder surface.
            cylinder(h = insTubeBottomLength, 
                     d1 = insTubeDiameterBottom,
                     d2 = insTubeDiameterTop);

            // Inner cylinder surface.
            cylinder(h = insTubeBottomLength, 
                     d1 = insTubeDiameterInterior,
                     d2 = insTubeDiameterInterior);
      
        }
        translate([0, 0, flexRingLengthDiff / 2])
            flexRing(
                        length = insTubeBottomLength,
                        diameterBottom = insTubeDiameterBottom,
                        diameterTop = insTubeDiameterTop,
                        flexRingOuterClearance = 3
                    );
    
    }

}

// Create the conical tube that inserts into the mouthpiece.
module insTubeMpc() {
    
    d1Outer = insTubeMpcDiameterBottom - insTubeClearance;
    d2Outer = insTubeMpcDiameterTop - insTubeClearance;
    
    dInner = insTubeDiameterInterior;
    
    
    if (debug) {
        echo("");
        echo("Function: insTubeMpc");
        echo("insTubeMpcLength = ", insTubeMpcLength);
        echo("insTubeClearance = ", insTubeClearance);
        echo("d1Outer = ", d1Outer);
        echo("d2Outer =", d2Outer);
        echo("dInner = ", dInner);
        
    }

    difference() {
        difference() {
            // Outer cylinder surface.
            cylinder(h = insTubeMpcLength, 
                     d1 = d1Outer,
                     d2 = d2Outer);
  
          // Inner cylinder surface
            cylinder(h = insTubeMpcLength, 
                     d = dInner);
           
        }
        
        // Cutout for the flex ring.
        translate([0, 0, flexRingLengthDiff / 2])
            flexRing(
                        length = insTubeMpcLength,
                        diameterBottom = insTubeMpcDiameterBottom,
                        diameterTop = insTubeMpcDiameterTop
                    );
    }
    
}

// The neck tube that connects the two insTubes.
module neckTube() {
    dOuter = insTubeDiameterTop;
    dInner = insTubeDiameterInterior;
    
    difference() {
        cylinder(h = tubeLength,
                 d = dOuter);
        
        cylinder(h = tubeLength,
                 d = dInner);
    }
}

module capDisc(thickness, radius) {
    capThicknessTop = thickness;
    
    capRadii = [
        [0,0,0], 
        [0, capThicknessTop, 0], 
        [radius + capThickness, capThicknessTop, 2], 
        [radius + capThickness, 0, 0]
    ];
    
    rotate_extrude() {
        polygon(
            polyRound(capRadii, 30)
        );
    }
    
}

// The cap that fits around the top of the Emeo and clips onto the minuet holder.
module capWhole() {
    
    capDisc(thickness = capThickness * 2, radius = capRadius);
    
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
    py = -5;
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

module cap() {
    difference() {
        capWhole();
        capSubtractor();
    }
}

// Assemble the entire neck.
module neck() {

    color("LimeGreen")
        translate([0, 0, -insTubeBottomLength]) 
            insTubeBottom();
    
    capDisc(thickness = capThickness, radius = capRadius - capThickness);
    
    neckTube();
    
    color("LimeGreen")
        translate([0, 0, tubeLength]) 
            insTubeMpc();
}
neck();
//cap();

