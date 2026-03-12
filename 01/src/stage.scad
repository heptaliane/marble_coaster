bottle_inner_diameter = 89;
screw_position = 30;
screw_clearance = 1;
screw_diameter = 27;
shaft_diameter = 4.2;
shaft_clearance = 0.2;
shaft_count = 4;
stage_height = 10;
stage_clearance = 2;
joint_clearance = 0.4;
joint_diameter = 3;
joint_height = 1;
joint_count = 6;
wall_thickness = 2;
slope_1_height = 3;
slope_2_height = 1;
slope_3_height = 11;
wall_joint_angle = 80;
wall_joint_thickness = 1;
wall_inner_diameter = 23;

$fn = $preview ? 20 : 100;
joint_position = (bottle_inner_diameter - joint_diameter - stage_clearance) / 2;
shaft_position = bottle_inner_diameter / 2 - stage_clearance - shaft_diameter / 2;
slope_1_position_x = - screw_diameter / 2;
slope_1_position_y = screw_position - screw_diameter / 2;
slope_1_radius = sqrt(slope_1_position_x ^ 2 + slope_1_position_y ^ 2) + bottle_inner_diameter / 2;
slope_2_position_x = -screw_diameter * sqrt(2) * 3 / 8;
slope_2_position_y = screw_position - screw_diameter / 4 / sqrt(2);
slope_2_radius = sqrt((bottle_inner_diameter / 2) ^ 2 - slope_2_position_y ^ 2);

difference() {
    cylinder(d = bottle_inner_diameter, h = stage_height + wall_thickness);

    translate([0, screw_position, wall_thickness])
    cylinder(d = screw_diameter, h = stage_height + 1);

    // Screw position
    translate([0, screw_position, -1])
    cylinder(d = shaft_diameter + shaft_clearance, h = stage_height + wall_thickness + 2);
    translate([
        -screw_diameter / sqrt(8),
        screw_position - screw_diameter / sqrt(8),
        wall_thickness
    ])
    rotate([0, 0, 45])
    cube([screw_diameter / 2, screw_diameter / 2, stage_height + 1]);

    // Slope
    difference() {
        union() {
            translate([slope_1_position_x, slope_1_position_y, wall_thickness + slope_1_height])
            cylinder(
                r1 = 0,
                r2 = slope_1_radius + 1,
                h = stage_height - slope_1_height + 0.1
            );
            translate([slope_2_position_x, slope_2_position_y, wall_thickness + slope_2_height])
            cylinder(
                r1 = 0,
                r2 = slope_2_radius + 1,
                h = stage_height - slope_2_height + 0.1
            );
        }
        translate([-bottle_inner_diameter / 2, screw_position, -1])
        cube([bottle_inner_diameter, bottle_inner_diameter / 2, stage_height + wall_thickness]);
    }
    translate([-bottle_inner_diameter / 2, screw_position - 0.1, wall_thickness + stage_height - 0.9])
    rotate([0, 90, 0])
    linear_extrude(height = bottle_inner_diameter, convexity = 10)
        polygon([
            [0, 0],
            [0, bottle_inner_diameter / 2 - screw_position],
            [wall_thickness + stage_height - slope_3_height, 0]
        ]);

    // Shaft holes
    for (i = [0 : shaft_count - 1]) {
        rotate([0, 0, i * (360 / shaft_count) + (360 / shaft_count) / 2])
        translate([shaft_position, 0, wall_thickness])
            cylinder(d = shaft_diameter, h = stage_height + 1);
    }

    // Joint hole
    for (i = [0 : joint_count - 1]) {
        rotate([0, 0, i * (360 / joint_count)])
        translate([joint_position, 0, -1])
            cylinder(d = joint_diameter, h = wall_thickness + 1);
    }

    // Wall joint hole
    translate([0, screw_position, -1])
    union() {
        rotate([0, 0, 90 - wall_joint_angle / 2])
        rotate_extrude(angle = wall_joint_angle, convexity = 10)
        translate([wall_inner_diameter / 2 + 0.5, 0, 0])
        square([wall_joint_thickness + 0.5, wall_thickness + 2]);

        rotate([0, 0, 270 - wall_joint_angle / 2])
        rotate_extrude(angle = wall_joint_angle, convexity = 10)
        translate([wall_inner_diameter / 2 + 0.5, 0, 0])
        square([wall_joint_thickness + 0.5, wall_thickness + 2]);
    }
}
