return {
	"voldikss/vim-translator",
	lazy = false,
	event = "VeryLazy",
	priority = 1000,
	config = function()
		vim.cmd([[
nmap <silent> ty :Translate<CR>
vmap <silent> ty :Translate<CR>
" Replace the text with translation
nmap <silent> tr <Plug>TranslateR
vmap <silent> tr <Plug>TranslateRV
let g:translator_window_type = 'preview'
let g:translator_default_engines = ['bing', 'google']
]])
	end,
}
