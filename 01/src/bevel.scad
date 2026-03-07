tooth_height = 3;
tooth_count = 16;
tooth_angle = 20;
face_width = 8;
shaft_diameter = 4.2;
gear_diameter = 30;
gear_depth = 12;

upper_diameter = gear_diameter;
lower_diameter = gear_diameter - gear_depth;

$fn = 60;

module bavel_tooth() {
    base_width = PI * upper_diameter / tooth_count * 0.6;
    top_width = PI * upper_diameter / tooth_count * 0.3;
    diameter_ratio = lower_diameter / upper_diameter;

    translate([0, 0, 0])
    linear_extrude(height = face_width, scale = diameter_ratio, convexity = 10)
    translate([upper_diameter / 2, 0, 0])
    polygon(points = [
        [0, -base_width / 2],
        [tooth_height, -top_width / 2],
        [tooth_height, top_width / 2],
        [0, base_width / 2],
    ]);
}

difference() {
    intersection() {
        union() {
            cylinder(d1 = upper_diameter, d2 = lower_diameter, h = face_width);

            for (i = [0 : tooth_count - 1]) {
                rotate([0, 0, i * (360 / tooth_count)])
                    bavel_tooth();
            }
        }

        cylinder(d1 = upper_diameter + tooth_height * 2, d2 = lower_diameter + tooth_height * 2, h = face_width);
    }

    translate([0, 0, -1])
        cylinder(d = shaft_diameter, h = face_width + 2);
}
