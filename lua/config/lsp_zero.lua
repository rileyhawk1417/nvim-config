local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "<leader>ws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "<leader>wd", function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "R", function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set("n", "<leader>cr", function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)
end

local mason_modules = {
  -- NOTE: Linters
  "cpplint",
  "cspell",
  "eslint_d",
  "ruff_lsp",
  "pycodestyle",
  "luacheck",
  "php",
  --NOTE: Formatters
  "stylua",
  "black",
  "prettierd",
  "pretty-php",
  "clang-format",
  "stylua",
}

local mason_lsp_modules = {
  "clangd",
  "tsserver",
  "rust_analyzer",
  "lua_ls",
  "cssls",
  "tailwindcss",
  "ruff_lsp",
  "pyright",
  "intelephense",
}

require("fidget").setup({})
require("mason").setup({
  ensure_installed = mason_modules,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason-lspconfig").setup({
  ensure_installed = mason_lsp_modules,
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,
  },
})

require("dart-tools")
require("lspconfig")["dartls"].setup({
  capabilities = capabilities,
  cmd = {
    "dart",
    "language-server",
    "--protocol=lsp",
    -- "--port=8123",
    -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
  },
  filetypes = { "dart" },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = false,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = false,
    flutterOutline = false,
  },
  settings = {
    dart = {
      analysisExcludedFolders = {
        vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
        vim.fn.expand("$HOME/.pub-cache"),
        vim.fn.expand("/opt/homebrew/"),
        vim.fn.expand("$HOME/tools/flutter/"),
      },
      updateImportsOnRename = true,
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({})
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 3 },
  },
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  --formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    --["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    --["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<S-->"] = cmp.mapping.scroll_docs(-4),
    ["<S-+>"] = cmp.mapping.scroll_docs(4),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
})

vim.diagnostic.config({
  virtual_text = true,
})
