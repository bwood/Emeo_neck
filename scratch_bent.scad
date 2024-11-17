// Parameters
tube_diameter_outer = 10; // Outer diameter of the tube
tube_diameter_inner = 8;  // Inner diameter of the tube
wall_thickness = (tube_diameter_outer - tube_diameter_inner) / 2;
straight_section1_length = 5;
straight_section2_length = 10;
curve_angle = 70; // in degrees
curve_radius = 15; // radius of the curve

// Convert degrees to radians
angle_radians = curve_angle * PI / 180;

// Module to create a straight tube section
module straight_tube(length) {
    difference() {
        cylinder(h = length, d = tube_diameter_outer, $fn=100);
        translate([0, 0, -eps])
            cylinder(h = length + 2*eps, d = tube_diameter_inner, $fn=100);
    }
}

// Module to create a curved tube section
module curved_tube(radius, angle) {
    difference() {
        rotate_extrude(angle = angle, convexity = 10)
            translate([radius, 0])
                circle(d = tube_diameter_outer, $fn=100);
        
        translate([0, 0, -eps])
            rotate_extrude(angle = angle, convexity = 10)
                translate([radius, 0])
                    circle(d = tube_diameter_inner, $fn=100);
    }
}

// Combine the sections to form the complete tube
module connected_tube() {
    union() {
        // First straight section
        translate([0, 0, 0])
            straight_tube(straight_section1_length);
        
        // Curved section
        translate([0, curve_radius, straight_section1_length])
            rotate([90, 0, -90])
                curved_tube(curve_radius, curve_angle);
        
        // Calculate the position of the end of the curved section
        end_x = curve_radius * sin(angle_radians);
        end_y = curve_radius * (1 - cos(angle_radians));
        end_z = straight_section1_length + curve_radius * sin(angle_radians);
        
        echo("end_x", end_x);
        echo("end_y", end_y);
        echo("end_z", end_z);

        // Second straight section
        translate([end_x, end_y, end_z])
            rotate([0, 90 - curve_angle, 0])
                straight_tube(straight_section2_length);
    }
}

// Adjust for small overlaps to ensure proper connection
eps = 0.01;

// Render the connected tube
connected_tube();