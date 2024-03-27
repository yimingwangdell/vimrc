" ===
"
" === Auto load for first time uses
" ===
"silent curl -sL install-node.vercel.app/lts | bash

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" === Terminal Behavimrs
" ===
let g:neoterm_autoscroll = 1
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:syntax_maxlines=999999
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'
syntax sync minlines=999999
autocmd BufEnter * :syntax sync fromstart
set laststatus=3
set synmaxcol=0
set iskeyword+=-
set termguicolors
set noswapfile
set ts=2
set encoding=utf-8
set autoindent
set noautochdir
set expandtab
set shiftwidth=4
set cursorline
set cursorcolumn
set showmatch
set hidden
set nobackup
set nowritebackup
set smartcase
set cmdheight=2
set timeoutlen=400
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


syntax on
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set clipboard+=unnamedplus
    " let g:clipboard = {
    "       \   'name': 'myClipboard',
    "       \   'copy': {
    "       \      '+': ['tmux', 'load-buffer', '-'],
    "       \      '*': ['tmux', 'load-buffer', '-'],
    "       \    },
    "       \   'paste': {
    "       \      '+': ['tmux', 'save-buffer', '-'],
    "       \      '*': ['tmux', 'save-buffer', '-'],
    "       \   },
    "       \   'cache_enabled': 1,
    "       \ }

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
    
set ww+=h,l




" calculate selection
vnoremap <LEADER>c yo<c-r>=<c-r>"<CR>
" copy current file path
nnoremap <leader>cp :let @*=expand('%:t')<CR>:echo "path copied"<CR>
nnoremap <leader>cfp :let @*=expand('%')<CR>:echo "full path copied"<CR>
" fix wrong cursor postion in vim after yanking
vmap y ygv<Esc>
" paste to new line
nnoremap P o<Esc>p

noremap H 0
noremap L $
" jump to end in insert mode
inoremap jk <ESC>
inoremap jl <ESC>A
inoremap jh <ESC>0i
" delete a word backward 
inoremap j<BS> <ESC>bC
" copy whole line
nnoremap Y y$
nnoremap <c-d> 4<c-e>
nnoremap <c-u> 4<c-y>
vnoremap <c-d> 4j
vnoremap <c-u> 4k
" search selection
vnoremap / y/<c-r>0<cr>
map s <nop>
map S :w<CR>
map J <nop>
map ; <nop>
map , <nop>
nmap Q :q<CR>

let mapleader=" "
let maplocalleader=" "


" auto reload vimrc
augroup NVIMRC
    autocmd!
    autocmd BufWritePost init.vim exec ":so %"
augroup END
" split window
map <leader>sl :set nosplitright<CR>:set splitright<CR>:vnew <CR>
map <leader>sv :set nosplitright<CR>:set splitright<CR>:vsplit $MYVIMRC<CR>
map <leader>sj :set nosplitbelow<CR>:set splitbelow<CR>:new <CR>
" resize window
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize+5<CR>
map <right> :vertical resize-5<CR>
" new tab
nnoremap ti :tabnew<CR>
"jump to left side tab
nnoremap th :tabp<CR>
"jump to right side tab
nnoremap tl :tabn<CR>
"jump to N tab
nnoremap t1 :tabn1<CR>
nnoremap t2 :tabn2<CR>
nnoremap t3 :tabn3<CR>
nnoremap t4 :tabn4<CR>
nnoremap t5 :tabn5<CR>
nnoremap t6 :tabn6<CR>
nnoremap t7 :tabn7<CR>
nnoremap t8 :tabn8<CR>
nnoremap t9 :tabn9<CR>
nnoremap t10 :tabn10<CR>
nnoremap t11 :tabn11<CR>
nnoremap t12 :tabn12<CR>
nnoremap t13 :tabn13<CR>
nnoremap t14 :tabn14<CR>
nnoremap t15 :tabn15<CR>
nnoremap t16 :tabn16<CR>
nnoremap t17 :tabn17<CR>
nnoremap t18 :tabn18<CR>
nnoremap t19 :tabn19<CR>
nnoremap t20 :tabn20<CR>
nnoremap t21 :tabn21<CR>
nnoremap t22 :tabn22<CR>
nnoremap t23 :tabn23<CR>
nnoremap t24 :tabn24<CR>
nnoremap t25 :tabn25<CR>
nnoremap t26 :tabn26<CR>
nnoremap t27 :tabn27<CR>
nnoremap t28 :tabn28<CR>
nnoremap t29 :tabn29<CR>
nnoremap t30 :tabn30<CR>
nnoremap t31 :tabn31<CR>
nnoremap t32 :tabn32<CR>
nnoremap t33 :tabn33<CR>
nnoremap t34 :tabn34<CR>
nnoremap t35 :tabn35<CR>


