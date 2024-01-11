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

-- Delete word backwards
keymap.set("n", "dw", "vb_d")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Increase / Decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Jumplist
-- NOTE: Might want to install harpoon as well
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New Tab
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Split windows
keymap.set("n", "sh", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move Window
-- There are some keys conflicting with harpoon right now so it wont work well
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")

-- Resize Window
keymap.set("n", "<C-left>", "<C-w>>")
keymap.set("n", "<C-right>", "<C-w><")
keymap.set("n", "<C-up>", "<C-w>+")
keymap.set("n", "<C-down>", "<C-w>-")

-- REQUIRED
harpoon:setup()
-- REQUIRED

keymap.set("n", ";a", function()
  harpoon:list():append()
end)

keymap.set("n", ";c", function()
  harpoon:list():clear()
end)
keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

--[[
keymap.set("n", "<C-h>", function()
  harpoon:list():select(1)
end)
keymap.set("n", "<C-t>", function()
  harpoon:list():select(2)
end)
keymap.set("n", "<C-n>", function()
  harpoon:list():select(3)
end)
keymap.set("n", "<C-s>", function()
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
keymap.set("n", "<leader>ff", builtin.find_files, {})
keymap.set("n", "<leader>/", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})

keymap.set("n", "<leader>e", ":Neotree toggle<Return>", opts)

keymap.set("n", "<leader>p", function()
  vim.cmd.Git("push")
end, opts)
