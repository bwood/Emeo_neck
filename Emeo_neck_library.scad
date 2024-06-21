
// CHANGE to 100 when you create the STL.
$fn = 20;

// Epsilon. This small value guarantees overlap and solves the warning: "Object may not be a valid 2-manifold and may need repair!"
eps = 0.01;

// Cap varialbes.
capThickness = 3;

// Insertion tube for Emeo recpetical,
insTubeDiameterTop = 15.4;
insTubeDiameterBottom = 14.72;

insTubeMouthpieceDiameterTop = 15;
insTubeDiameterInterior = 4;

// The depth of the Emeo receptical hole is 14.7. The insTube will go in this far:
insTubeBottomLength = 10;


// Insertion tube for the mouthpiece that came with the Emeo.
insTubeMpcLength = 20;
insTubeMpcDiameterBottom = 16.4;
insTubeMpcDiameterTop = 15.75;

// The insTubes should clear the recpeticals by this much.
// Contact will be made by the flexible rings.
insTubeClearance = 1;

// This is the length of the tube between the cap and the insTubeMpc.
TubeLength = 40;

// Flexble (NinjaFlex) ring
// TODO: outter edges should be less than actual diameter. Flex material should be at actual diameter.
flexRingLengthDiff = 4;
flexRingThickness = 2;


// Total insTube length
//insTubeLength = insTubeBottomLength + capThickness + insTubeTopLength;

// This cutout houses the flexible ring
module insTubeMpcFlexRing(length, diameterBottom, diameterTop) {
    difference() {
        cylinder(h = length - flexRingLengthDiff,
                 r1 = diameterBottom,
                 r2 = diameterTop);

        cylinder(h = length - flexRingLengthDiff,
                 r1 = diameterBottom - insTubeClearance - flexRingThickness,
                 r2 = diameterTop - insTubeClearance - flexRingThickness);
    }

}
