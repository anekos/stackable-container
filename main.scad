// Parameters {{{
thickness = 2;

width = 120;
depth = 120;
height = 90;

bottom_height = 14;
bottom_margin = 0.4;
connector_height = 4;

mode = "normal";
r = 3;
// }}}

// Initialization {{{
$fn = 70;

assert(mode == "vase" || mode == "normal", str("Invalid mode: ", mode));
// }}}

module base(width, depth, inner = false) // {{{
{
    d = inner ? thickness : 0;
    offset(r = r - d) offset(delta = -r)
    {
        square([ width, depth ], center = true);
    }
} // }}}

module box(inner = false) // {{{
{

    linear_extrude(height = bottom_height - connector_height)
    {
        base(width - thickness * 2 - bottom_margin * 2, depth - thickness * 2 - bottom_margin * 2, inner);
    }

    hull()
    {
        translate([ 0, 0, bottom_height - connector_height ])
        {
            linear_extrude(height = connector_height)
            {
                base(width - thickness * 2 - bottom_margin * 2, depth - thickness * 2 - bottom_margin * 2, inner);
            }
        }

        translate([ 0, 0, bottom_height ])
        {
            linear_extrude(height = height - bottom_height)
            {
                base(width, depth, inner);
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
                box(inner = true);
            }
        }
    }
} // }}}

main();
