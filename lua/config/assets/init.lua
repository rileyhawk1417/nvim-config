ASSETS_DIR = (...):match("(.-)[^%.]+$").."assets."
local keymaps = require("config.core.utils").loadModule("config.core.keymaps")
local icons = require("config.core.utils").loadModule(ASSETS_DIR.."icons")
local lsp = require("config.core.lsp_keymaps")

local M = {}

M.keymaps = keymaps
M.lsp = lsp
M.icons = icons

return M

