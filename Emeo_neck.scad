include <./Emeo_neck_library.scad>

// Create the conical tube that inserts into the Emeo receptical at the top of the instrument.
module insTubeBottom () {
    
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

module neck() {

    insTubeBottom();
    
    translate([0,0,20]) 
        insTubeMpc();
}
neck();