" Display translation in a window
nmap <silent> ty :Translate<CR>
vmap <silent> ty :Translate<CR>
" Replace the text with translation
nmap <silent> tr <Plug>TranslateR
vmap <silent> tr <Plug>TranslateRV
map tw :call <SID>toggle_lang()<CR>
function! s:toggle_lang() 
  if !exists("g:translator_target_lang")
      let g:translator_target_lang = "zh"
  endif

  if g:translator_target_lang == "zh"
      echo "switch g:translator_target_lang to en"
      let g:translator_target_lang = 'en'
  else
      echo "switch g:translator_target_lang to zh"
      let g:translator_target_lang = 'zh'
  endif
endfunction
let g:translator_window_type = 'preview'
let g:translator_default_engines = ['bing', 'google'] 
map <LEADER>k <C-w>k
map <LEADER>h <C-w><left>
map <LEADER>j <C-w><down>
map <LEADER>l <C-w><right>
map <LEADER>Q :qa!
map <LEADER>fs :call MaximizeToggle()<CR>

function! MaximizeToggle()
  if exists("s:maximize_session")
    exec "source " . s:maximize_session
    call delete(s:maximize_session)
    unlet s:maximize_session
    let &hidden=s:maximize_hidden_save
    unlet s:maximize_hidden_save
  else
    let s:maximize_hidden_save = &hidden
    let s:maximize_session = tempname()
    set hidden
    exec "mksession! " . s:maximize_session
    only
  endif
endfunction

call plug#begin('~/.vim/plugged')
" let g:plug_url_format = 'git@github.com:%s.git'
let g:plug_url_format = 'https://git::@github.com/%s.git'
Plug 'itchyny/vim-cursorword'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" copilot
Plug 'github/copilot.vim'
"


" Pretty Dress
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/vim'
Plug 'tomasr/molokai'

" Status line
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'yimingwangdell/nvim-gps'
" General Highlighter

" File navigation
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-telescope/telescope.nvim',
Plug 'junegunn/fzf'
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim',
" Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'


" Taglist
Plug 'liuchengxu/vista.vim'
Plug 'stevearc/aerial.nvim'

" Debugger

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lint tool

" Snippets
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'


" Git
Plug 'tpope/vim-fugitive'
" Plug 'rbong/vim-flog'
Plug 'APZelos/blamer.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'

" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Tex

" CSharp

" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
Plug 'NvChad/nvim-colorizer.lua'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Java
Plug 'uiiaoo/java-syntax.vim'

" Python

" Markdown
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'vimwiki/vimwiki'
Plug 'nvim-neorg/neorg'

" Other filetypes
" Plug ''
"
" Editor Enhancement
Plug 'petertriho/nvim-scrollbar'
Plug 'kwkarlwang/bufjump.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'jiangmiao/auto-pairs'

Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim' "<space><space> to comment a line
Plug 'gbprod/substitute.nvim'
Plug 'machakann/vim-sandwich' "di" to delete inside of ""
Plug 'gcmt/wildfire.vim' "<leader><enter> to select block
    " This selects the next closest text object.
map <LEADER><ENTER> <Plug>(wildfire-fuel)

Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'folke/flash.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'matze/vim-move'
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'theniceboy/pair-maker.vim'

" For general writing

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'


" Documentation
Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
Plug 'dhruvasagar/vim-dotoo'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'wellle/context.vim'
Plug 'talbergs/context.nvim'

" Vim Applications

" Other visual enhancement
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'kevinhwang91/nvim-bqf'
"
"
" Other useful utilities
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc' " vim-session dep
Plug 'voldikss/vim-translator' "ty to translate

" Dependencies


call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme  gruvbox

