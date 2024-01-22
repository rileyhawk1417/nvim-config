return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- NOTE: Git stuff
  {
    "f-person/git-blame.nvim",
  },
  { "tpope/vim-fugitive" },
  { "numToStr/Comment.nvim" },
  { "folke/zen-mode.nvim" },
  { "laytan/cloak.nvim" },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        icons = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      -- see below for full list of options 👇
    },
  },
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "laytan/cloak.nvim",
    config = function()
      require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        highlight_group = "Comment",
        patterns = {
          {
            file_pattern = {
              ".env*",
            },
            cloak_pattern = "=.+",
          },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("javascript", { "jsdoc" })
      require("luasnip").filetype_extend("typescript", { "tsdoc" })
      require("luasnip").filetype_extend("rust", { "rustdoc" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("c", { "cdoc" })
      require("luasnip").filetype_extend("php", { "phpdoc" })
    end,
  },

  {
    "danymat/neogen",
    dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
    config = function()
      local neogen = require("neogen")
      neogen.setup({
        snippet_engine = "luasnip",
      })

      -- Define functions
      vim.keymap.set("n", "<leader>nf", function()
        neogen.generate({ type = "func" })
      end, { desc = "Generate doc for functions" })

      -- Define types
      vim.keymap.set("n", "<leader>nt", function()
        neogen.generate({ type = "type" })
      end, { desc = "Generate doc for types" })
      -- Define type defs
      vim.keymap.set("n", "<leader>nd", function()
        neogen.generate({ type = "typedef" })
      end, { desc = "Generate doc for type definitions" })
    end,
  },
}
