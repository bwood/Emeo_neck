include <./Emeo_neck_library.scad>
// https://github.com/Irev-Dev/Round-Anything
use <../Round-Anything/polyround.scad>


// Create the conical tube that inserts into the Emeo receptical at the top of the instrument.
module insTubeBottom () {
    
    difference() {
        difference() {
            // Outer cylinder surface.
            cylinder(h = insTubeBottomLength, 
                     r1 = insTubeDiameterBottom,
                     r2 = insTubeDiameterTop);

            // Inner cylinder surface.
            cylinder(h = insTubeBottomLength, 
                     r1 = insTubeDiameterInterior,
                     r2 = insTubeDiameterInterior);
      
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
    
    r1Outer = insTubeMpcDiameterBottom - insTubeClearance;
    r2Outer = insTubeMpcDiameterTop - insTubeClearance;
    
    rInner = insTubeDiameterInterior;
    
    
    if (debug) {
        echo("");
        echo("Function: insTubeMpc");
        echo("insTubeMpcLength = ", insTubeMpcLength);
        echo("insTubeClearance = ", insTubeClearance);
        echo("r1Outer = ", r1Outer);
        echo("r2Outer =", r2Outer);
        echo("rInner = ", rInner);
        
    }

    difference() {
        difference() {
            // Outer cylinder surface.
            cylinder(h = insTubeMpcLength, 
                     r1 = r1Outer,
                     r2 = r2Outer);
  
          // Inner cylinder surface
            cylinder(h = insTubeMpcLength, 
                     r = rInner);
           
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

// The cap that fits around the top of the Emeo and clips onto the minuet holder.
module capWhole() {
    capRadii = [
        [0,0,0], 
        [0, capThickness, 0], 
        [capRadius + capThickness, capThickness, 2], 
        [capRadius + capThickness, 0, 0]
    ];
    
    rotate_extrude() {
        polygon(
            polyRound(capRadii, 30)
        );
    }
    
    translate ([0, 0, -capHeight])
        difference() { 
            //Outer surface.
            //+ eps to ensure connection.
            cylinder(h = capHeight + eps,
                     r1 = capRadius + capThickness,
                     r2 = capRadiusBottom + capThickness
            );
            //Inner surface.
            cylinder(h = capHeight + eps,
                     r1 = capRadius,
                     r2 = capRadiusBottom
            );
        }
}

// Polygon to subtract from the cap.
module capSubtractor () {
    px = 20;
    py = -5;
    pz = px + py;
    
    height = capHeight + capThickness + 2;
    
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
    
    neckTube();
    
    color("LimeGreen")
        translate([0, 0, tubeLength]) 
            insTubeMpc();
}
neck();
cap();

