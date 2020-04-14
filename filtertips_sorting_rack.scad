use<round_corners.scad>;

// general parameters
$fn = 90;
eps = 0.01;
tol = 0.3;
t_tol = 0.3;

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
b_h = 6;
// general parameters
w_t = 2;

// door paramteres
// door support thickness
d_s = 4;

// comb parameters

// hinge paramteres
h_h = 12;
h_d = 2;
h_D = h_d + 4;

module hinge()
{
    rotate([-90,0,0])
    {
        // main
        cube([h_h,h_D,w_t]);
        difference()
        {
            union()
            {
                union()
                {
                    translate([0,0,w_t]) cube([h_h/4,h_D,h_D/2]);
                    translate([0,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                        cylinder(h=h_h/4,d=h_D);
                }
                
                translate([h_h-h_h/4,0,0])
                union()
                {
                    translate([0,0,w_t]) cube([h_h/4,h_D,h_D/2]);
                    translate([0,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                        cylinder(h=h_h/4,d=h_D);
                }
            }
            
            translate([-eps,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                cylinder(h=h_h+2*eps,d=h_d+t_tol);
            
        }
    }
        
}

//hinge();

module hinge_inv(l=1)
{
    //rotate([-90,0,0])
    {
        // main
        //cube([h_h,h_D,w_t]);
        translate([h_h/4+tol,0,0])
        difference()
        {
            union()
            {
                translate([0,h_D/2,w_t+tol/2])
                    cube([h_h/2-2*tol,h_D/2+tol+l,h_D/2]);
                translate([0,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                    cylinder(h=h_h/2-2*tol,d=h_D-tol);
            }
                       
            translate([-eps,h_D/2,h_D/2+w_t]) rotate([0,90,0])
                cylinder(h=h_h/2+2*eps-2*tol,d=h_d+0.5);
            
            
            
        }
    }
}

//hinge_inv();

module ftsr()
{
    x = n_cols*g_l + 2*w_t;
    y = 2*n_rows*g_l + w_t+d_s;
    z = g_t + ft_mh + b_h;
    off = ft_ud;
    
    difference()
    {
        // main shape
        cube([x,y,z]);
        
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
                translate([0,lp_y,0])
                    cylinder(d=ft_sd,h=g_t+2*eps);
                translate([0,y+4*w_t+2*tol,0])
                    cylinder(d=ft_sd,h=g_t+2*eps);
            }
            
            // upper cut
            translate([lp_x,0,g_t]) hull()
            {
                translate([0,lp_y,0])
                    cylinder(d=ft_ud,h=ft_mh+2*eps);
                translate([0,y+4*w_t+2*tol,0])
                    cylinder(d=ft_ud,h=ft_mh+2*eps);
            }
            // cut for border
            translate([lp_x,lp_y,g_t])
                cylinder(h=ft_mh+b_h,d=ft_ud);
        }
    }
    
    // brim cheater
    translate([0,y-2*w_t,0]) cube([x,2*w_t,0.21]);
    
    // legs    
    _t = g_l-ft_sd; 
    
    // front legs
    translate([0,+2*_t,0]) rotate([0,0,-90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }
    translate([x,+2*_t,0]) rotate([0,0,90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }

    // back legs
    _off = ft_ud/2+ft_sd/2+_t/2+tol;
    translate([0,y-_off,0]) rotate([0,0,-90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }
    translate([x,y-_off,0]) rotate([0,0,90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }
    
    // middle legs
    translate([0,y-_off-g_l*(n_rows-2),0]) rotate([0,0,-90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }
    
    translate([x,y-_off-g_l*(n_rows-2),0]) rotate([0,0,90])
    {
        leg_holder(t=_t);
        translate([0,0,-2*_t]) %leg(t=_t);
    }
    
    // hinges
    translate([0,y-w_t,z]) hinge();
    translate([x-h_h,y-w_t,z]) hinge();
    
    // pipet tips
    /*
    for(i=[0:n_rows-1])
    {
        %translate([w_t+g_l/2,y-ft_ud/2-i*g_l,0])
        {
            cylinder(h=10,d=ft_ud);
            translate([0,0,-5]) cylinder(h=10,d=ft_sd);
        }
    }
    */
}

//ftsr();

module door()
{
    _l = 0.5;
    
    x = n_cols*g_l+2*w_t;
    y = h_D/2;
    z = g_t + ft_mh-_l;
    //echo(z);
    
    rotate([-90,0,0]) cube([x,y,z]);
    
    translate([0,-h_D-_l,-h_D+h_d/2-tol/2]) hinge_inv(l=_l);
    translate([x-h_h,-h_D-_l,-h_D+h_d/2-tol/2]) hinge_inv(l=_l);
}

//translate([0,n_cols*g_l+50,35]) door();
door();


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
        _y = (n_cols+i)*g_l+2*w_t+2*(g_l-ft_sd);
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

//comb();

module leg(t)
{
    // single main parameter
    //_t = g_l-ft_sd+t_tol;
    _t = t;
    _h = 1.5*_t;
    
    translate([-_h,-2*_h/3+t_tol,0])
    {
        // lower third
        cube([3*_t,_t,_t]);
        
        // left col
        translate([_t/2,_t/2,_t])
            cylinder(h=_t,d=_t);
        translate([0,0,_t])
            cube([_t/2,_t,_t]);
        // right col
        translate([2.5*_t,_t/2,_t])
            cylinder(h=_t,d=_t);
        translate([2.5*_t,0,_t])
            cube([_t/2,_t,_t]);
        // upper part
        translate([0,0,2*_t]) difference()
        {
            cube([3*_t,_t,2*_t]);
            // left cut
            translate([-eps,-eps,-eps])
                cube([_t/2+eps,_t/2+eps,2*_t+2*eps]);
            // right cut
            translate([2.5*_t+eps,-eps,-eps])
                cube([_t/2+eps,_t/2+eps,2*_t+2*eps]);

        }
    }
}

//leg(g_l-ft_sd+0.5);

module leg_holder(t)
{
    // single main parameter
    //_t = g_l-ft_sd+t_tol;
    _t = t;
    //
    _h = 2*_t;
    _H = 3*_t;
    translate([-_h,-_h/2,0])
    difference()
    {
        // main shape
        hull()
        {
            // left hoder
            cylinder(d=0.01, h = _h);
            translate([_t,0,0]) cylinder(d=0.01, h = _H);
            translate([0,_t+t_tol,0]) cylinder(d=0.01, h = _H);
                
            // right hoder
            translate([3*_t,0,0]) hull()
            {
                cylinder(d=0.01, h = _H);
                translate([_t,0,0]) cylinder(d=0.01, h = _h);
                translate([_t,_t+t_tol,0]) cylinder(d=0.01, h = _H);
            }
        }
        
        // hole
        // back hole part
        translate([_t/2-t_tol,_t/2-t_tol-eps,-eps])
            cube([3*_t+2*t_tol,_t/2+2*t_tol+2*eps,2*_t+t_tol+2*eps]);
        // front hole part
        translate([_t-t_tol,-t_tol,-eps])
            cube([2*_t+2*t_tol, _t/2+t_tol+2*eps,2*_t+t_tol+2*eps]);
        
    }
}

//leg_holder();

//translate([-(g_l-ft_sd+t_tol)/2,0,2*(g_l-ft_sd+t_tol)])
//leg_holder();