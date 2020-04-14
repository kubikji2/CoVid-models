use<round_corners.scad>;
eps = 0.01;
$fn = 90;
tol = 0.5;
ttol = 0.3;

// basic 96 well parameters
// source: TODO
// filter tips parameters
//t_d = 5.46 + tol;
t_d = 5.3;
t_l = 9.00;
// depth of the secure part for each hook
t_hh = 4;
t_wt = 0.6;


n_cols = 12;
n_rows = 8;

// eppendorf parameters
/*
x_o = 124;
y_o = 81.5;
z = 2;
*/

// upper tips support frame
z_t = 2;

// cliff parameters
c_t = 0.75;
c_h = 3.5;

// upper part params
// wall thickness
u_wt = 2;

u_x = 112;
u_y = 77;
u_z = 10;
u_d = 13;


module hook(l=20)
{
    hull()
    {
        rotate([0,90,0]) cylinder(d=eps,h=l);
        translate([0,0,c_h]) rotate([0,90,0]) cylinder(d=eps,h=l);
        translate([0,-c_t,0]) rotate([0,90,0]) cylinder(d=eps,h=l);
    }
}

module adapter()
{
    
    ////////////////
    // main frame //
    ////////////////
    difference()
    {
        // main body
        round_cube(x=u_x, y=u_y, z=u_z, d=u_d);
        // inner cut
        x_i = u_x-2*u_wt;
        y_i = u_y-2*u_wt;
        translate([u_wt,u_wt,-eps])
            round_cube(x=x_i, y=y_i, z=u_z+2*eps,d=u_d);       
    }
    
    ///////////
    // hooks //
    ///////////
    h_x = u_x-u_d;
    h_y = u_y-u_d;
    // front
    translate([u_d/2,eps,u_z-c_h]) hook(l=h_x);
    // back
    translate([u_x-u_d/2,u_y-eps,u_z-c_h]) rotate([0,0,180])
        hook(l=h_x);
    // left
    translate([0,u_y-u_d/2,u_z-c_h]) rotate([0,0,270]) hook(l=h_y);
    // right
    translate([u_x,+u_d/2,u_z-c_h]) rotate([0,0,90]) hook(l=h_y);

    ////////////////
    // connectors //
    ////////////////

    c_x = (u_x - n_cols*t_l)/2 + t_l/2;
    c_y = (u_y - n_rows*t_l)/2 + t_l/2;
    
    // left front
    translate([c_x,c_y,0])
    difference()
    {
        union()
        {
            // main part in upper part
            hull()
            {
                cylinder(d=t_l,h=u_z);
                // TODO fix this hardcoded ones
                translate([-1, -1, 0])cylinder(d=t_l, h=u_z);
                #translate([0,-c_y,0]) cube([t_l/2,c_y,u_z]);
                #translate([-c_x,0,0])cube([c_x,t_l/2,u_z]);
                %cylinder(d=0.1,h=u_z);
            }
            translate([0,0,-t_hh]) cylinder(d=t_l-t_wt,h=t_hh);

        }
        translate([0,0,-t_hh-eps])
            cylinder(d=t_d,h=u_z+t_hh+2*eps);
    }
    
    //right front
    translate([u_x-c_x,c_y,0])
    difference()
    {
        union()
        {
            // main part in upper part
            hull()
            {
                cylinder(d=t_l,h=u_z);
                // TODO fix this hardcoded ones
                translate([+1, -1, 0])cylinder(d=t_l, h=u_z);
                #translate([-t_l/2,-c_y,0]) cube([t_l/2,c_y,u_z]);
                #translate([0,0,0])cube([c_x,t_l/2,u_z]);
                %cylinder(d=0.1,h=u_z);
            }
            translate([0,0,-t_hh]) cylinder(d=t_l-t_wt,h=t_hh);

        }
        translate([0,0,-t_hh-eps])
            cylinder(d=t_d,h=u_z+t_hh+2*eps);
    }
     // left back
    translate([c_x,u_y-c_y,0])
    difference()
    {
        union()
        {
            // main part in upper part
            hull()
            {
                cylinder(d=t_l,h=u_z);
                // TODO fix this hardcoded ones
                translate([-1, +1, 0])cylinder(d=t_l, h=u_z);
                #translate([0,0,0]) cube([t_l/2,c_y,u_z]);
                #translate([-c_x,-t_l/2,0])cube([c_x,t_l/2,u_z]);
                %cylinder(d=0.1,h=u_z);
            }
            translate([0,0,-t_hh]) cylinder(d=t_l-t_wt,h=t_hh);

        }
        translate([0,0,-t_hh-eps])
            cylinder(d=t_d,h=u_z+t_hh+2*eps);
    }
    
    //right back
    translate([u_x-c_x,u_y-c_y,0])
    difference()
    {
        union()
        {
            // main part in upper part
            hull()
            {
                cylinder(d=t_l,h=u_z);
                // TODO fix this hardcoded ones
                translate([+1, +1, 0])cylinder(d=t_l, h=u_z);
                #translate([-t_l/2,0,0]) cube([t_l/2,c_y,u_z]);
                #translate([0,-t_l/2,0])cube([c_x,t_l/2,u_z]);
                %cylinder(d=0.1,h=u_z);
            }
            translate([0,0,-t_hh]) cylinder(d=t_l-t_wt,h=t_hh);

        }
        translate([0,0,-t_hh-eps])
            cylinder(d=t_d,h=u_z+t_hh+2*eps);
    }

    
}

adapter();
