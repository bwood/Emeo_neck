include <./Emeo_neck_library.scad>

module insTubeBottom () {
        
    difference() {
        cylinder(h = insTubeBottomLength, 
                 r1 = insTubeDiameterBottom,
                 r2 = insTubeDiameterTop);

        cylinder(h = insTubeBottomLength, 
                 r1 = insTubeDiameterInterior,
                 r2 = insTubeDiameterInterior);
  
    }

}

module insTubeMouthpiece() {

    difference() {
        difference() {
            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeMpcDiameterBottom - insTubeClearance,
                     r2 = insTubeMpcDiameterTop - insTubeClearance);

            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeDiameterInterior,
                     r2 = insTubeDiameterInterior);
           
        }
        
        // Cutout for the flex ring.
        translate([0, 0, flexRingLengthDiff / 2])
            insTubeMpcFlexRing(
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
