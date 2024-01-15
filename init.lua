vim.opt.termguicolors = true

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.lsp_zero")
require("config.keymaps")
require("config.lualine")
--require('config.none_ls')
require("config.options")
require("config.conform")
require("config.nvim_lint")
require("config.autocmds")
