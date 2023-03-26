local a = require("config.assets")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local builtInTime = function()
	return " " .. os.date("%R")
end

local function fg(name)
	return function()
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
	end
end

local state = {
	function()
		return require("noice").api.status.command.get()
	end,
	cond = function()
		return package.loaded["noice"] and require("noice").api.status.command.has()
	end,
	color = fg("Statement"),
}
local constant = {
	function()
		return require("noice").api.status.mode.get()
	end,
	cond = function()
		return package.loaded["noice"] and require("noice").api.status.mode.has()
	end,
	color = fg("Constant"),
}
local special = { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") }

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = a.icons.error .. " ",
		warn = a.icons.warning .. " ",
		info = a.icons.info .. " ",
		hint = a.icons.hint .. " ",
	},
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = {
		added = a.icons.git.nb_line_added .. " ",
		modified = a.icons.git.nb_line_changed .. " ",
		removed = a.icons.git.nb_line_deleted .. " ",
	},
	-- cond = hide_in_width
}

local filetype = {
	"filetype",
	icons_enabled = true,
	cond = hide_in_width,
	padding = { left = 1, right = 0 },
}

local filename = {
	"filename",
	path = 1,
	symbols = { modified = "  ", readonly = "", unamed = "" },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local spaces = function()
	if hide_in_width then
		return ""
	end

	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end


return {

	-- Better Notify with Notify
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
			stages = "slide",
			background_color = "FloatShadow",
		},
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	{
		"MunifTanjim/nui.nvim",
		lazy = true,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			-- TODO: Remember to add the opts

			options = {
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d",
				right_mouse_command = nil,
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = a.icons.indicator,
					style = "icon",
				},

				buffer_close_icon = a.icons.close,
				modified_icon = a.icons.modified,
				close_icon = a.icons.close,
				left_trunc_marker = a.icons.left_marker,
				right_trunc_marker = a.icons.right_marker,
				max_name_length = 30,
				max_prefix_length = 30,
				tab_size = 21,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				offsets = { {
					filetype = "NvimTree",
					text = "",
					padding = 1,
				} },
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "thin",
				enforce_regular_tabs = true,
				always_show_bufferline = true,
			},

			highlights = {
				fill = {
					fg = { attribute = "fg", highlight = "#ff0000" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				background = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				buffer_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				close_button = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				close_button_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				tab_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				tab = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				tab_close = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				duplicate_selected = {
					fg = { attribute = "fg", highlight = "TabLineSel" },
					bg = { attribute = "bg", highlight = "TabLineSel" },
					italic = true,
				},

				duplicate_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},

				duplicate = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
					italic = true,
				},

				modified = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				modified_selected = {
					fg = { attribute = "fg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				modified_visible = {
					fg = { attribute = "fg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				separator = {
					fg = { attribute = "bg", highlight = "TabLine" },
					bg = { attribute = "bg", highlight = "TabLine" },
				},

				separator_selected = {
					fg = { attribute = "bg", highlight = "Normal" },
					bg = { attribute = "bg", highlight = "Normal" },
				},

				indicator_selected = {
					fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
					bg = { attribute = "bg", highlight = "Normal" },
				},
			},
		},
	},


	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function(plugin)
			if plugin.override then
				require("util").deprecate("lualine.override", "lualine.opts")
			end

			--local icons = require("config").icons

			return {
				options = {
					icons_enabled = true,
					theme = "horizon",
					component_separators = { left = " ", right = " " },
					section_separators = { left = " ", right = " " },
					disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
					always_divide_middle = true,
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { branch, diagnostics },
					lualine_c = { filename },
					lualine_x = {
						diff,
						spaces,
						"encoding",
						filetype,
						constant,
						special,
						state,
					},
					lualine_y = { "progress", location },
					lualine_z = { builtInTime },
				},
				extensions = { "neo-tree" },
			}
		end,
	},

    {
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "BufReadPre",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
			require("mini.indentscope").setup(opts)
		end,
	},

    {
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
			},
		},
	},
}