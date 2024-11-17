// https://github.com/Irev-Dev/Round-Anything
use <../Round-Anything/polyround.scad>

// CHANGE to 100 when you create the STL.
$fn = 100;
// RoundAnything library
// https://github.com/Irev-Dev/Round-Anything
fnPolyRound = 20;


// If true, echo debug info to console.
debug = false;

// Epsilon. This small value guarantees overlap and solves the warning: "Object may not be a valid 2-manifold and may need repair!"
eps = 0.01;

// Cap varialbes.
capDiameter = 29;
capRadius = capDiameter / 2;
capThickness = 3;
capHeight1 = 12.73;
// Add height to extend below the minuet holder.
capHeight = capHeight1 + 4;
capDiameterBottom = 26.8;
capRadiusBottom = capDiameterBottom / 2;

// Spoke variables.
spokeDiameter = 2;
numSpokes = 25;

// Insertion tube for Emeo recpetical,
insTubeDiameterTop = 15.4;
insTubeRadiusTop = insTubeDiameterTop / 2;
insTubeDiameterBottom = 14.4;

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

// Tube variables.
tubeLength = (capThickness * 2);

// Tube bend variables.
// xpoint determines the length of the arc of the bent part.
cbXpoint = 10;
cbAngle = 70;


// Flexble (NinjaFlex) ring
// Difference in length between the insTube and the flex ring.  The ring sits inside the lips this creates in the insTube.
flexRingLengthDiff = 4;
// The depth of the flex ring cutouts in the insertion tubes.
flexRingDiameterDiff = 2;
// Reduce the interior diameter of the flex ring by this much to ensure a snug fit. This will also thicken the flex ring somewhat. Careful...
flexRingTightness = 0;


// Total insTube length
//insTubeLength = insTubeBottomLength + capThickness + insTubeTopLength;

// The neck tube that connects the two insTubes.
module neckTube(length=capThickness * 2) {
    dOuter = insTubeDiameterTop;
    dInner = insTubeDiameterInterior;

    difference() {
        cylinder(h = length,
                 d1 = dOuter,
                 d2 = insTubeMpcDiameterBottom - insTubeClearance);

        cylinder(h = length,
                 d = dInner);
    }
}

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
    d1Outer = diameterBottom + flexRingOuterClearance;
    d2Outer = diameterTop + flexRingOuterClearance;
    d1Inner = diameterBottom - insTubeClearance - flexRingDiameterDiff - flexRingTightness;
    d2Inner = diameterTop - insTubeClearance - flexRingDiameterDiff - flexRingTightness;
    
    if (debug) {
        echo("");
        echo("Function: flexRing");
        echo("frLength = ", frLength);
        echo("insTubeClearance = ", insTubeClearance);
        echo("flexRingDiameterDiff = ", flexRingDiameterDiff);
        echo("flexRingOuterClearance = ", flexRingOuterClearance);
        echo("flexRingTightness = ", flexRingTightness);
        echo("d1Outer = ", d1Outer);
        echo("d2Outer =", d2Outer);
        echo("d1Inner = ", d1Inner);
        echo("d2Inner = ", d2Inner);
    }
    
    difference() {
        // Outer surface.
        cylinder(h = frLength,
                 d1 = d1Outer,
                 d2 = d2Outer);
        //Inner surface.
        // TODO: should flexRingThickness be subtracted? w/out this we are at surface of insTube
        cylinder(h = frLength,
                 d1 = d1Inner,
                 d2 = d2Inner);
    }

}

// Disc object.  Top of cap and neck disc.
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

// The cap insert for the neck.
module neckDisc() {
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
