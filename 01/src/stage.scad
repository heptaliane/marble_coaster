bottle_inner_diameter = 90;
bottle_outer_diameter = 93;
shaft_diameter = 4.2;
screw_diameter = 27;
bottle_clearance = 1;
shaft_clearance = 0.2;
screw_clearance = 0.5;
screw_position = 30;
screw_wall_diameter = 23;
container_height = 20;
stage_height = 10;
wall_thickness = 2;
wall_joint_angle = 80;
shaft_offset = bottle_inner_diameter / sqrt(8) * 0.8;

$fn = $preview ? 20 : 60;
sphere_fn = $preview ? 60 : 600;

cutoff_position = screw_position - screw_diameter / 2;
x_dist = bottle_inner_diameter / 2 + cutoff_position;
y_dist = stage_height - wall_thickness;
cutoff_z = (x_dist ^ 2 + y_dist ^ 2) / 2 / (stage_height - wall_thickness);
screw_radius = screw_diameter / 2;
cutoff_dist = screw_position + bottle_inner_diameter / 4;
cutoff_radius = sqrt(cutoff_dist ^ 2 - sqrt(2) * screw_radius * cutoff_dist + screw_radius ^ 2);

difference() {
    union() {
        difference() {
            cylinder(
                d = bottle_outer_diameter + bottle_clearance + wall_thickness,
                h = container_height
            );

            translate([0, 0, wall_thickness])
            cylinder(d = bottle_outer_diameter + bottle_clearance, h = container_height);
        }

        difference() {
            cylinder(d = bottle_inner_diameter, h = stage_height);

            translate([screw_position, 0, wall_thickness])
                cylinder(d = screw_diameter, h = stage_height);

            intersection() {
                translate([-bottle_inner_diameter / 4, 0, 0])
                cylinder(r = cutoff_radius, h = stage_height + 1);

                translate([cutoff_position, 0, cutoff_z + wall_thickness])
                    sphere(cutoff_z, $fn = sphere_fn);
            }

            translate([
                -bottle_inner_diameter / 2,
                bottle_inner_diameter / 2,
                stage_height / 2 + 0.1
            ])
            rotate([90, 0, 0])
            linear_extrude(height = bottle_inner_diameter + 2, convexity = 10)
            polygon(points = [
                [0, stage_height / 2],
                [0, 0],
                [bottle_inner_diameter, stage_height / 2]
            ]);
        }
    }

    // For shaft joint
    translate([screw_position, 0, -1])
        cylinder(d = shaft_diameter + shaft_clearance, h = stage_height + 2);
    translate([shaft_offset, shaft_offset, -1])
        cylinder(d = shaft_diameter, h = stage_height + 2);
    translate([-shaft_offset, shaft_offset, -1])
        cylinder(d = shaft_diameter, h = stage_height + 2);
    translate([shaft_offset, -shaft_offset, -1])
        cylinder(d = shaft_diameter, h = stage_height + 2);
    translate([-shaft_offset, -shaft_offset, -1])
        cylinder(d = shaft_diameter, h = stage_height + 2);

    // Screw wall joint
    translate([screw_position, 0, -1])
    rotate([0, 0, 90 - wall_joint_angle / 2])
    rotate_extrude(angle = wall_joint_angle, convexity = 10)
    translate([screw_wall_diameter / 2 - 1, 0, 0])
    square([wall_thickness / 2 + 0.3, stage_height + 2]);
    //square([wall_thickness / 2, stage_height + 2]);

    translate([screw_position, 0, -1])
    rotate([0, 0, 270 - wall_joint_angle / 2])
    rotate_extrude(angle = wall_joint_angle, convexity = 10)
    translate([screw_wall_diameter / 2 - 1, 0, 0])
    square([wall_thickness / 2 + 0.3, stage_height + 2]);
}
