-- local current_signature = function()
-- 	if not pcall(require, 'lsp_signature') then return end
-- 	local sig = require("lsp_signature").status_line(50)
-- 	return sig.label .. "🐼" .. sig.hint
-- end

return {
	{
		-- "theniceboy/eleline.vim",
		"nvim-lualine/lualine.nvim",
		-- You can optionally lazy-load heirline on UiEnter
		-- to make sure all required plugins and colorschemes are loaded before setup
		-- event = "UiEnter",
		config = function()
			require('lualine').setup {
				options = {
					icons_enabled = true,
					theme = 'auto',
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					}
				},
				sections = {
					lualine_a = { { 'filename', path = 3, shorting_target = 120, } },
					lualine_b = { 'branch', 'diff', 'diagnostics' },
					lualine_c = { {
						"aerial",
						-- The separator to be used to separate symbols in status line.
						sep = '.',

						-- The number of symbols to render top-down. In order to render only 'N' last
						-- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
						-- be used in order to render only current symbol.
						depth = nil,

						-- When 'dense' mode is on, icons are not rendered near their symbols. Only
						-- a single icon that represents the kind of current symbol is rendered at
						-- the beginning of status line.
						dense = false,

						-- The separator to be used to separate symbols in dense mode.
						dense_sep = '.',

						-- Color the symbol icons.
						colored = true,
					} },

					lualine_x = {},
					lualine_y = { 'filesize', },
					lualine_z = {}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {
				},
				winbar = {},
				inactive_winbar = {
				},
				extensions = {}
			}
		end
	},
}
