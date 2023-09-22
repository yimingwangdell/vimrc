local m = { noremap = true, nowait = true }
local M = {}

M.config = {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = '0.1.1',
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tstabs = require('telescope-tabs')
					tstabs.setup({
					})
					-- vim.keymap.set('n', '<c-k>', tstabs.list_tabs, {})
				end
			},
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			-- "nvim-telescope/telescope-ui-select.nvim",
			'stevearc/dressing.nvim',
			'dimaportenko/telescope-simulators.nvim',
		},
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<c-f>', builtin.find_files, m)
			-- vim.keymap.set('n', '<c-f>', function()
			-- 	builtin.grep_string({ search = "" })
			-- end, m)
			vim.keymap.set('n', '<leader>rs', builtin.resume, m)
			vim.keymap.set('n', '<c-b>', builtin.buffers, m)
			vim.keymap.set('n', '<c-h>', builtin.oldfiles, m)
			vim.keymap.set('n', '<c-_>', builtin.current_buffer_fuzzy_find, m)
			vim.keymap.set('n', '<c-k>', ":Telescope<CR>", m)
			-- vim.keymap.set('n', '<c-k>', tstabs.list_tabs, {})

			-- vim.keymap.set('n', '<leader>d', builtin.diagnostics, m)
			vim.keymap.set("n", ";", builtin.commands, m)

			local trouble = require("trouble.providers.telescope")

			local ts = require('telescope')
			local actions = require('telescope.actions')
			M.ts = ts
			ts.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_config = {
						width = 0.99,
						height = 0.99,
					},
					mappings = {
						i = {
							["<C-w>"] = "which_key",
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
							["<C-h>"] = "preview_scrolling_up",
							["<C-l>"] = "preview_scrolling_down",
							["<esc>"] = "close",
							["<enter>"] = "select_default",
						}
					},
					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					find_files = {
						hidden = true,
						mappings = {
							i = {
								["<enter>"] = "select_tab",
							},
						}
					},
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							},
						}
					},
					live_grep = {
						mappings = {
							i = {
								["<enter>"] = "select_tab",
							},
						}

					}
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					command_palette = command_palette,
				}
			})
			require('dressing').setup({
				select = {
					get_config = function(opts)
						if opts.kind == 'codeaction' then
							return {
								backend = 'telescope',
								telescope = require('telescope.themes').get_cursor()
							}
						end
					end
				}
			})

			ts.load_extension('dap')
			ts.load_extension('telescope-tabs')
			ts.load_extension('fzf')
			ts.load_extension('simulators')
			ts.load_extension("yank_history")

			require("simulators").setup({
				android_emulator = false,
				apple_simulator = true,
			})
			-- ts.load_extension("ui-select")
			-- ts.load_extension("flutter")
			local tsdap = ts.extensions.dap;
			vim.keymap.set("n", "<leader>'v", tsdap.variables, m)
			vim.keymap.set("n", "<leader>'a", tsdap.commands, m)
			vim.keymap.set("n", "<leader>'b", tsdap.list_breakpoints, m)
			vim.keymap.set("n", "<leader>'f", tsdap.frames, m)

			local mapping = require("yanky.telescope.mapping")
			require('yanky').setup({
				ring = {
					history_length = 2000,
					storage = "sqlite",
					sync_with_numbered_registers = true,
					cancel_event = "update",
				},
				picker = {
					select = {
						action = nil, -- nil to use default put action
					},
					telescope = {
						use_default_mappings = false, -- if default mappings should be used
						mappings = {
							i = {
								["<C-w>"] = "which_key",
								["<C-k>"] = "move_selection_previous",
								["<C-j>"] = "move_selection_next",
								["<esc>"] = "close",
								["<enter>"] = mapping.put("p"),
							},
						}, -- nil to use default mappings or no mappings (see `use_default_mappings`)
					},
				},
				system_clipboard = {
					sync_with_ring = true,
				},
				highlight = {
					on_put = true,
					on_yank = true,
					timer = 300,
				},
				preserve_cursor_position = {
					enabled = true,
				},
			})
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter"
		},
		config = function()
			require('nvim-treesitter.configs').setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							['@parameter.outer'] = 'v', -- charwise
							['@function.outer'] = 'V', -- linewise
							['@class.outer'] = '<c-v>', -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = true,
					},
				},
			})
		end

	}
}


return M
