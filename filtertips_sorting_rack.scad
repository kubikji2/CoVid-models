use<round_corners.scad>;

// general parameters
$fn = 90;
eps = 0.01;
tol = 0.5;

// filter tips parameters
// stop diameter
ft_sd = 5;
// upper diameter
ft_ud = 7.5;
// height
ft_h = 15;
// maximal height from stopper
ft_mh = 28;

// grid paramaters parameters
n_rows = 8;
n_cols = 12;
// thickness of the grid
g_t = 3;
// distance between centers
g_l = 9;
// horder height
b_h = 3;
// general parameters
w_t = 2;

// door paramteres
// door support thickness
d_s = 4;

// comb parameters


module ftsr()
{
    x = n_cols*g_l + 2*w_t;
    y = 2*n_rows*g_l + w_t+d_s;
    z = g_t + ft_mh + b_h;
    off = ft_ud;
    
    difference()
    {
        // main shape
        union()
        {
            cube([x,y,z]);
            // adding doors
            
            // main door block
            d_x = x;
            d_y = 4*w_t+2*tol;
            d_z = z;
            translate([0,y,0]) difference()
            {
                // main door holder
                cube([d_x,d_y,d_z]);
                // door hole
                translate([w_t,-eps,w_t+eps])
                    cube([d_x-2*w_t,w_t+2*tol+eps,z-w_t]);
            }
        }
        
        // main cut
        translate([x-w_t, w_t, ft_h+g_t+eps])
        hull()
        {
            l_ = x-2*w_t;
            d_ = y-w_t-d_s;
            
            translate([0,off,0])
                rotate([0,-90,0]) cylinder(h=l_,d=0.01);
            translate([0,0,ft_mh-ft_h+b_h+2*eps])
                rotate([0,-90,0]) cylinder(h=l_,d=0.01);
            
            translate([0,d_-off,0])
                rotate([0,-90,0]) cylinder(h=l_,d=0.01);
            translate([0,d_,ft_mh-ft_h+b_h+2*eps])
                rotate([0,-90,0]) cylinder(h=l_,d=0.01);
        }
        
        // cut for tips to fall in
        for(i=[0:n_cols-1])
        {
            // lower part cut
            lp_x = w_t+g_l/2 + i*g_l;
            lp_y = w_t+g_l/2;
            translate([lp_x,0,-eps]) hull()
            {
                translate([0,lp_y,0]) cylinder(d=ft_sd,h=g_t+2*eps);
                translate([0,y+4*w_t+2*tol,0]) cylinder(d=ft_sd,h=g_t+2*eps);
            }
            
            // upper cut
            translate([lp_x,0,g_t]) hull()
            {
                translate([0,lp_y,0])
                    cylinder(d=ft_ud,h=ft_mh+2*eps);
                translate([0,y+4*w_t+2*tol,0])
                    cylinder(d=ft_ud,h=ft_mh+2*eps);
            }
        }
    }
    
    // brim cheater
    translate([0,y+2*w_t+2*tol,0]) cube([x,2*w_t,0.21]);
    
    
}

//ftsr();

module door()
{
    x = n_cols*g_l - 4*tol;
    y = w_t;
    z = ft_mh + b_h;
    
    rotate([-90,0,0]) cube([x,y,z]);
}

//door();


module comb()
{
    
    // comb parameters
    _c_d = 10;
    _x = (n_rows-1)*g_l+_c_d + ft_sd;
    _y = 15;
    _z = g_l-ft_sd;
    
    // middle part
    round_cube(x=_x,y=_y,z=_z, d=_c_d);
    
    // comb teeth
    for(i=[0:n_rows-2])
    {
        // tooth body
        _x_o = ft_sd + _c_d/2 + i*g_l;
        _y_o = _y;
        _x = g_l-ft_sd;
        _y = (n_cols+i)*g_l;
        _z = _x;
        translate([_x_o,_y_o,0]) cube([_x,_y,_z]);
                    
        // enamel
        translate([_x_o,_y_o+_y,0])
        hull()
        {
            cylinder(d=0.01,h=_z);
            translate([_x,0,0]) cylinder(d=0.01,h=_z);
            translate([_x,2*_x,0]) cylinder(d=0.01,h=_z);
        }
            
    }
    
}

comb();
