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

//
module disc(thickness, radius, pRound = 2) {
    capThicknessTop = thickness;
    
    capRadii = [
        [0,0,0], 
        [0, capThicknessTop, 0], 
        [radius + capThickness, capThicknessTop, pRound], 
        [radius + capThickness, 0, 0]
    ];
    
    rotate_extrude() {
        polygon(
            polyRound(capRadii, 30)
        );
    }
    
}

module spoke(angle, radius, discThickness) {
    z = discThickness;
    
    if (debug) {
        echo("spoke: angle=", angle);
        echo("spoke: radius=", radius);
        echo("spoke: z=", z);
    }

    rotate([0, 0, angle])
        translate([radius / 2, 0, z])
            rotate([0, 90, 0])
                cylinder(h = radius, d = spokeDiameter, center = true);
}

module discSpokes(thickness, radius, numSpokes) {
    disc(thickness = thickness, radius = radius);
    
    for (i = [0 : 360 / numSpokes : 360 - 360 / numSpokes]) {
        spoke(angle = i, radius = radius, discThickness = thickness);
    }
}

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

// The cap insert for the neck.
module neckCap() {
    offset = 4;
    
    difference() {
        discSpokes(
                  thickness = capThickness, 
                  radius = capRadius - capThickness,
                  numSpokes = numSpokes); 
        
        translate([0, 0, -offset / 2])
            disc(
                thickness = capThickness + offset,
                radius = insTubeDiameterInterior / 2,
                pRound = 0
                );      
    }   
}

// The assembled neck.
module neck() {

//todo eps
    
    color("LimeGreen")
        translate([0, 0, -insTubeBottomLength]) 
            insTubeBottom();
    
    neckCap();
    
    neckTube();
    
    color("LimeGreen")
        translate([0, 0, tubeLength]) 
            insTubeMpc();
}
neck();

translate([0, 0, 65])
cap();
    

