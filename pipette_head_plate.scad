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
p_x = n_ch*p_l;
p_y = p_l+3;

module pipette_head_plate()
{
    difference()
    {
        round_cube(x=p_x,y=p_y,z=p_z,d=10);
        
        for(i=[0:n_ch-1])
        {
            ho_x = p_l/2+i*p_l;
            ho_y = p_l/2+1.5;
            translate([ho_x,ho_y,-eps])
            cylinder(h=p_z+2*eps, d=p_d);
        }
        
    }
}

pipette_head_plate();


