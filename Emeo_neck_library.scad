
// CHANGE to 100 when you create the STL.
$fn = 20;

// If true, echo debug info to console.
debug = true;

// Epsilon. This small value guarantees overlap and solves the warning: "Object may not be a valid 2-manifold and may need repair!"
eps = 0.01;

// Cap varialbes.
capThickness = 3;

// Insertion tube for Emeo recpetical,
insTubeDiameterTop = 15.4;
insTubeDiameterBottom = 14.72;

insTubeMouthpieceDiameterTop = 15;
insTubeDiameterInterior = 4;

// The depth of the Emeo receptical hole is 14.7 mm deep. 
// The insTube will insert to the depth specified by this variable and will be flush with the top of the recepticle.
insTubeBottomLength = 10;


// Insertion tube for the mouthpiece that came with the Emeo.
insTubeMpcLength = 20;
insTubeMpcDiameterBottom = 16.4;
insTubeMpcDiameterTop = 15.75;

// The insTubes should clear the recpeticals by this much.
// Contact will be made by the flexible rings.
insTubeClearance = 1;

// This is the length of the tube between the insTubeBottom and the insTubeMpc.
tubeLength = 40;

// Flexble (NinjaFlex) ring
// Difference in length between the insTube and the flex ring.  The ring sits inside the lips this creates in the insTube.
flexRingLengthDiff = 4;
// The depth of the flex ring cutouts in the insertion tubes.
flexRingDiameterDiff = 2;
// Reduce the interior diameter of the flex ring by this much to ensure a snug fit. This will also thicken the flex ring somewhat. Careful...
flexRingTightness = 0;


// Total insTube length
//insTubeLength = insTubeBottomLength + capThickness + insTubeTopLength;

// Flexible ring. 
module flexRing(
                length, 
                diameterBottom, 
                diameterTop, 
                flexRingOuterClearance = 0, 
                flexRingTightness = 0
                ) {
    
    frLength = length - flexRingLengthDiff;
    // flexRingOuterClearance is needed for the cutouts in the insTubes when the outer diameter isn't great enough to delete part of the insTube.
    r1Outer = diameterBottom + flexRingOuterClearance;
    r2Outer = diameterTop + flexRingOuterClearance;
    r1Inner = diameterBottom - insTubeClearance - flexRingDiameterDiff - flexRingTightness;
    r2Inner = diameterTop - insTubeClearance - flexRingDiameterDiff - flexRingTightness;
    
    if (debug) {
        echo("");
        echo("Function: flexRing");
        echo("frLength = ", frLength);
        echo("insTubeClearance = ", insTubeClearance);
        echo("flexRingDiameterDiff = ", flexRingDiameterDiff);
        echo("flexRingOuterClearance = ", flexRingOuterClearance);
        echo("flexRingTightness = ", flexRingTightness);
        echo("r1Outer = ", r1Outer);
        echo("r2Outer =", r2Outer);
        echo("r1Inner = ", r1Inner);
        echo("r2Inner = ", r2Inner);
    }
    
    difference() {
        // Outer surface.
        cylinder(h = frLength,
                 r1 = r1Outer,
                 r2 = r2Outer);
        //Inner surface.
        // TODO: should flexRingThickness be subtracted? w/out this we are at surface of insTube
        cylinder(h = frLength,
                 r1 = r1Inner,
                 r2 = r2Inner);
    }

}