" ================== copilot ===================
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" ============== lualine =============
lua << EOF
local gps = require("nvim-gps")
require('lualine').setup(
 {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {{'branch', fmt = function(str) return str:sub(1,20) end}, 'diff',},
    lualine_c = {  {'filename', path = 3, shorting_target = 60 }},
    lualine_x = {{gps.get_location, cond = gps.is_available, color="WildMenu"}},

    lualine_y = { {'g:coc_status', fmt= function(str) return str:sub(-30, -1) end, icon = {'', align='left'}}},
    lualine_z = {'progress', 'encoding', 'fileformat'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {{'branch', fmt = function(str) return str:sub(1,20) end}, 'diff',},
    lualine_c = {  {'filename', path = 3, shorting_target = 60 }},
    lualine_x = {{gps.get_location, cond = gps.is_available, color="Folded"}},

    lualine_y = { {'g:coc_status', fmt= function(str) return str:sub(-30, -1) end, icon = {'', align='left'}}},
    lualine_z = {'progress', 'encoding', 'fileformat'}
  },
  tabline = { 
      lualine_a = {{'tabs',tab_max_length = 40, max_length = vim.o.columns*9/10 , use_mode_colors = false, mode=2, path=0}},
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'diagnostics'}},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
)
EOF
" ===
" === coc.nvim
" ===
let g:coc_enable_locationlist=0
set tagfunc=CocTagFunc
let g:coc_global_extensions = ['coc-diagnostic',
	\ 'coc-gitignore',
	\ 'coc-marketplace',
	\ 'coc-html',
	\ 'coc-docker',
	\ 'coc-html',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-go',
	\ 'coc-java',
	\ 'coc-json',
	\ 'coc-protobuf',
	\ 'coc-snippets',
	\ 'coc-yank']

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)








" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
nnoremap gK  :call coc#float#jump()<cr>

	if has('nvim-0.4.0') || has('patch-8.2.0750')
	  nnoremap <silent><nowait><expr> <pagedown> coc#float#has_scroll() ? coc#float#scroll(1) : "\<pagedown>"
	  nnoremap <silent><nowait><expr> <pageup> coc#float#has_scroll() ? coc#float#scroll(0) : "\<pageup>"
	  inoremap <silent><nowait><expr> <pagedown> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	  inoremap <silent><nowait><expr> <pageup> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	  vnoremap <silent><nowait><expr> <pagedown> coc#float#has_scroll() ? coc#float#scroll(1) : "\<pagedown>"
	  vnoremap <silent><nowait><expr> <pageup> coc#float#has_scroll() ? coc#float#scroll(0) : "\<pageup>"
	endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>cod  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>coe  :<C-u>CocList marketplace<cr>
" Show commands
nnoremap <silent><nowait> <space>coc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>coo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>cos  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>con  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>cop  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>col  :<C-u>CocListResume<CR>


let g:snips_author = 'Wang yiming'
let g:snips_email = 'yiming.1.wang@nokia-sbell.com'



lua <<EOF
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
-- You probably also want to set a keymap to toggle aerial
vim.keymap.set("n", "<leader>tg", "<cmd>AerialToggle!<CR><c-w>l")
EOF

nnoremap <leader>, `[V`]<
nnoremap <leader>. `[V`]>


nmap <Leader>m <Plug>ToggleMarkbar

function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" command! -bang -nargs=* Ag
" \ call fzf#vim#ag(<q-args>,
" \                 <bang>0 ? fzf#vim#with_preview('up:60%')
" \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
" \                 <bang>0)
"

" ===
" === vim-instant-markdown
" ===
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1
let g:instant_markdown_browser = "google-chrome-stable --new-window"
nnoremap <c-p> :silent! InstantMarkdownStop<CR> :InstantMarkdownPreview<CR>

" === dotoo ====

" ===
" === orgmode
" ===
lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.completion"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
            },
        },
    },
}
EOF





" === snippets
au BufNewFile,BufRead *.wiki setl ft=markdown
autocmd Filetype markdown,wiki map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown,wiki inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown,wiki inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown,wiki inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
" autocmd Filetype markdown,wiki inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown,wiki inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown,wiki inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown,wiki inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown,wiki inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown,wiki inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown,wiki inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown,wiki inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown,wiki inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown,wiki inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown,wiki inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown,wiki inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown,wiki inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown,wiki inoremap <buffer> ,l --------<Enter>



" ===
" === harpoon
" ===
"
lua <<EOF
local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup()
-- REQUIRED
vim.keymap.set("n", "<leader>aa", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>af", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<c-k>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<c-j>", function() harpoon:list():next() end)
EOF

"=====nvim-tree======
lua <<EOF
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
  on_attach = my_on_attach
})

EOF

"=====telescope======

nnoremap <leader>fr :Telescope oldfiles <CR>
nnoremap <leader>fh :Telescope resume <CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fw :Telescope live_grep<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>ft :Telescope aerial<CR>


