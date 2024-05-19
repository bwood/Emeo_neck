
// CHANGE to 100 when you create the STL.
$fn = 20;

// Epsilon. This small value guarantees overlap and solves the warning: "Object may not be a valid 2-manifold and may need repair!"
eps = 0.01;

// Cap varialbes.
capThickness = 3;

// Tube variables.
tubeDiameter = 15.4;
tubeBottomDiameterDifference = 1;
tubeTopDiameterDifference = 1;

tubeMouthpieceDiameterTop = 15;
tubeMouthpieceDiameterDifference = 1;

tubeThickness = 2;

// This is the depth of the Emeo receptical hole.
tubeBottomLength = 14.5;
// This is the part of the tube to be inserted in the mouthpiece.
tubeMouthpieceLength = 25;
// This is the length of the tube extending above the cap.
tubeTopLength = 40;
// Total tube length
tubeLength = tubeBottomLength + capThickness + tubeTopLength;

module tubeBottom () {
        
    difference() {
        cylinder(h = tubeBottomLength, 
                 r1 = tubeDiameter - tubeBottomDiameterDifference,
                 r2 = tubeDiameter);

        cylinder(h = tubeBottomLength, 
                 r1 = tubeDiameter - tubeThickness - tubeBottomDiameterDifference,
                 r2 = tubeDiameter - tubeThickness);
    }

}

module tubeMouthpiece() {

    difference() {
        cylinder(h = tubeMouthpieceLength, 
                 r1 = tubeMouthpieceDiameterTop + tubeMouthpieceDiameterDifference,
                 r2 = tubeMouthpieceDiameterTop);

        cylinder(h = tubeMouthpieceLength, 
                 r1 = tubeDiameter - tubeThickness,
                 r2 = tubeDiameter - tubeThickness);
    }
    
}

module tube() {

    tubeBottom();
    
    translate([0,0,20]) 
        tubeMouthpiece();
}
tube();