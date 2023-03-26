require("notify").setup({
  --[[ stages = "fade_in_slide_out", ]]
  stages = "slide",
  background_color = "FloatShadow",
  timeout = 3000,
  render = "compact",
})

vim.notify = require("notify")
