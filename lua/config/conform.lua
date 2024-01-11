require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    jsx = { "prettierd" },
    tsx = { "prettierd" },
    php = { "pretty-php" },
    clang = { "clang-format" },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
})
