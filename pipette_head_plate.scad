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

// rubber hook parameters
// wall thickness
rh_wt = 1.5;
rh_D = 2;
rh_d = 2;
rh_h = 3+rh_D;

module pipette_head_plate()
{
    difference()
    {        
        // main geometry
        union()
        {
            round_cube(x=p_x,y=p_y,z=p_z+rh_h,d=10);
            translate([-rh_wt,0,rh_h-rh_D])
                round_cube(x=p_x+2*rh_wt, y=p_y,z=rh_h-rh_D);
        }
        
        // workspace hole
        #translate([rh_wt,rh_wt,p_z])
            round_cube(x=p_x-2*rh_wt,y=p_y-2*rh_wt,z=rh_h+2*eps,d=9);
          
        // holes for pipette tips
        x_off = (p_x-n_ch*p_l)/2;
        ho_y = p_l/2+1.5;
        for(i=[0:n_ch-1])
        {
            ho_x = x_off+p_l/2+i*p_l;
            translate([ho_x,ho_y,-eps])
            cylinder(h=p_z+2*eps, d=p_d);
        }
        
        // rubber holes
        _a = 60;
        // left holes
        translate([x_off+p_l/2,ho_y,p_z+rh_h-rh_D])
            rotate([0,0,_a])
                translate([-rh_d/2,-rh_d/2,0])
                    cube([rh_d,p_x,rh_D+2*eps]);
        translate([x_off+p_l/2,ho_y,p_z+rh_h-rh_D])
            rotate([0,0,180-_a])
                translate([-rh_d/2,-rh_d/2,0])
                    cube([rh_d,p_x,rh_D+2*eps]);
        // right holes
        translate([p_x-x_off-p_l/2,ho_y,p_z+rh_h-rh_D])
            rotate([0,0,180+_a])
                translate([-rh_d/2,-rh_d/2,0])
                    cube([rh_d,p_x,rh_D+2*eps]);
        translate([p_x-x_off-p_l/2,ho_y,p_z+rh_h-rh_D])
            rotate([0,0,-_a])
                translate([-rh_d/2,-rh_d/2,0])
                    cube([rh_d,p_x,rh_D+2*eps]);
                    
        // rubber secure peak
        translate([rh_wt-0.5,(p_y-p_d)/2,p_z+rh_h-rh_D+eps])
            cube([p_x-2*rh_wt+1,p_d,1]);
        
    }
}

pipette_head_plate();


