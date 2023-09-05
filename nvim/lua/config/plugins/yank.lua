return {
	{
		"gbprod/yanky.nvim",
		dependencies = {
			"kkharji/sqlite.lua",
		},
		config = function()
			vim.keymap.set("n", "<c-y>", ":Telescope yank_history<CR>")
			-- vim.keymap.set("n", "<c-u>", "<Plug>(YankyCycleForward)")
			-- vim.keymap.set("n", "<c-e>", "<Plug>(YankyCycleBackward)")
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
		end
	},
}
