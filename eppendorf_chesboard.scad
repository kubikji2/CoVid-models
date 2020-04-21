$fn = 90;
eps = 0.01;

// plate parameters
p_x = 119;
p_y = 76.5;
p_t = 1;

g_l = 9;
p_d = 7;

wt = 2;

module chess_plate()
{   
    // main plate
    difference()
    {
        // main shape
        cube([p_x,p_y,p_t]);
        
        for(i=[0:11])
        {
            for(j=[0:7])
            {
                _xo = (p_x-12*g_l)/2 + g_l/2 + g_l*i;
                _yo = (p_y-8*g_l)/2 + g_l/2 + g_l*j;
                if((i+j)% 2 == 0)
                {
                    translate([_xo,_yo,-eps])
                        cylinder(d=p_d,h=p_t+2*eps);
                } else {
                    %translate([_xo,_yo,-eps])
                        cylinder(d=p_d,h=p_t+2*eps);
                }
                
            }
        }
    }   
    
    // adding hooks
    
    
}

chess_plate();