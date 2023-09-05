return {
	"francoiscabrol/ranger.vim",
	dependencies = {
		"rbgrouleff/bclose.vim",
	},
	-- cmd = "Joshuto",
	config = function()
		kopts = { noremap = true, silent = true }
		-- let g:joshuto_floating_window_winblend = 0
		-- let g:joshuto_floating_window_scaling_factor = 1.0
		-- let g:joshuto_use_neovim_remote = 1 " for neovim-remote support
		vim.g.ranger_map_keys = false
		--[[ vim.g.joshuto_floating_window_scaling_factor = 1.0
		vim.g.joshuto_use_neovim_remote = 1
		vim.g.joshuto_floating_window_winblend = 0 ]]
		vim.keymap.set('n', "tt", "<Cmd>RangerCurrentFileExistingOrNewTab<CR>", kopts)
	end
}
