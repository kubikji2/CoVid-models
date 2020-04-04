eps = 0.01;
$fn = 90;
tol = 0.5;
ttol = 0.3;


// basic 96 well parameters
// source: TODO
// filter tips parameters
t_d = 5.46 + tol;
t_l = 9.00;
// depth of the secure part for each hook
t_hh = 5;


n_cols = 12;
n_rows = 8;

x_o = 124;
y_o = 81.5;
z = 15;

// upper tips support frame
z_t = 2;

// wall thickness
w_t = 3;

module adapter()
{
    x_off = (x_o-((n_cols-1)*t_l+t_d))/2;
    y_off = (y_o-((n_rows-1)*t_l+t_d))/2;
    
    difference()
    {
        cube([x_o,y_o,z]);               
        translate([w_t,w_t,z_t+eps])
            cube([x_o-2*w_t, y_o-2*w_t, z]);
        
        for(i = [0:n_cols-1])
        {
            for(j = [0:n_rows-1])
            {
                xt = x_off+t_d/2+i*t_l;
                yt = y_off+t_d/2+j*t_l;
                h = z+2*eps;
                d = t_d;
                translate([xt,yt,-eps]) cylinder(h=h, d=d);
                
            }
        }
        
    }
    
    
    for(i = [0:n_cols-1])
    {
        for(j = [0:n_rows-1])
        {
            xt = x_off+t_d/2+i*t_l;
            yt = y_off+t_d/2+j*t_l;
            if ((i == 0 && (j == 0 || j == n_rows-1)) ||
                (i == n_cols-1 && (j == 0 || j == n_rows-1)))
                {
                    translate([xt,yt,-eps])
                        difference()
                        {
                            union()
                            {
                                cylinder(d=t_l-tol-1,h=z+t_hh);
                                cylinder(d=t_l,h=z);
                            }
                            translate([0,0,-eps])
                                cylinder(d=t_d,h=z+t_hh+2*eps);
                        }
                }
            // mk 2 upadete
            if (j == 0 && i % 3 == 2 && i != n_cols-1)
            {
                t = t_l-t_d-tol;
                translate([xt+t_d/2+tol/2,0,0]) cube([t,y_o,z]);
            }
            // mk 2 update
            if(i == 0 && j % 4 == 3 && j != n_rows-1)
            {
                t = t_l-t_d-tol;
                translate([0,yt+t_d/2+tol/2,0]) cube([x_o,t,z]);
            }
        }
    }
    
    

}

adapter();

