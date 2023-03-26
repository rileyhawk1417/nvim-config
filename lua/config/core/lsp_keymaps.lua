---@diagnostic disable need-check-nil

--   <C-key>
-- <BS>           Backspace
-- <Tab>          Tab
-- <CR>           Enter
-- <Enter>        Enter
-- <Return>       Enter
-- <Esc>          Escape
-- <Space>        Space
-- <Up>           Up arrow
-- <Down>         Down arrow
-- <Left>         Left arrow
-- <Right>        Right arrow
-- <F1> - <F12>   Function keys 1 to 12
-- #1, #2..#9,#0  Function keys F1 to F9, F10
-- <Insert>       Insert
-- <Del>          Delete
-- <Home>         Home
-- <End>          End
-- <PageUp>       Page-Up
-- <PageDown>     Page-Down
-- <bar>          the '|' character, which otherwise needs to be escaped '\|'

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

PLUGINS_DIR = (...):match("(.-)[^%.]+$") .. "plugins."

local utils = require("config.core.utils")
local icons = utils.loadModule("config.assets.icons")

-- Shorten function names
local keymap = vim.keymap.set

local opts_buf0 = { silent = true, buffer = 0 }
local opts = { noremap = true, silent = true }

local M = {}

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------------------------------
-- LSP mapping
---------------------------------------
-- These are the keymaps that will attach to any buffer that is attached to LSP
M.lsp_keymaps = function(bufnr)
	keymap("n", "<leader>lf", vim.lsp.buf.formatting, utils.withTable(opts_buf0, { desc = "Format buffer" }))
	keymap("n", "gD", vim.lsp.buf.declaration, utils.withTable(opts_buf0, { desc = "Go to declaration" }))
	keymap("n", "gd", vim.lsp.buf.definition, utils.withTable(opts_buf0, { desc = "Go to definition" }))
	keymap("n", "K", vim.lsp.buf.hover, utils.withTable(opts_buf0, { desc = "Hover" }))
	keymap("n", "gi", vim.lsp.buf.implementation, utils.withTable(opts_buf0, { desc = "Go to implementation" }))
	keymap("n", "<C-k>", vim.lsp.buf.signature_help, utils.withTable(opts_buf0, { desc = "Signature help" }))
	keymap("n", "<C-space>", vim.lsp.buf.code_action, utils.withTable(opts_buf0, { desc = "Code action" }))
	keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", utils.withTable(opts_buf0, { desc = "References" }))
	keymap("n", "gl", vim.diagnostic.open_float, utils.withTable(opts_buf0, { desc = "Diagnostic" }))
	keymap("n", "[d", vim.diagnostic.goto_prev, utils.withTable(opts_buf0, { desc = "Diagnostic goto prev" }))
	keymap("n", "]d", vim.diagnostic.goto_next, utils.withTable(opts_buf0, { desc = "Diagnostic goto next" }))
	keymap(
		"n",
		"<leader>q",
		vim.diagnostic.setloclist,
		utils.withTable(opts_buf0, { desc = "Diagnostic to Location list" })
	)
	keymap(
		"n",
		"<leader>ld",
		"<cmd>Telescope diagnostics<cr>",
		utils.withTable(opts_buf0, { desc = "Diagnostic to Telescope" })
	)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])

	---------------
	--- Refactoring
	---------------
	keymap("n", "<leader>r", vim.lsp.buf.rename, utils.withTable(opts_buf0, { desc = "Rename label" }))

	-------------
	--- Debugging
	-------------
	keymap("n", "<F5>", "<cmd>DapContinue<cr>", utils.withTable(opts_buf0, { desc = "Dap Continue" }))
	keymap("n", "<C-F5>", "<cmd>DapTerminate<cr>", utils.withTable(opts_buf0, { desc = "Dap Terminate" }))
	keymap("n", "<F7>", "<cmd>DapStepInto<cr>", utils.withTable(opts_buf0, { desc = "Dap Step Over" }))
	keymap("n", "<F8>", "<cmd>DapStepOver<cr>", utils.withTable(opts_buf0, { desc = "Dap Step Into" }))
	keymap("n", "<S-F8>", "<cmd>DapStepOut<cr>", utils.withTable(opts_buf0, { desc = "Dap Step Out" }))
	keymap("n", "<F9>", "<cmd>DapToggleBreakpoint<cr>", utils.withTable(opts_buf0, { desc = "Dap Toggle Breakpoint" }))
	keymap(
		"n",
		"<Leader>B",
		"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
		utils.withTable(opts_buf0, { desc = "Dap Toggle Breakpoint" })
	)
	--[[ nmap <F8> <cmd>call vimspector#Reset()<cr> ]]
	--[[ map('n', "Dw", ":call vimspector#AddWatch()<cr>") ]]
	--[[ map('n', "De", ":call vimspector#Evaluate()<cr>") ]]
	--[[ nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR> ]]
	--[[ nnoremap <silent> <Leader>dr <Cmd>lua: require'dap'.repl.open()<CR> ]]
	--[[ nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR> ]]
	--[[ vim.keymap.set(n, '<leader>dl',  function() require('dap').run_last() end) ]]
end

M.lsp_keymaps_rust = function(bufnr)
	local rt = require("config.core.utils").loadModule("rust-tools")
	keymap("n", "<F5>", "<cmd>RustDebuggables<cr>", utils.withTable(opts_buf0, { desc = "Rust RustDebuggables" }))
	keymap(
		"n",
		"<C-space>",
		rt.hover_actions.hover_actions,
		utils.withTable(opts_buf0, { desc = "Rust Hover actions" })
	)
	keymap(
		"n",
		"<Leader>a",
		rt.code_action_group.code_action_group,
		utils.withTable(opts_buf0, { desc = "Rust code actions" })
	)
end

---------------------------------------------
-- cmp mapping
---------------------------------------------
local cmp = require("config.core.utils").loadModule("cmp")
--local luasnip = require("config.core.utils").loadModule("luasnip")

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

M.cmp_mapping = {
	["<C-k>"] = cmp.mapping.select_prev_item(),
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
	["<C-e>"] = cmp.mapping({
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
	-- Accept currently selected item. If none selected, `select` first item.
	-- Set `select` to `false` to only confirm explicitly selected items.
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	--[[
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		--		elseif check_backspace() then
		--			fallback()
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
	--]]
}

---------------------------------
-- Which-key keymaps
---------------------------------
M.whichkey_mappings = {
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["q"] = { "<cmd>q<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	["o"] = { "<cmd>so %<CR>", "Source current file" },
	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
	},

	l = {
		name = "LSP",
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

M.dap_mappings = {
	-- Use a table to apply multiple mappings
	expand = { "<CR>", "<2-LeftMouse>" },
	open = "o",
	remove = "d",
	edit = "e",
	repl = "r",
	toggle = "t",
}

return M
