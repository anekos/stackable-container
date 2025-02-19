// Parameters {{{
thickness = 2;

width = 120;
depth = 120;
height = 90;

bottom_height = 14;
bottom_margin = 0.4;
connector_height = 4;

mode = "normal";
vase_thickness = 0.8;
r = 3;
// }}}

// Initialization {{{
$fn = 70;

assert(mode == "vase" || mode == "normal", str("Invalid mode: ", mode));
// }}}

module base(width, depth) // {{{
{
    offset(r = r) offset(delta = -r)
    {
        square([ width, depth ], center = true);
    }
} // }}}

module box() // {{{
{

    linear_extrude(height = bottom_height - connector_height)
    {
        base(width - thickness * 2 - bottom_margin * 2, depth - thickness * 2 - bottom_margin * 2);
    }

    hull()
    {
        translate([ 0, 0, bottom_height - connector_height ])
        {
            linear_extrude(height = connector_height)
            {
                base(width - thickness * 2 - bottom_margin * 2, depth - thickness * 2 - bottom_margin * 2);
            }
        }

        translate([ 0, 0, bottom_height ])
        {
            linear_extrude(height = height - bottom_height)
            {
                base(width, depth);
            }
        }
    }
} // }}}

module main() // {{{
{
    if (mode == "vase")
    {
        box();
    }
    else
    {
        difference()
        {

            box();
            translate([ 0, 0, thickness + 0.01 ])
            {
                resize([ width - thickness * 2, depth - thickness * 2, height - thickness ])
                {
                    box();
                }
            }
        }
    }
} // }}}

main();
