-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local watchMan = require("riley.discipline")
local harpoon = require("harpoon")
watchMan.grok()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Exit insert mode
keymap.set("i", "kk", "<ESC>")

-- Fast save
keymap.set("n", ",s", ":w<CR>")

-- Delete word backwards
keymap.set("n", "dw", "vb_d", { desc = "Delete word backwards" })

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Increase / Decrement
keymap.set("n", "+", "<C-a>", { desc = "Increase number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrease number" })

-- Jumplist
-- NOTE: Might want to install harpoon as well
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New Tab
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split windows
keymap.set("n", "sh", ":split<Return>", { desc = "Split Panes Vertically" })
keymap.set("n", "sv", ":vsplit<Return>", { desc = "Split Panes Horizontally" })

-- Move Window
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left pane" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right pane" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the up pane" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the down pane" })

-- Resize Window
keymap.set("n", "<C-left>", "<C-w>>", { desc = "Resize pane left" })
keymap.set("n", "<C-right>", "<C-w><", { desc = "Resize pane right" })
keymap.set("n", "<C-up>", "<C-w>+", { desc = "Resize pane up" })
keymap.set("n", "<C-down>", "<C-w>-", { desc = "Resize pane down" })

-- Plugin Keybindings
harpoon:setup()

keymap.set("n", ";a", function()
  harpoon:list():append()
end, { desc = "Add file to Harpoon list" })
keymap.set("n", ";c", function()
  harpoon:list():clear()
end, { desc = "Clear Harpoon list" })
keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Toggle Harpoon list" })

keymap.set("n", "<C-1>", function()
  harpoon:list():select(1)
end)
keymap.set("n", "<C-2>", function()
  harpoon:list():select(2)
end)
keymap.set("n", "<C-3>", function()
  harpoon:list():select(3)
end)
keymap.set("n", "<C-4>", function()
  harpoon:list():select(4)
end)
--]]
-- Diagnostics
--[[
keymap.set("n", "<C-j>", function()
  vim.diagnostic.go_to_next()
end, opts)
--]]

-- Telescope keybinds
--
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live grep find in files" })
keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find in buffers" })
keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find in help" })

keymap.set("n", "<leader>e", ":Neotree toggle<Return>", { desc = "Neotree toggle" })

-- Git Keybinds
keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Git" })
keymap.set("n", "<leader>gi", ":Git init<CR>", { desc = "Git init" })
keymap.set("n", "<leader>gP", function()
  vim.cmd.Git("push")
end, { desc = "Git push" })

keymap.set("n", "<leader>gp", function()
  vim.cmd.Git("pull")
end, { desc = "Git pull" })

-- Zen Mode
keymap.set("n", "<leader>fz", ":ZenMode<CR>", { desc = "Zen Mode" })

-- Undo Tree
keymap.set("n", "<leader>fu", ":UndotreeToggle<CR>", { desc = "Undo Tree" })

-- Obsidian Nvim
-- NOTE: The others below require arguments
keymap.set("n", "<leader>on", ":ObsidianNew", { desc = "Create New Obsidian Note" })
-- BUG: Does not open in buffer
--keymap.set("n", "<leader>oo", ":ObsidianOpen", { desc = "Open Obsidian Note" })
keymap.set("n", "<leader>os", ":ObsidianSearch", { desc = "Search Obsidian Notes" })
keymap.set("n", "<leader>op", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })

-- Buffer remaps
keymap.set("n", "<leader>bb", ":buffers", { desc = "List Open buffers" })
keymap.set("n", "<leader>bx", ":bd<CR>", { desc = "Close current buffer" })
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Go to previous buffer" })
