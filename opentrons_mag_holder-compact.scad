use<round_corners.scad>;

// general parameters
$fn = 90;
eps = 0.01;
tol = 0.5;
t_tol = 0.1;

// wall thickness
wt = 2;
// wall height
wh = 10;

// holder parameters
h_x = 84;
h_y = 90;
h_z = wt;

// well paramters
w_y = 83;
echo(w_xo);
w_xo = 4.5;
w_yo = (h_y-w_y)/2;


// locker parameters
l_x = w_xo-wt;
// additional locker extention for higher labware
l_extention = -5;
// lower y dimension
l_yl = 60;
l_yu = 43;
l_zu = 17+l_extention;
l_zl = 42-l_zu-h_z+l_extention+wh;

// bolt hole
bh_d = 4.3;
bh_h = 23+l_extention;
bh_off = 13;

// support beams
sb_x = 2;
sb_y = 4;
sb_yo = 3;

module mag_holder_compact()
{
    difference()
    {
        // main shape
        cube([h_x,h_y,h_z]);
        
        // well cut
        translate([w_xo,w_yo,-eps])
            cube([h_x-w_xo+eps,w_y,h_z+2*eps]);
        
        // locker connection hole
        translate([-eps,(l_yl-l_yu)/2+(h_y-l_yl)/2,-eps])
            cube([l_x+eps,l_yu,l_zl+l_zu]);
        
    }
   
    
    difference()
    {
        // borders
        union()
        {
            // adding borders
            // left border
            translate([w_xo-wt,w_yo-wt,h_z])
                cube([wt,h_y-2*w_yo+2*wt,wh]);
            // left border
            translate([w_xo-wt,w_yo-wt,h_z])
                cube([h_x-w_xo+wt, wt,wh]);

            // right border
            translate([w_xo-wt,h_y-w_yo,h_z])
                cube([h_x-w_xo+wt, wt,wh]);
        }
        
        // cutting 
        txt = "CoVeni, CoVidi, CoVici";
        translate([w_xo-wt/2+eps,w_yo+(h_y-w_yo)/2,h_z+wh/2])
            rotate([90,0,90])
                linear_extrude(wt/2)
                    text(   text=txt, size=5,
                            font="Arial:style=Bold",
                            halign="center", valign="center");
        
        
    }
    
   
        
}

mag_holder_compact();


module locker()
{
    // locker
    translate([0,(h_y-l_yl)/2,h_z])
    difference()
    {
        // locker main geometry
        // lower part
        _l_yu_o = (l_yl-l_yu)/2;
        translate([0,_l_yu_o,-wt])
            cube([l_x,l_yu,l_zl+l_zu+wt]);
        
        // bolt hole
        translate([-eps,(l_yl)/2,bh_off-h_z+bh_d/2+wh])
        hull()
        {
            rotate([0,90,0]) cylinder(d=bh_d,h=l_x+2*eps);
            translate([0,0,bh_h-bh_d]) rotate([0,90,0])
                cylinder(d=bh_d,h=l_x+2*eps);
        }
    }
    
    // support beams
    translate([-sb_x,(h_y-l_yu)/2+sb_yo,0])
        cube([sb_x,sb_y,h_z+l_zu+l_zl]);
    translate([-sb_x,h_y -(h_y-l_yu)/2-sb_yo-sb_y,0])
        cube([sb_x,sb_y,h_z+l_zu+l_zl]);

}

//locker();
