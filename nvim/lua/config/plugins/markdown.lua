return {
	{
		"instant-markdown/vim-instant-markdown",
		ft = { "markdown", "vimwiki", },
		build = "yarn install",
		config = function()
			vim.g.instant_markdown_autostart = 1
			vim.cmd([[
				nnoremap <c-p> :silent! InstantMarkdownStop<CR> :InstantMarkdownPreview<CR>
				]])
		end,
	},
	{
		"dhruvasagar/vim-table-mode",
	}
}
