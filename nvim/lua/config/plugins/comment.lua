return {
	"numToStr/Comment.nvim",
	config = function()
		local api = require("Comment.api")
		vim.keymap.set("n", "<leader><leader>", api.locked("toggle.linewise.current"))
		local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
		vim.keymap.set('x', '<leader><leader>', function()
			vim.api.nvim_feedkeys(esc, 'nx', false)
			api.locked('toggle.linewise')(vim.fn.visualmode())
		end)
		vim.keymap.set('x', '<leader><leader>', function()
			vim.api.nvim_feedkeys(esc, 'nx', false)
			api.locked('toggle.blockwise')(vim.fn.visualmode())
		end)
		require('Comment').setup({
			padding = true,
			sticky = true,
			mappings = {
				basic = false,
				extra = false,
			},
		})
	end
}
