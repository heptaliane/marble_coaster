bottle_outer_diameter = 96;
container_outer_diameter = 98;
wall_thickness = 2;
joint_height = 2;
handler_height = 30;
knob_diameter = 20;
shaft_diameter = 4.4;
shaft_joint_position_1 = 0;
shaft_joint_position_2 = 42;
clearance = 0.4;
knob_clearance = 1;

$fn = $preview ? 20 : 100;

joint_thickness = wall_thickness / 2;
outer_diameter = container_outer_diameter + joint_thickness * 2;
inner_diameter = container_outer_diameter - joint_thickness * 2;
shaft_joint_width = shaft_diameter + wall_thickness * 2;
shaft_joint_height = (handler_height - joint_height) / 2 + wall_thickness + shaft_diameter / 2;

difference() {
    cylinder(d = outer_diameter, h = handler_height);

    translate([0, 0, handler_height - joint_height - 1])
    cylinder(d = container_outer_diameter + clearance, h = joint_height + 2);

    translate([0, 0, -1])
    cylinder(d = inner_diameter, h = handler_height - joint_height + 1);

    translate([0, 0, (handler_height - joint_height) / 2])
    rotate([-90, 0, 0])
    cylinder(d = knob_diameter + knob_clearance, h = inner_diameter);

}

intersection() {
    cylinder(d = outer_diameter, h = wall_thickness);

    cube([shaft_joint_width, outer_diameter, wall_thickness * 2], center=true);
}

difference() {
    union() {
        translate([-shaft_joint_width / 2, shaft_joint_position_1 + wall_thickness / 2, 0])
        cube([shaft_joint_width, wall_thickness, shaft_joint_height]);

        translate([-shaft_joint_width / 2, shaft_joint_position_2 + wall_thickness / 2, 0])
        cube([shaft_joint_width, wall_thickness, shaft_joint_height]);
    }

    translate([0, 0, (handler_height - joint_height) / 2])
    rotate([-90, 0, 0])
    cylinder(d = shaft_diameter, h = inner_diameter / 2);
}

difference() {
    cylinder(d = outer_diameter, h = wall_thickness);

    translate([0, 0, -1])
    cylinder(d = inner_diameter - wall_thickness * 2, h = wall_thickness + 2);
}
