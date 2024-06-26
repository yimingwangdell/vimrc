return {
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require('hlslens').setup({
				build_position_cb = function(plist, _, _, _)
					require("scrollbar.handlers.search").handler.show(plist.start_pos)
				end,
			})
			local kopts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap('n', 'n',
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts)
			vim.api.nvim_set_keymap('n', 'N',
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts)
			vim.api.nvim_set_keymap('n', '*', [[*N<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '#', [[#N<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap('n', '<backspace>', '<Cmd>noh<CR>', kopts)
		end
	},
	{
		"pechorin/any-jump.vim",
		config = function()
			vim.keymap.set('n', '<Leader>gd', '<Cmd>AnyJump<CR>', kopts)
			vim.keymap.set('n', '<Leader>gb', "<Cmd>AnyJumpLastResults<CR>", kopts)
			-- vim.keymap.set('n', '<Leader>gi', [[':AnyJumpArg %sImpl' . expand('<cword>')]], kopts)
			vim.keymap.set("n", "<Leader>gi", [[':<C-u>AnyJumpArg ' . expand('<cword>') . 'Impl<CR>']],
				{ noremap = true, silent = false, expr = true })
			vim.g.any_jump_disable_default_keybindings = 1
			vim.g.any_jump_window_width_ratio = 0.9
			vim.g.any_jump_window_height_ratio = 0.9
			vim.cmd([[
au FileType any-jump nnoremap <buffer> <silent> <enter> :call g:AnyJumpHandleOpen('tab')<cr>
]])
		end
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{
				"<leader>F",
				mode = "n",
				function()
					require("spectre").open()
				end,
				desc = "Project find and replace"
			}
		}
	}
}
