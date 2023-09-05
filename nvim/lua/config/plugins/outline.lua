return {
	{
		"stevearc/stickybuf.nvim",
		config = function()
			require("stickybuf").setup({
				-- This function is run on BufEnter to determine pinning should be activated
				get_auto_pin = function(bufnr)
					-- You can return "bufnr", "buftype", "filetype", or a custom function to set how the window will be pinned
					-- The function below encompasses the default logic. Inspect the source to see what it does.
					return require("stickybuf").should_auto_pin(bufnr)
				end
			})
		end
	},
	{
		"stevearc/aerial.nvim",
		lazy = false,
		config = function()
			require("aerial").setup({
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set('n', '[[', '<cmd>AerialPrev<CR>', { buffer = bufnr })
					vim.keymap.set('n', ']]', '<cmd>AerialNext<CR>', { buffer = bufnr })
				end
			})
			vim.keymap.set('n', 'tg', '<cmd>AerialToggle<CR>')
		end
	}
}
