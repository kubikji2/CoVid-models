use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// number of channels
n_ch = 8;

// std grid parameters
g_l = 9;

// pipette parameters
// diameter of the filter tips
p_d = 6;
// diameter of the plate corners
p_D = 9;
// x border offset
p_bo = 3;

//dimension
p_x = n_ch*g_l+p_bo;
p_y = g_l +p_bo;
//p_b = 0.5;
//p_bd = [1.5,1,0,0,0,0,1,1.5];
p_b = 0.75;
p_bd = [0.25,0,0,0,0,0,0,0.25];
p_h = 3;
p_z = p_b+p_h;
// conicity of the inner cut
p_c = 0.5;

// upper connector parameters
// connector offset
c_xo = 6;
c_x = 6;
c_yo = 5;
c_y = 6;
c_h = 3;
c_z = 6;


// rubber hook parameters
rh_wt = 1.5;
rh_a = 2;



module pipette_head_plate()
{
    difference()
    {
        // main geometry
        union()
        {
            // main shape
            round_cube(x=p_x,y=p_y,z=p_b,d=p_y);
            
            x_off = (p_x-n_ch*g_l)/2;
            ho_y = g_l/2+p_bo/2;
            for(i=[0:n_ch-1])
            {
                ho_x = x_off+g_l/2+i*g_l;
                translate([ho_x,ho_y,p_b])
                    cylinder(d=g_l-eps, h=p_bd[i]);
            }
            
        }

        // holes for pipette tips
        x_off = (p_x-n_ch*g_l)/2;
        ho_y = g_l/2+p_bo/2;
        for(i=[0:n_ch-1])
        {
            ho_x = x_off+g_l/2+i*g_l;
            translate([ho_x,ho_y,-eps])
                cylinder(h=p_b+2*eps+max(p_bd), d=p_d);
        }
    }
}

pipette_head_plate();
