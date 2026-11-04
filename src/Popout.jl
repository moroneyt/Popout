module Popout

import GLMakie, CairoMakie

export popout

const figure_count = Ref(0)
const show_inline = Ref(true)

inline!(value) = (show_inline[] = value)

function popout(f; inline = show_inline[])
    if inline
        display(f)
    end
    screen = GLMakie.Screen(title = "Figure $(figure_count[] += 1)")
    display(screen, f)
end

popout(; inline) = f -> (popout(f; inline))

end