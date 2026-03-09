bottle_outer_diameter = 94;
stage_outer_diameter = 89;
joint_diameter = 3;
joint_height = 2;
joint_count = 6;
wall_height = 20;
wall_thickness = 2;
joint_clearance = 0.3;
stage_clearance = 2;

$fn = $preview ? 20 : 100;

difference() {
    cylinder(d = bottle_outer_diameter + wall_thickness, h = wall_height);

    translate([0, 0, -1])
    cylinder(d = bottle_outer_diameter, h = wall_height + 2);
}

difference() {
    cylinder(d = bottle_outer_diameter + wall_thickness, h = wall_thickness);

    translate([0, 0, -1])
    cylinder(
        d = stage_outer_diameter - (joint_diameter + stage_clearance) * 2,
        h = wall_height + 2
    );
}

for (i = [0 : joint_count - 1]) {
    rotate([0, 0, i * (360 / joint_count)])
    translate([
        stage_outer_diameter / 2 - (joint_diameter + stage_clearance) / 2,
        0,
        wall_thickness - 1
    ])
    cylinder(d = joint_diameter, h = joint_height + 1);
}
