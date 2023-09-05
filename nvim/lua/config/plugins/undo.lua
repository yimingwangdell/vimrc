return {
	{
		"mbbill/undotree",
		keys = { "U" },
		config = function()
			vim.cmd([[
noremap U :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> <c-k> <plug>UndotreeNextState
	nmap <buffer> <c-j> <plug>UndotreePreviousState
endfunc]])
		end
	}
}
