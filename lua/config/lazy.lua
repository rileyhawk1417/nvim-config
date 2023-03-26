local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

local plugs = {
  -- Has alot of functions for plugins
   'nvim-lua/plenary.nvim',

  -- File explorer


    -- 'ms-jpq/chadtree', branch='chad', run='python3 -m chadtree deps',
    -- config = get_config('plugins.chadTree'),


  -- Indent line

    'lukas-reineke/indent-blankline.nvim',
    -- config = get_config('plugins.indent-blankline'),


  -- Autopair

    'windwp/nvim-autopairs',
    -- config = get_config('plugins.autopairs'),



    'windwp/nvim-ts-autotag',
    -- config = get_config('plugins.nvim-ts-pairs')


   'moll/vim-bbye',


    'lewis6991/impatient.nvim',
    -- config = get_config('plugins.impatient'),



    'ahmedkhalf/project.nvim',
    -- config = get_config('plugins.project'),



    'akinsho/bufferline.nvim',
    -- config = get_config('plugins.bufferline'),



    'folke/which-key.nvim',
    -- config = get_config('plugins.whichkey'),


  -- flutter tools
   'akinsho/flutter-tools.nvim',

  -- Tag viewer
   'preservim/tagbar',


    'akinsho/toggleterm.nvim',
    -- config = get_config('plugins.toggleterm'),


  -----------------------
  -- Treesitter interface
  -----------------------

    {'nvim-treesitter/nvim-treesitter',
      dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- run = ':TSUpdate',
    -- config = get_config('plugins.nvim-treesitter'),


  -- Telescope file finder
   {
  'nvim-telescope/telescope.nvim',
    -- lazy = false,
  dependencies = { 'nvim-telescope/telescope-file-browser.nvim'},
  -- config = get_config('plugins.telescope'),
  },

  --------------------------
  -- LSP
  --------------------------

    -- Flexibility configuring LSP
    'neovim/nvim-lspconfig',
    -- config = get_config('lsp'),



    -- Simple to LS installer
    'williamboman/mason.nvim',
    -- lazy=false,
    -- config = get_config('plugins.mason'),



    'jose-elias-alvarez/null-ls.nvim',
    -- config = get_config('plugins.null-ls'),



    'RRethy/vim-illuminate',
    -- config = get_config('plugins.illuminate'),



    'simrat39/rust-tools.nvim',
    -- config = get_config('plugins.rust-tools'),



    'MunifTanjim/prettier.nvim',
    -- config = get_config('plugins.prettierd')



    'glepnir/lspsaga.nvim',
    -- config = get_config('plugins.lspsaga')



    'norcalli/nvim-colorizer.lua',


  --------------------------
  -- DAP
  --------------------------

    'mfussenegger/nvim-dap',
    -- config = get_config('plugins.dap'),



    'rcarriga/nvim-dap-ui',
    -- config = get_config('plugins.dap-ui'),



    'ravenxrz/DAPInstall.nvim',


  ------------------------
  -- Snippets
  ------------------------


    'L3MON4D3/LuaSnip',



    'rafamadriz/friendly-snippets',


  -------------------------
  -- Autocomplete
  -------------------------
   {
    'hrsh7th/nvim-cmp',
    -- config = get_config('plugins.cmp'),
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  -------------------------
  -- Commenting
  -------------------------


    'numToStr/Comment.nvim',
    -- config = get_config('plugins.comment'),



    'JoosepAlviste/nvim-ts-context-commentstring',


    'folke/todo-comments.nvim',
    -- config = get_config('plugins.todo-comments'),


  -------------------------
  -- colorscheme
  -------------------------


    'lunarvim/darkplus.nvim',



    'kyazdani42/nvim-web-devicons',



    'rcarriga/nvim-notify',
    -- config = get_config('plugins.notify'),



    'navarasu/onedark.nvim',

   'tanvirtin/monokai.nvim',
   'Yagua/nebulous.nvim',
   'katawful/kat.nvim',

    --TODO: This still needs work
    'marko-cerovac/material.nvim',

   'aktersnurra/no-clown-fiesta.nvim',
   'folke/tokyonight.nvim',
   'EdenEast/nightfox.nvim', --TODO: Fix this one as well

   'nyoom-engineering/oxocarbon.nvim',

  -- Statusline
 
    'nvim-lualine/lualine.nvim',
    -- config = get_config('plugins.lualine'),


   {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    -- config = get_config('plugins.trouble')
  },
  -- git labels
 
    'lewis6991/gitsigns.nvim',
    -- config = get_config("plugins.gitsigns")

   'tpope/vim-fugitive',
   'tpope/vim-rhubarb',

  -- Dashboard (start screen)
   'goolord/alpha-nvim',

  -- Tab Stops and shift Width
   'tpope/vim-sleuth',

  -- yuck syntax for eww widgets
   'elkowar/yuck.vim',
}

local opts = {}

--require("lazy").setup(plugs, opts)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { import = "plugins" },
    -- {import = plugs}
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always  the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
