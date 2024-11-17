include <./Emeo_neck_library.scad>

// The assembled standard neck.
module neck_straight() {

    tubeLength = tubeLength + 6 ;

    color("LimeGreen")
        translate([0, 0, -insTubeBottomLength])
            insTubeBottom();

    neckDisc();

    translate([0, 0, -eps])
        neckTube(length = tubeLength);

    color("LimeGreen")
        translate([0, 0, tubeLength - (eps * 2)])
            insTubeMpc();
}

neck_straight();
