$fn = 90;
eps = 0.01;
tol = 0.25;

// test tube parameters
h = 10;
d = 18.5;
w_t = 5;
D = 2*w_t+d;
H = 13;
h_i = 5;
d_i = 2;

// lever parameters
l_h = 8;
l_d = 15;
l_l = 50;
l_t = 2;

// pusher parameters
p_d = 8;
p_D = 10;
p_t = 2;
p_l = 22+H-h_i;

module lab_tube_opener()
{
    difference()
    {
        // main body
        union()
        {
            // main inner part
            cylinder(d=D,h=H);
            
            // leverage
            hull()
            {
                cylinder(d=D,h=h);
                translate([-l_l/2,0,0])
                    cylinder(d=l_d,h=h);
                translate([l_l/2,0,0])
                    cylinder(d=l_d,h=h);
            }
        }
        // test tube hole
        translate([0, 0, H-h_i-eps])
            cylinder(h=h_i+2*eps,d=d);
        
        // main hole for the middle part
        translate([0,0,-eps])
            cylinder(d=p_d+2*tol,h=p_l);
        translate([0,0,-eps])
            cylinder(d=p_D+2*tol,h=p_t+2*eps);
        translate([0,0,p_t-eps])
            cylinder(d2=p_d+2*tol, d1=p_D+2*tol, h=p_D-p_d);
        
        // left hole in lever
        translate([-l_l/2,0,-eps])
        {
            cylinder(d=l_d-4*l_t,h=h+2*eps);
            cylinder(d1=l_d-2*l_t, d2=l_d-4*l_t,h=l_t);
            translate([0,0,h-l_t+2*eps])
                cylinder(d1=l_d-4*l_t, d2=l_d-2*l_t, h=l_t);
        }
        
        // right hole in lever
        translate([l_l/2,0,-eps])
        {
            cylinder(d=l_d-4*l_t,h=h+2*eps);
            cylinder(d1=l_d-2*l_t, d2=l_d-4*l_t,h=l_t);
            translate([0,0,h-l_t+2*eps])
                cylinder(d1=l_d-4*l_t, d2=l_d-2*l_t, h=l_t);
        }
    }
    
    // inner curves
    
    translate([0,0,H-h_i])
    for(i=[1:60])
    {
        rotate([0,0,i*6]) translate([d/2,0,0])
            cylinder(d2=d_i/2,d1=d_i,h=h_i);
    }
    
    
    
    // inner pusher
    cylinder(d=p_d,h=p_l);
    cylinder(d=p_D,h=p_t+2*eps);
    translate([0,0,p_t])
        cylinder(d2=p_d, d1=p_D, h=p_D-p_d);
    
    translate([0,0,p_l-p_t])
        cylinder(d=p_D,h=p_t+2*eps);
    translate([0,0,p_l-p_t-(p_D-p_d)])
        cylinder(d1=p_d, d2=p_D, h=p_D-p_d);
    

    
}

lab_tube_opener();