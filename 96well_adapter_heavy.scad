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
t_wt = 1+0.3;


n_cols = 12;
n_rows = 8;

x_o = 124;
y_o = 81.5;
z = 15;

// upper tips support frame
z_t = 2;

// wall thickness
w_t = 1+tol;


module adapter()
{
    x_off = (x_o-((n_cols-1)*t_l+t_d))/2;
    y_off = (y_o-((n_rows-1)*t_l+t_d))/2;
    
    difference()
    {
        cube([x_o,y_o,z]);               
        //translate([w_t,w_t,z_t+eps])
        //    cube([x_o-2*w_t, y_o-2*w_t, z]);
        
        for(i = [0:n_cols-1])
        {
            for(j = [0:n_rows-1])
            {
                xt = x_off+t_d/2+i*t_l;
                yt = y_off+t_d/2+j*t_l;
                h = z+2*eps;
                d = t_d + 2*eps;
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
                d = t_l-t_wt;
                h = z + t_hh;
                translate([xt,yt,-eps])
                difference()
                {
                    cylinder(d=d,h=h);
                    translate([0,0,-eps]) cylinder(d=t_d,h=h+2*eps);
                }
            }
        }

}

adapter();

