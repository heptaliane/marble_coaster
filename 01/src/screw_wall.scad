ball_diameter = 9.5;
inner_diameter = 23;
wall_thickness = 2;
wall_height = 30;
joint_height = 3;
joint_clearance = 2;
joint_angle = 80;
joint_angle_clearance = 10;

outer_diameter = inner_diameter + wall_thickness * 2;

$fn = 60;

difference() {
    cylinder(d = outer_diameter, h = wall_height);

    translate([0, 0, -1])
    cylinder(d = inner_diameter, h = wall_height + 2);

    translate([0, 0, -1])
    cube([outer_diameter, outer_diameter, wall_height + 2]);

    translate([0, 0, -1])
    rotate([0, 0, 135 - joint_angle / 2])
    rotate_extrude(angle = joint_angle, convexity = 10)
    translate([inner_diameter / 2 - 1, 0, 0])
    square([wall_thickness / 2 + 1, joint_height + joint_clearance]);

    translate([0, 0, -1])
    rotate([0, 0, 315 - joint_angle / 2])
    rotate_extrude(angle = joint_angle, convexity = 10)
    translate([inner_diameter / 2 - 1, 0, 0])
    square([wall_thickness / 2 + 1, joint_height + joint_clearance]);
}

translate([0, 0, wall_height])
union() {
    male_angle = joint_angle - joint_angle_clearance;

    rotate([0, 0, 135 - male_angle / 2])
    rotate_extrude(angle = male_angle, convexity = 10)
    translate([inner_diameter / 2, 0, 0])
    square([wall_thickness / 2, joint_height]);

    rotate([0, 0, 315 - male_angle / 2])
    rotate_extrude(angle = male_angle, convexity = 10)
    translate([inner_diameter / 2, 0, 0])
    square([wall_thickness / 2, joint_height]);
}

// Ball guide
translate([0, inner_diameter / 2, 0])
    cube([inner_diameter / 2, wall_thickness, wall_height]);
