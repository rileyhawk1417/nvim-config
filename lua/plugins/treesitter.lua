local parser_list = {
  "astro",
  "bash",
  "cmake",
  "cpp",
  "css",
  "gitignore",
  "go",
  "html",
  "java",
  "json",
  "javascript",
  "lua",
  "typescript",
  "toml",
  "xml",
  "yaml",
  "zig",
  "sql",
  "ruby",
  "php",
  "tsx",
  "kotlin",
  "php",
  "rust",
  "sql",
  "python",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        sync_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = parser_list,
      })
    end,
  },
}
