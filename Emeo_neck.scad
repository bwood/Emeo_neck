include <./Emeo_neck_library.scad>

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

module insTubeMouthpiece() {

    difference() {
        difference() {
            // Outer cylinder surface.
            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeMpcDiameterBottom - insTubeClearance,
                     r2 = insTubeMpcDiameterTop - insTubeClearance);
  
          // Inner cylinder surface
            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeDiameterInterior,
                     r2 = insTubeDiameterInterior);
           
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
        insTubeMouthpiece();
}
neck();
