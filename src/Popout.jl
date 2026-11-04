module Popout

import GLMakie, CairoMakie

export popout

const figure_count = Ref(0)
const show_inline = Ref(true)

inline!(value) = (show_inline[] = value)

function popout(f; inline = show_inline[], kwargs...)
    if inline
        display(f)
    end
    n = figure_count[] += 1
    opts = merge((title = "Figure $n",), kwargs)
    screen = GLMakie.Screen(; opts...)
    display(screen, f)
end

popout(; kwargs...) = f -> (popout(f; kwargs...))

end