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
  "markdown",
  "markdown_inline",
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
        auto_install = true,
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = parser_list,
      })
    end,
  },
}
