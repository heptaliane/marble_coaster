ball_diameter = 9.5;
shaft_diameter = 6;
joint_diameter = 4.2;
clearance = 1;
ball_padding = 0.5;
wing_length = ball_diameter - clearance - ball_padding;
outer_diameter = shaft_diameter + wing_length * 2;
screw_height = 30;
screw_pitch = 18;

$fn = 60;

difference() {
    union() {
        cylinder(d = shaft_diameter, h = screw_height);
        linear_extrude(height = screw_height, twist = -360 * (screw_height / screw_pitch), convexity = 10)
            translate([shaft_diameter / 2 - 1, -1.5, 0])
            square([wing_length + 1, 3]);
    }

    translate([0, 0, -1])
    cylinder(d = joint_diameter, h = screw_height + 2);
}
