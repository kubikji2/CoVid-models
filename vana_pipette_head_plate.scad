use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// number of channels
n_ch = 8;

// plate parameters
p_l = 9;
p_d = 6;
p_z = 1;
p_x = n_ch*p_l+3;
p_y = p_l+3;
// conicity
p_c = 1;

// border height, lower part
b_h = 3;

// rubber hook parameters
// wall thickness
rh_wt = 1.5;
rh_D = 4;
rh_d = 2;
// height of upper part
rh_h = 2;
// 
rh_o = 3;
// side wings offset from border
rh_so = 1;
// side wings width
rh_s = rh_so+rh_o;

module rubber_hook(t=2, off=4)
{
    // left part
    translate([-rh_D-off/2,-eps,0]) cube([rh_D,rh_d+2*eps,t]);
    translate([-rh_D-off/2,rh_d,0]) cube([rh_d,rh_d,t]);
    
    // right part
    translate([+off/2,-eps,0]) cube([rh_D,rh_d+2*eps,t]);
    translate([rh_D-rh_d+off/2,rh_d,0]) cube([rh_d,rh_d,t]);
    
}

//rubber_hook();

module pipette_head_plate()
{
    difference()
    {        
        // main geometry
        union()
        {
            round_cube(x=p_x,y=p_y,z=p_z+b_h,d=p_y);
            // border for the rubber bands
            translate([0,-rh_s,p_z+b_h])
                round_cube(x=p_x, y=p_y+2*rh_s,z=rh_h,d=p_y);
        }
        
        // workspace hole
        hull()
        {
            _d = p_y-2*rh_wt;
            translate([p_y/2,p_y/2,p_z])
                cylinder(h=_d+b_h,d1=_d,d2=p_y+p_c);
            translate([p_x-p_y/2,p_y/2,p_z])
                cylinder(h=_d+b_h,d1=_d,d2=p_y+p_c);
        }
                  
        // holes for pipette tips
        x_off = (p_x-n_ch*p_l)/2;
        ho_y = p_l/2+1.5;
        for(i=[0:n_ch-1])
        {
            ho_x = x_off+p_l/2+i*p_l;
            translate([ho_x,ho_y,-eps])
            cylinder(h=p_z+2*eps, d=p_d);
        }
        
        // rubberband holes
        for(i=[0:2])
        {
            x_i = 2*p_l + 1.5 + i*18;
            // upper hooks
            translate([x_i,p_y,p_z+b_h-eps]) rubber_hook(t=rh_h+2*eps, off=4);
            // lower hooks
            translate([x_i,0,p_z+b_h-eps]) rotate([0,0,180])
                rubber_hook(t=rh_h+2*eps, off=4);
        }
        
        
        /*
        // rubber holes
        // left part
        translate([x_off-1.5*rh_d,-eps,p_z+b_h+rh_h-rh_D-eps])
            cube([rh_d,p_y+2*eps,rh_D+2*eps]);
        translate([x_off-rh_D,-eps,p_z+b_h+rh_h-rh_d-rh_D-eps])
            cube([rh_D,p_y+2*eps,rh_D+2*eps]);
        // right part
        translate([p_x-(x_off-0.5*rh_d),-eps,p_z+b_h+rh_h-rh_D-eps])
            cube([rh_d,p_y+2*eps,rh_D+2*eps]);
        translate([p_x-x_off,-eps,p_z+b_h+rh_h-rh_d-rh_D-eps])
            cube([rh_D,p_y+2*eps,rh_D+2*eps]);
        */
    }
}

pipette_head_plate();


