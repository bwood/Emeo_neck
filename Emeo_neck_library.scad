
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
// Difference in length between the insTube and the flex ring.  The ring sits inside the lips this creates in the insTube.
flexRingLengthDiff = 4;
// Reduce the interior diameter of the flex ring by this much to ensure a snug fit. This will also thicken the flex ring somewhat. Careful...
//TODO: Why loose lips when this is 0?
flexRingTightness = 1;


// Total insTube length
//insTubeLength = insTubeBottomLength + capThickness + insTubeTopLength;

// Flexible ring. 
module insTubeMpcFlexRing(length, diameterBottom, diameterTop) {
    difference() {
        // Outer surface.
        cylinder(h = length - flexRingLengthDiff,
                 r1 = diameterBottom,
                 r2 = diameterTop);
        //Inner surface.
        // TODO: should flexRingThickness be subtracted? w/out this we are at surface of insTube
        cylinder(h = length - flexRingLengthDiff,
                 r1 = diameterBottom - insTubeClearance - flexRingTightness,
                 r2 = diameterTop - insTubeClearance - flexRingTightness);
    }

}
