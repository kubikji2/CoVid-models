// general parameters
$fn = 90;
eps = 0.01;
tol = 0.1;

// filter tips parameters
// stop diameter
ft_sd = 5;
// lower diameter
ft_ld = 6;
// upper diameter
ft_ud = 7.5;
// height
ft_h = 15;

// grid paramaters parameters
n_rows = 8;
n_cols = 12;
// thickness of the grid
g_t = 1;
// distance between centers
g_l = 9;
// horder height
b_h = 10;
// general parameters
w_t = 2;

module ftsr()
{
    x = n_cols*g_l + 2*w_t;
    y = 2*n_rows*g_l + 2*w_t;
    z = g_t + ft_h + b_h;
    
    difference()
    {
        // main shape
        cube([x,y,z]);
        
        // main cut
        translate([w_t, w_t, ft_h+g_t+eps])
            cube([x-2*w_t,y-2*w_t,b_h+2*eps]);
        // cut for tips to fall in
        for(i=[0:n_cols-1])
        {
            // lower part cut
            lp_x = w_t+g_l/2 + i*g_l;
            lp_y = w_t+g_l/2;
            translate([lp_x,0,-eps]) hull()
            {
                translate([0,lp_y,0]) cylinder(d=ft_sd,h=g_t+2*eps);
                translate([0,y-lp_y,0]) cylinder(d=ft_sd,h=g_t+2*eps);
            }
            
            // upper cut
            translate([lp_x,0,g_t]) hull()
            {
                translate([0,lp_y,0])
                    cylinder(d1=ft_ld,d2=ft_ud,h=ft_h+2*eps);
                translate([0,y-lp_y,0])
                    cylinder(d1=ft_ld,d2=ft_ud,h=ft_h+2*eps);
            }
        }
    }
}

ftsr();


