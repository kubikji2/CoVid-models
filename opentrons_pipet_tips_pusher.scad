// general parameters
$fn = 90;
eps = 0.01;

// extention
extention = 0;

// body parameters
// lower x dimension
x_l = 79;
// upper x dimension
x_u = 75.5;
// lowest y part size
y_l = 17;
// middle transition y part size
y_m = 3;
// upper y part size
y_u = 24;
// top y part size (hulled cylinders)
y_t = 10.75 + extention;
// z dimension
z = 11.6;
// z step between y body and hulled cylinders
z_s = 1;
// top part diameter
z_d = 12.5;
// general thickness
t = 2;
// upper diameter
u_d = 6.3;

// carriage parameters
// carriage length in y axis
c_l = 27;
// carriage width in x axis
c_w = 3.5;
// carriages distance in x axis
c_d = 19;
// distance from the lowes part
c_yo = 13;
// side wall thickness for the border
c_t = 1.25;

// stopper parameters
// stopper width in x axis
s_w = 11;
// stopper lenght in y axis
s_l = 2.2;
// stopper offset in y axis from the lowest part
s_yo = 44-0.2;

// arch parameters
// arch diameter
a_d = 6;
// arch height (distance from lowest part to the beginning of the arch)
a_h = 7.25-a_d;
// pillar width
a_p = 3;


module opentrons_pipet_tips_pusher()
{
    difference()
    {
        union()
        {
            // lowest block
            cube([x_l,y_l,z]);
            // middle block
            hull()
            {
                _o = 1;
                translate([0,y_l-_o,0]) cube([x_l,_o,z]);
                translate([(x_l-x_u)/2,y_l+y_m,0]) cube([x_u,_o,z]);
            }
            // upper block
            translate([(x_l-x_u)/2,y_l+y_m,0]) cube([x_u,y_u,z]);
            
            // top part
            translate([ (x_l-x_u)/2+z_d/2,
                        y_l+y_m+y_u,
                        z_d/2-(z_d-z)-z_s])
            rotate([-90,0,0])
            difference()
            {
                hull()
                {
                    cylinder(h=y_t,d=z_d);
                    translate([x_u-z_d,0,0])
                        cylinder(h=y_t,d=z_d);
                }
                
                // middle hole
                translate([c_t/2,0,-eps]) hull()
                {
                    cylinder(h=y_t-t,d=z_d-2*c_t);
                    translate([x_u-z_d-c_t,0,0])
                        cylinder(h=y_t-t,d=z_d-2*c_t);
                }
                
                // lower cut
                translate([-z_d/2-eps,eps,-eps])
                    cube([x_u,z_d/2,y_t-t]);
                
                // hole for pipette tips
                for(i=[0:7])
                {
                    _x = i*9;
                    translate([_x,0,-eps])
                        cylinder(d=u_d,h=z_d);
                    
                }
                
            }
        }
        
        // cut into the main block
        translate([(x_l-x_u)/2-eps,t,-eps])
            cube([x_u+2*eps,y_l+y_m+y_u-t+eps,z-t]);
        
        // 
        
    }
}

opentrons_pipet_tips_pusher();