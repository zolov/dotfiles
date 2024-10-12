return {
  "echasnovski/mini.animate",
  version = false,
  event = "BufRead",
  config = function()
    local animate = require("mini.animate")
    animate.setup({
      resize = {
        timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
      },
      scroll = {
        timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
      },
    })
  end,
}
