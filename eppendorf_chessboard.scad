$fn = 90;
eps = 0.01;

// included modules
use<round_corners.scad>;

// plate parameters
p_x = 119;
p_y = 76.5;
p_t = 1;
p_d = 5;

g_l = 9;
h_d = 7;

wt = 2;

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
       
    
    
}

chess_plate();