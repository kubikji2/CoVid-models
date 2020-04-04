
module round_cube (x=40,y=30,z=2,d=10)
{
    A = x-d;
    B = y-d;
    C = z;
    
    translate([d/2,d/2,0])
    hull()
    {
        cylinder(d=d, h=C);
        translate([A,0,0]) cylinder(d=d, h=C);
        translate([A,B,0]) cylinder(d=d, h=C);
        translate([0,B,0]) cylinder(d=d, h=C);
    }
    
    
}

round_cube();

$fn = 90;
module box (x=82,y=154,z=52,d=20,t=2)
{
    A = x-d;
    B = y-d;
    C = z;
    
    //%translate([-d/2,-d/2,0]) cube([x,y,z]);
    difference()
    {
        hull()
        {
            cylinder(d=d, h=C);
            translate([A,0,0]) cylinder(d=d, h=C);
            translate([A,B,0]) cylinder(d=d, h=C);
            translate([0,B,0]) cylinder(d=d, h=C);
        }
        
        translate([-t/2,-t/2,t])
        hull()
        {
            translate([t,t,0]) cylinder(d=d-t, h=C);
            translate([A,t,0]) cylinder(d=d-t, h=C);
            translate([A,B,0]) cylinder(d=d-t, h=C);
            translate([t,B,0]) cylinder(d=d-t, h=C);
        }
    }
}

//box();