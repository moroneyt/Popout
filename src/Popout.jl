module Popout

import GLMakie
import ImageShow

export popout

const figure_count = Ref(0)
const show_inline = Ref(true)
const inspect_mode = Ref(false)

reset_count!() = (figure_count[] = 0)
inline!(value) = (show_inline[] = value)
inspect!(value) = (inspect_mode[] = value)

# Popout a GLMakie figure into a new window, optionally displaying it inline in VS Code
function popout(f; inline = show_inline[], inspect = inspect_mode[], kwargs...)

    n = figure_count[] += 1
    opts = merge((title = "Figure $n",), kwargs)
    screen = GLMakie.Screen(; opts...)
    display(screen, f)

    if inline
        display(copy(GLMakie.colorbuffer(screen)))
    end
 
    if inspect
        GLMakie.DataInspector(f)
    end

    screen
end

# to allow chaining e.g. surface(randn(100, 100)) |> popout(title = "My Surface", inspect = true)
popout(; kwargs...) = f -> popout(f; kwargs...)

end