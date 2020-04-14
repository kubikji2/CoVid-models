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
// general thickness
t = 2;


// carriage parameters
// carriage length in y axis
c_l = 27;
// carriage width in x axis
c_w = 3.5;
// carriages distance in x axis
c_d = 19;
// distance from the lowes part
c_yo = 13;

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
    
}

opentrons_pipet_tips_pusher();