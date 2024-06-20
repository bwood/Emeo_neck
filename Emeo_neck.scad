
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

// This cutout houses the flexible ring
module insTubeMpcFlexRing() {
    difference() {
        cylinder(h = insTubeMpcLength - flexRingLengthDiff, 
                 r1 = insTubeMpcDiameterBottom,
                 r2 = insTubeMpcDiameterTop);

        cylinder(h = insTubeMpcLength - flexRingLengthDiff, 
                 r1 = insTubeMpcDiameterBottom - insTubeClearance - flexRingThickness,
                 r2 = insTubeMpcDiameterTop - insTubeClearance - flexRingThickness);
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
        
        translate([0, 0, flexRingLengthDiff / 2])
            insTubeMpcFlexRing();
    }
    
}

module neck() {

    insTubeBottom();
    
    translate([0,0,20]) 
        insTubeMouthpiece();
}
neck();
