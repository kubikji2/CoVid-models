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
/*
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
rh_sh = 2;
// side wings width
rh_s = rh_so+rh_o;
*/

module pipette_head_plate()
{
    difference()
    {
        // main geometry
        union()
        {
            // main shape
            //round_cube(x=p_x,y=p_y,z=p_z,d=p_y);
            round_cube(x=p_x,y=p_y,z=p_b,d=p_y);
            
            x_off = (p_x-n_ch*g_l)/2;
            ho_y = g_l/2+p_bo/2;
            for(i=[0:n_ch-1])
            {
                ho_x = x_off+g_l/2+i*g_l;
                translate([ho_x,ho_y,p_b])
                    cylinder(d=g_l-eps, h=p_bd[i]);
            }
            
            /*
            // upper connectors
            translate([-c_xo,0,p_z])
                cube([p_x+2*c_xo,p_y,c_h]);
            */
        }
        
        /*
        // main conical workspace hole
        hull()
        {
            _d = p_y-p_bo;
            translate([p_y/2,p_y/2,p_b])
                cylinder(h=p_h+c_h+eps,d1=_d,d2=p_y+p_c);
            translate([p_x-p_y/2,p_y/2,p_b])
                cylinder(h=p_h+c_h+eps,d1=_d,d2=p_y+p_c);
        }
        */
        /*
        // removing upper connector in the middle
        translate([p_D/2,-eps,p_z])
            cube([p_x-p_D,p_y+2*eps,p_h]);
        */
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
    
    /*
    // adding hooks
    translate([c_x-c_xo,p_y/2,0])
        rubber_hook();
    translate([p_x+c_xo,p_y/2,0])
        rubber_hook();
    */
    

}

pipette_head_plate();

module rubber_hook()
{
    _x = c_x;
    _y = p_y+2*c_y+2*c_yo;
    _z = c_z;
    
    translate([-_x,-_y/2,0]) difference()
    {
        // main shape
        union()
        {
            // main block
            cube([_x, _y, _z]);
            
            hull()
            {
                // connecting to upper part
                translate([0,(_y-p_y)/2,_z]) cube([_x,p_y,1]);
                translate([0,2*rh_a,0]) cube([_x,_y-4*rh_a,_z]);
            }
            
        }
        // lower hook
        translate([-eps,rh_a,_z-2*rh_a+eps])
            cube([_x+2*eps,rh_a,2*rh_a+eps]);
        // further hook
        translate([-eps,_y-2*rh_a,_z-2*rh_a+eps])
            cube([_x+2*eps,+rh_a,2*rh_a+eps]);
        
        // lower cut
        translate([-eps,(_y-p_y-2*c_yo)/2,-eps])
            cube([_x+2*eps, p_y+2*c_yo, p_z-0.5]);
        
    }
}

//rubber_hook();

/*
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
            hull()
            {
                translate([0,-rh_s,p_z+b_h+rh_sh])
                    round_cube(x=p_x, y=p_y+2*rh_s,z=rh_h,d=p_y);
                // suppport for rubber band
                translate([0,0,p_z+b_h])
                    round_cube(x=p_x,y=p_y,z=rh_sh,d=p_y);
            }
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
            translate([x_i,p_y,p_z+b_h-eps])
                rubber_hook(t=rh_h+rh_sh+2*eps, off=8);
            // lower hooks
            translate([x_i,0,p_z+b_h-eps]) rotate([0,0,180])
                rubber_hook(t=rh_h+rh_sh+2*eps, off=8);
        }
    }
}

pipette_head_plate();


*/