nnoremap <leader>lg :LazyGitCurrentFile<CR>
nnoremap <leader>log :Gclog! -5000 -- <CR>:copen<CR>
nnoremap <leader>logd :0Gclog! -5000 -- %<CR>:copen<CR>
nnoremap <leader>logc :Git log -5000 --patch -- %<CR>:copen<CR>
vnoremap <leader>log :Gclog! -5000<CR>:copen<CR>
nnoremap <leader>cga /\.java<CR>
nnoremap <leader>cgj /^(Test)\.java$<CR>
nnoremap <leader>cgt /Test\.java<CR>

" ===
" === CTRLP (Dependency for omnisharp)
" ===
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1


" ===
" === vim-bookmarks
" ===
let g:bookmark_disable_ctrlp = 1
" let g:bookmark_no_default_key_mappings = 1
nmap <leader>ma <Plug>BookmarkToggle
nmap <leader>mt <Plug>BookmarkAnnotate
nmap <leader>ml :CtrlPBookmark<CR>
" nmap mi <Plug>BookmarkNext
" nmap mn <Plug>BookmarkPrev
nmap <leader>mC <Plug>BookmarkClear
" nmap mX <Plug>BookmarkClearAll
" nmap mu <Plug>BookmarkMoveUp
" nmap me <Plug>BookmarkMoveDown
" nmap <Leader>g <Plug>BookmarkMoveToLine
" let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 0
let g:bookmark_save_per_working_dir = 0
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1


" ===
" === zeavim
" ===
let g:zv_zeal_executable = '/home/yimingwang/Downloads/zeal-0.7.0-x86_64.AppImage'
nnoremap <leader>zv :Zeavim<CR>
nnoremap <leader>go :AsyncRun -silent google-chrome-stable "www.bing.com/search?q=""<cword>"<CR>


" ===
" === Undotree
" ===
noremap U :UndotreeToggle<CR>
 let g:undotree_DiffAutoOpen = 1
 let g:undotree_SetFocusWhenToggle = 1
 let g:undotree_ShortIndicators = 1
 let g:undotree_WindowLayout = 2
 let g:undotree_DiffpanelHeight = 8
 let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
    nmap <buffer> <c-j> <plug>UndotreeNextState
    nmap <buffer> <c-k> <plug>UndotreePreviousState
endfunc


" === git blame ===
map <LEADER>bl :Gitsigns blame_line<CR>

" === gitsign ===
lua <<EOF
require('gitsigns').setup()
EOF
nnoremap [[ :Gitsign prev_hunk<CR>
nnoremap ]] :Gitsign next_hunk<CR>

" ===
" === auto-pairs
" ===
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" ==
" == vim-multiple-cursor
" ==


" ===
" === vim-visual-multi
" ===
let g:VM_theme             = 'iceblue'
" let g:VM_default_mappings = 0

" ===
" === vim-sandwich
" ===

runtime macros/sandwich/keymap/surround.vim


" ===
" === Bullets.vim
" ===
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]


