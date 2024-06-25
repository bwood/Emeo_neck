include <./Emeo_neck_library.scad>

// Mouthpiece flex ring.
mpcX = insTubeMpcDiameterBottom * 1.5;
translate([mpcX, 0, 0])
    flexRing(
                                    length = insTubeMpcLength,
                                    diameterBottom = insTubeMpcDiameterBottom,
                                    diameterTop = insTubeMpcDiameterTop,
                                    flexRingOuterClearance = 0,
                                    flexRingTightness = flexRingTightness
                                   );
 
 // Bottom flex ring
 botX = insTubeDiameterBottom * 1.5;
 translate([-botX, 0, 0])
     flexRing(
                                    length = insTubeBottomLength,
                                    diameterBottom = insTubeDiameterBottom,
                                    diameterTop = insTubeDiameterTop,
                                    flexRingOuterClearance = 0,
                                    flexRingTightness = flexRingTightness
                                   );
