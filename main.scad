// Parameters {{{
thickness = 2;

width = 120;
depth = 120;
height = 90;

bottom_padding = 2;
bottom_height = 12;
connector_height = 4;

mode = "normal";
vase_wall_thickness = 0.8;
// }}}

// Initialization {{{
$fn = 70;

function vase_mode() = mode == "vase" || mode == "vase-inside";
function shrink() = mode == "vase-inside" ? thickness - vase_wall_thickness : 0;

assert(mode == "vase" || mode == "normal" || mode == "vase-inside", str("Invalid mode: ", mode));
// }}}

module base(width, depth) // {{{
{
    r = 2;

    offset(r = r) offset(delta = -r)
    {
        square([ width, depth ], center = true);
    }
} // }}}

module box(shrink = 0) // {{{
{

    linear_extrude(height = bottom_height - connector_height)
    {
        base(width - bottom_padding * 2 - shrink * 2, depth - bottom_padding * 2 - shrink * 2);
    }

    hull()
    {
        translate([ 0, 0, bottom_height - connector_height ])
        {
            linear_extrude(height = connector_height)
            {
                base(width - bottom_padding * 2 - shrink * 2, depth - bottom_padding * 2 - shrink * 2);
            }
        }

        translate([ 0, 0, bottom_height ])
        {
            linear_extrude(height = height - bottom_height)
            {
                base(width - shrink * 2, depth - shrink * 2);
            }
        }
    }
} // }}}

module main() // {{{
{
    if (vase_mode())
    {
        box(shrink = shrink());
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
