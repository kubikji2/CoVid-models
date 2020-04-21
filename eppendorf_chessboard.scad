$fn = 90;
eps = 0.01;

// included modules
use<round_corners.scad>;

// plate parameters
p_x = 119;
p_y = 76.5;
p_t = 2;
p_d = 5;
p_c = 5;

g_l = 9;
h_d = 7;

wt = 2;

// hooks parameters
h_l = 15;
h_o = 3;
h_t = 4;
h_so = 15;

module hook()
{
    translate([-h_l/2,-h_t/2,0])
        difference()
        {
            // main shape
            cube([h_l,h_t,h_o+h_t]);
            
            // border cut
            translate([-eps,h_t/2+eps,h_o+h_t-h_t/2+eps])
                cube([h_l+2*eps,h_t/2,h_t/2]);
            
        }
}
    
//hook();

module chess_plate()
{   
    
    // main plate
    difference()
    {
        // main shape
        round_cube(x=p_x,y=p_y,z=p_t,d=p_d);
        //cube([p_x,p_y,p_t]);
        
        for(i=[0:11])
        {
            for(j=[0:7])
            {
                _xo = (p_x-12*g_l)/2 + g_l/2 + g_l*i;
                _yo = (p_y-8*g_l)/2 + g_l/2 + g_l*j;
                if((i+j)% 2 == 0)
                {
                    translate([_xo,_yo,-eps])
                        cylinder(d=h_d,h=p_t+2*eps);
                } else {
                    %translate([_xo,_yo,-eps])
                        cylinder(d=h_d,h=p_t+2*eps);
                }
                
            }
        }
    }   
    
    
    // adding hooks
    // front hooks
    translate([h_so,0,0]) hook();
    translate([p_x-h_so,0,0]) hook();
    // back hooks
    translate([h_so,p_y,0]) rotate([0,0,180]) hook();
    translate([p_x-h_so,p_y,0]) rotate([0,0,180]) hook();
    // left hooks
    translate([0,h_so,0]) rotate([0,0,270]) hook();
    translate([0,p_y-h_so,0]) rotate([0,0,270]) hook();
    // right hooks
    translate([p_x,h_so,0]) rotate([0,0,90]) hook();
    translate([p_x,p_y-h_so,0]) rotate([0,0,90]) hook();
   
    // pin for given point
    difference()
    {
        translate([p_x-p_c/2,p_y-p_c/2,0])
            cylinder(h=h_o+h_t, d=p_c);
        translate([p_x-p_c,p_y,0])
            rotate([0,0,-135])
                cube([2*p_c,2*p_c,2*p_c]);
    }
    
    
    
}

chess_plate();