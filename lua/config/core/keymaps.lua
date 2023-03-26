-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ","

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Disable arrow keys
--map('', '<up>', '<nop>')
--map('', '<down>', '<nop>')
--map('', '<left>', '<nop>')
--map('', '<right>', '<nop>')

-- Map Esc to kk
map("i", "kk", "<Esc>")

--Map close current file
map("n", "<C-x>", ":bd<CR>")

-- Clear search highlighting with <leader> and c
map("n", "<leader>c", ":nohl<CR>")

-- Toggle auto-indenting for code paste
map("n", "<F2>", ":set invpaste paste?<CR>")
vim.opt.pastetoggle = "<F2>"

-- Change split orientation
map("n", "sh", ":split<Return><C-w>w") -- change vertical to horizontal
map("n", "sv", ":vsplit<Return><C-w>w") -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<Space>", "<C-w>w")
map("", "<left>", "<C-w>h")
map("", "<down>", "<C-w>j")
map("", "<up>", "<C-w>k")
map("", "<right>", "<C-w>l")

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")

-- Fast saving with <leader> and s
map("n", "<leader>s", ":w<CR>")

-- Close all windows and exit from Neovim with <leader> and q
map("n", "<leader>q", ":qa!<CR>")
-- Close current window
map("n", "<leader>x", ":q<CR>")

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map("n", "<C-t>", ":Term<CR>", { noremap = true }) -- open
map("t", "<Esc>", "<C-\\><C-n>") -- exit

-- CHADTree
--map('n', '<C-f>', ':CHADopen<CR>')

-- Neotree
map("n", "<C-f>", ":Neotree<CR>") -- open neotree
map("n", "<C-d>", ":Neotree close<CR>") -- close neotree

-- Tagbar
map("n", "<leader>z", ":TagbarToggle<CR>") -- open/close

-- Bufferline
--TODO: Fix bufferline keymap
-- Refer to bufferline config
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})

-- Telescope
--Hack to open telescope file browser
map("n", "<C-s>", ":Telescope find_files<CR>")

-- TodoTrouble & TodoTelescope
map("n", "<leader>t", ":TodoTrouble<CR>")
map("n", "<leader>T", ":TodoTelescope<CR>")
map("n", "<leader>f", ":TroubleToggle document_diagnostics<CR>")
map("n", "<leader>d", ":TroubleToggle workspace_diagnostics<CR>")

-- Code Folding
--[[
NOTE: Folding keybindings
zo opens a fold at the cursor.
zShift+o opens all folds at the cursor.
zc closes a fold at the cursor.
zm increases the foldlevel by one.
zShift+m closes all open folds.
zr decreases the foldlevel by one.
zShift+r decreases the foldlevel to zero -- all folds will be open.
]]
--
--map("n", "<leader>f", "<Cmd>zShift+m<CR>", {}) --fold all code in file
--map("n", "<leader>u", "<Cmd>zShift+r<CR>", {}) --unfold all code in file
