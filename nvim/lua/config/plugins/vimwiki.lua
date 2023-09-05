return {
	"vimwiki/vimwiki",
	keys = { "<leader>ww" },
	priority = 1000,
	config = function()
		vim.cmd([[
	let g:instant_markdown_slow = 0
	let g:instant_markdown_autostart = 0
	" let g:instant_markdown_open_to_the_world = 1
	" let g:instant_markdown_allow_unsafe_content = 1
	" let g:instant_markdown_allow_external_content = 0
	" let g:instant_markdown_mathjax = 1
	let g:instant_markdown_autoscroll = 1
	" let g:instant_markdown_browser = "chromium --new-window"
	nnoremap <c-p> :silent! InstantMarkdownStop<CR> :InstantMarkdownPreview<CR>
]])
	end,
}
