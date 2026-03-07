knob_diameter = 35;
knob_height = 15;
knob_thickness = 2;
shaft_dia = 4.2;
shaft_offset = 1;
rib_count = 30;

$fn = 60;

difference() {
    union() {
        cylinder(d = knob_diameter, h = knob_height);
        for (i = [0 : rib_count]) {
            rotate([0, 0, i * (360 / rib_count)])
                translate([knob_diameter / 2, 0, 0])
                cylinder(d = 2, h = knob_height, $fn = 12);
        }
    }

    difference() {
        translate([0, 0, knob_thickness])
        cylinder(d = knob_diameter - knob_thickness, h = knob_height - knob_thickness + 1, $fn = 12);
        translate([0, 0, knob_thickness])
        cylinder(d = shaft_dia + knob_thickness, h = knob_height - knob_thickness - shaft_offset, $fn = 12);
    }

    translate([0, 0, 1])
    cylinder(d = shaft_dia, h = knob_height + 1 - knob_thickness);
}
