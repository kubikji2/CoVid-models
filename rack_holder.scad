use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// frame parameters
b_x = 127.9;
b_y = 86;
b_z = 8;

// holder parameters
h_x = 113.5;
h_y = 71.5;
h_h = 3.3;
h_t = 4.5;

// box parameters
d_i = 1;
x_i = 120;
y_i = 83;
// border thickness
b_t = 10;
// border height
b_h = 2.5;

// lock offset
l_off = 12;

module frame()
{
    // main inner frame
    difference()
    {
        // basic shape
        round_cube(x=b_x,y=b_y,z=b_z,d=4);
        
        // tips rack holder hole
        translate([(b_x-x_i)/2,(b_y-y_i)/2,b_h-eps])
            cube([x_i,y_i,b_z-b_h+2*eps]);
        
        // lower hole
        translate([b_t,b_t,-eps])
            round_cube(x=b_x-2*b_t,y=b_y-2*b_t,z=b_h+2*eps,d=2);
    }
    
    translate([(b_x-x_i)/2,15,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,15,0]) cylinder(d=d_i,h=b_z);
    translate([(b_x-x_i)/2,b_y-15,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,b_y-15,0]) cylinder(d=d_i,h=b_z);
    
}

frame();