return {
	-- "theniceboy/nvim-deus",
	"morhetz/gruvbox",
	lazy = false,
	priority = 1000,
	config = function()
		-- vim.cmd([[colorscheme deus]])
		vim.cmd([[colorscheme gruvbox]])
	end,
}
