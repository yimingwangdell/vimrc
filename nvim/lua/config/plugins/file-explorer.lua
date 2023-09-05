return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true
		-- vim.keymap.set('n', "tt", "<Cmd>NvimTreeFindFileToggle<CR>", kopts)

		-- empty setup using defaults
		require("nvim-tree").setup()

		-- OR setup with some options
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = {},
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end
}
