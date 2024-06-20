
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

// This is the depth of the Emeo receptical hole.
insTubeBottomLength = 10;


// Insertion tube for the mouthpiece that came with the Emeo.
insTubeMpcLength = 20;
insTubeMpcDiameterBottom = 16.4;
insTubeMpcDiameterTop = 15.75;

// This is the length of the tube between the cap and the insTubeMpc.
TubeLength = 40;

// Flexble (NinjaFlex) ring
// TODO: outter edges should be less than actual diameter. Flex material should be at actual diameter.
flexRingLengthDiff = 4;
flexRingThickness = 1;


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
module insTubeMpcCutout() {
    difference() {
        cylinder(h = insTubeMpcLength - flexRingLengthDiff, 
                 r1 = insTubeMpcDiameterBottom + 5,
                 r2 = insTubeMpcDiameterTop + 5);

        cylinder(h = insTubeMpcLength - flexRingLengthDiff, 
                 r1 = insTubeMpcDiameterBottom - flexRingThickness,
                 r2 = insTubeMpcDiameterTop - flexRingThickness);
    }
    
}

module insTubeMouthpiece() {

    difference() {
        difference() {
            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeMpcDiameterBottom,
                     r2 = insTubeMpcDiameterTop);

            cylinder(h = insTubeMpcLength, 
                     r1 = insTubeDiameterInterior,
                     r2 = insTubeDiameterInterior);
           
        }
        
        translate([0, 0, flexRingLengthDiff / 2])
            insTubeMpcCutout();
    }
    
}

module neck() {

    insTubeBottom();
    
    translate([0,0,20]) 
        insTubeMouthpiece();
}
//neck();
insTubeMouthpiece();