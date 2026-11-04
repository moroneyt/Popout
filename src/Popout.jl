module Popout

import GLMakie, CairoMakie

export popout

const figure_count = Ref(0)
const show_inline = Ref(true)
const inspect_mode = Ref(true)

reset_count!() = (figure_count[] = 0)
inline!(value) = (show_inline[] = value)
inspect!(value) = (inspect_mode[] = value)

function popout(f; inline = show_inline[], inspect = inspect_mode[], kwargs...)
    if inline
        CairoMakie.activate!(); display(f)
    end
    n = figure_count[] += 1
    opts = merge((title = "Figure $n",), kwargs)
    screen = GLMakie.Screen(; opts...)
    GLMakie.activate!()
    display(screen, f)
    if inspect
        GLMakie.DataInspector(f)
    end
    screen
end

popout(; kwargs...) = f -> (popout(f; kwargs...))

end