return {
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
  },

  -- Display current filename above
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    -- TODO: Come back and finish setup
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+]" .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    --[[
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous tab" },
    },
    --]]
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icons = false,
      },
    },
  },

  -- Disable Flash plugin
  {
    "folke/flash.nvim",
    enabled = false,
  },

  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- Colorschemes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
