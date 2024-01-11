require("lint").linters_by_ft = {
  clang = { "cpplint", "cspell" },
  cpp = { "cpplint", "cspell" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  jsx = { "eslint_d" },
  tsx = { "eslint_d" },
  python = { "ruff", "pycodestyle" },
  lua = { "luacheck" },
  php = { "php" },
}