" ===
" === vim-go
" ===
autocmd BufWritePre *.go :GoImports
autocmd BufWritePre *.go :GoLint!
" let g:go_gopls_enabled = 0
let g:go_gopls_options = ['-remote=auto']
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 1
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0
function! s:go_guru_scope_from_git_root()
  let gitroot = system("git rev-parse --show-toplevel | tr -d '\n'")
  let pattern = escape(go#util#gopath() . "/src/", '\ /')
  return substitute(gitroot, pattern, "", "") . "/... -vendor/"
endfunction

au FileType go silent exe "GoGuruScope " . s:go_guru_scope_from_git_root()


" ===
" === AutoFormat
" ===
augroup autoformat_settings
	" autocmd FileType bzl AutoFormatBuffer buildifier
	" autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
	" autocmd FileType dart AutoFormatBuffer dartfmt
	" autocmd FileType go AutoFormatBuffer gofmt
	" autocmd FileType gn AutoFormatBuffer gn
	" autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
	" autocmd FileType java AutoFormatBuffer google-java-format
	" autocmd FileType python AutoFormatBuffer yapf
	" Alternative: autocmd FileType python AutoFormatBuffer autopep8
	" autocmd FileType rust AutoFormatBuffer rustfmt
	" autocmd FileType vue AutoFormatBuffer prettier
augroup END





" ===
" === jsx
" ===
let g:vim_jsx_pretty_colorful_config = 1



" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === rainbow
" ===
let g:rainbow_active = 1



" ===
" === vim-session
" ===
let g:session_directory = $HOME."/.config/nvim/tmp/sessions"
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"set sessionoptions-=options
"noremap sl :OpenSession<CR>
"noremap sS :SaveSession<CR>
"noremap ss :SaveSession 
"noremap sc :SaveSession<CR>:CloseSession<CR>:q<CR>
"noremap so :OpenSession default<CR>
"noremap sD :DeleteSession<CR>
""noremap sA :AppendTabSession<CR>


" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%



" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


"nnoremap tt <Cmd>CocCommand explorer<CR>

" nnoremap tt :Fern . -reveal=%<CR>
nnoremap tt :tabnew<cr>:RangerCurrentDirectoryExistingOrNewTab<CR>
nnoremap <leader>e :NvimTreeFindFileToggle<CR>


" ==================== nvim-colorizer.lua ====================
lua <<EOF
require("colorizer").setup {
	filetypes = { "*" },
	user_default_options = {
		RGB = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes
		names = true, -- "Name" codes like Blue or blue
		RRGGBBAA = false, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes
		rgb_fn = false, -- CSS rgb() and rgba() functions
		hsl_fn = false, -- CSS hsl() and hsla() functions
		css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
		-- Available modes for `mode`: foreground, background,  virtualtext
		mode = "virtualtext", -- Set the display mode.
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal
		tailwind = false, -- Enable tailwind colors
		-- parsers can contain values used in |user_default_options|
		sass = { enable = false, parsers = { css }, }, -- Enable sass colors
		virtualtext = "■",
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = {},
}
EOF

" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl


" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['__vim_project_root', '.git/']
let g:rooter_silent_chdir = 1


" ===
" === AsyncRun
" ===


" ===
" === AsyncTasks
" ===
let g:asyncrun_open = 6



" ===
" === tcomment_vim
" " ===
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER><LEADER> gcc<ESC>
vmap <LEADER><LEADER> gcc<ESC>
"nmap <LEADER>cn g>c
"vmap <LEADER>cn g>
"nmap <LEADER>cu g<c
"""vmap <LEADER>cu g<


" === vim-move
" ===

let g:move_key_modifier = '<>'
let g:move_map_keys = 0
"===== indent =====
lua <<EOF
require("ibl").setup()
EOF
" === nvim-rooter
" ===

" ===
" === any-jump
" ===
" nnoremap gr :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.9
let g:any_jump_window_height_ratio = 0.9
nnoremap <leader>gd :AnyJump<CR>
let g:any_jump_grouping_enabled = 1
nnoremap <leader>gb :AnyJumpLastResults<CR>
nnoremap <leader>gi :execute "AnyJumpArg " .. expand("<cword>") .. "Impl"<CR>



"vim.keymap.set('n', '<Leader>gi', [[':AnyJumpArg %sImpl' . expand('<cword>')]], kopts)
"			vim.keymap.set("n", "<Leader>gi", [[':<C-u>AnyJumpArg ' . expand('<cword>') . 'Impl<CR>']],
let g:any_jump_disable_default_keybindings = 1




" " ==================== nvim-scrollbar ====================
lua <<EOF
require("scrollbar").setup()
require("scrollbar.handlers.search").setup()
require("scrollbar").setup({
	show = true,
	handle = {
		text = " ",
		color = "#928374",
		hide_if_all_visible = true,
	},
	marks = {
		Search = { color = "yellow" },
		Misc = { color = "purple" },
	},
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = true,
	},
})
EOF



" ==================== nvim-hlslens ====================
" noremap <silent> = <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
"             \<Cmd>lua require('hlslens').start()<CR>
" noremap <silent> - <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
"             \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>N
noremap # #<Cmd>lua require('hlslens').start()<CR>N
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<cmd>lua require('hlslens').start()<CR>

" ==================== vim-matchup ====================
map { %
map } ]%

" ==================== bufjump ====================

noremap <M-o> :lua require('bufjump').backward()<cr>
noremap <M-i> :lua require('bufjump').forward()<cr>

" ==================== substitute ====================
lua <<EOF
  require("substitute").setup({
    highlight_substituted_text = {
      enabled = true,
      timer = 200,
    },
  })
EOF
noremap s <Cmd>lua require("substitute").operator()<CR>
vnoremap s <Cmd>lua require("substitute").visual()<CR>
" ==================== WhichKey ====================
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" ====================== flash =====================
hi Blue guibg=blue guifg=blue
hi Red guifg=red
lua <<EOF
require("flash").setup({
    char = {
        enabled = false,
    }
})
EOF
noremap ' <Cmd>lua require('flash').jump()<CR>


" ====================== flash =====================

" ====================== flash =====================
let g:indentLine_setColors = 0

" ================telescope==================
lua <<EOF
  require('telescope').setup{
    defaults = {
      layout_strategy = 'vertical',
      layout_config = { height = 0.99, width = 0.99 },
    },
    extensions = {
        aerial = {
          -- Display symbols as <root>.<parent>.<symbol>
          show_nesting = {
            ["_"] = false, -- This key will be the default
            json = true, -- You can set the option for specific filetypes
            yaml = true,
          },
    },
  },
  }
EOF

"===cursorword===
let g:cursorword = 1

" ============== term ================================

lua require("toggleterm").setup()
nnoremap <leader>tm :execute "ToggleTerm dir=" .. expand("%:p:h")<CR>
vnoremap <leader>tm :ToggleTermSendVisualLines<CR>
" ===
" ===
" === vim-table-mode
noremap <LEADER>tb :TableModeToggle<CR>
let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
"
" =================bqf=============================

lua <<EOF
local bqf_pv_timer
require('bqf').setup{
preview = {
    should_preview_cb = function(bufnr, qwinid)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match '^fugitive://' and not vim.api.nvim_buf_is_loaded(bufnr) then
            if bqf_pv_timer and bqf_pv_timer:get_due_in() > 0 then
                bqf_pv_timer:stop()
                bqf_pv_timer = nil
            end
            bqf_pv_timer = vim.defer_fn(function()
                vim.api.nvim_buf_call(bufnr, function()
                    vim.cmd(('do fugitive BufReadCmd %s'):format(bufname))
                end)
                require('bqf.preview.handler').open(qwinid, nil, true)
            end, 60)
        end
        return true
    end
},
 filter = {
        fzf = {
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│'}
        }
    }

}


local fn = vim.fn
local cmd = vim.cmd
local api = vim.api
cmd([[
    aug Coc
        au!
        au User CocLocationsChange lua _G.jumpToLoc()
    aug END
]])

cmd([[
    nmap <silent> gr <Plug>(coc-references)
    nnoremap <silent> <leader>qd <Cmd>lua _G.diagnostic()<CR>
]])

-- just use `_G` prefix as a global function for a demo
-- please use module instead in reality
function _G.jumpToLoc(locs)
    locs = locs or vim.g.coc_jump_locations
    fn.setloclist(0, {}, ' ', {title = 'CocLocationList', items = locs})
    local winid = fn.getloclist(0, {winid = 0}).winid
    if winid == 0 then
        cmd('bel lw')
    else
        api.nvim_set_current_win(winid)
    end
end

function _G.diagnostic()
    fn.CocActionAsync('diagnosticList', '', function(err, res)
        if err == vim.NIL then
            local items = {}
            for _, d in ipairs(res) do
                local text = ('[%s%s] %s'):format((d.source == '' and 'coc.nvim' or d.source),
                    (d.code == vim.NIL and '' or ' ' .. d.code), d.message:match('([^\n]+)\n*'))
                local item = {
                    filename = d.file,
                    lnum = d.lnum,
                    end_lnum = d.end_lnum,
                    col = d.col,
                    end_col = d.end_col,
                    text = text,
                    type = d.severity
                }
                table.insert(items, item)
            end
            fn.setqflist({}, ' ', {title = 'CocDiagnosticList', items = items})

            cmd('bo cope')
        end
    end)
end
EOF
" === treesitter ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        if lang == "java" then
            return true
        end
        local max_filesize = 1000 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
lua <<EOF
require'treesitter-context'.setup{
    enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
    throttle = true, -- Throttles plugin updates (may improve performance)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for', -- These won't appear in the context
            'while',
            'if',
            'switch',
            'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true, 
    }
}
EOF


lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = true,
    },
  },
}
EOF
lua <<EOF
require("nvim-gps").setup()
EOF
let g:context_add_mappings = 0
"let g:context_presenter= 'preview'
let g:context_enabled = 0
nnoremap <leader>ct :ContextToggleWindow<CR>
" ===================== others ===========================
let g:python3_host_prog = 'python3'
hi String guifg=#11111
