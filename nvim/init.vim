"
" ===
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
syntax sync
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
set autochdir
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
set foldmethod=indent
set foldlevel=99
set foldenable
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
vmap y ygv<Esc>

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
    
set ww+=h,l




noremap L $
noremap H 0
nnoremap Y y$

let mapleader=" "


vnoremap / y/<c-r>0<cr>
map s <nop>
map S :w<CR>
nmap Q :q<CR>
augroup NVIMRC
    autocmd!
    autocmd BufWritePost init.vim exec ":so %"
augroup END
map <leader>sl :set nosplitright<CR>:set splitright<CR>:vnew <CR>
map <leader>sv :set nosplitright<CR>:set splitright<CR>:vsplit $MYVIMRC<CR>
map <leader>sj :set nosplitbelow<CR>:set splitbelow<CR>:new <CR> 
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize+5<CR>
map <right> :vertical resize-5<CR>
map ti :tabnew<CR>
map th :tabp<CR>
map tl :tabn<CR>
inoremap <c-a> <ESC>A


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
map <LEADER>fs :call MaximizeToggle()<CR>
map <LEADER>bl :Gitsigns blame_line<CR>

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
Plug 'github/copilot.vim'
Plug 'MunifTanjim/nui.nvim'
Plug 'Bryley/neoai.nvim'
" Plug 'codota/tabnine-nvim', {'do': './dl_binaries.sh'}
"

" Plug 'kevinhwang91/nvim-bqf'
Plug 'romainl/vim-qf'
Plug 'uiiaoo/java-syntax.vim'
" Plug 'andrewstuart/vim-kubernetes'
Plug 'voldikss/vim-translator'


" Pretty Dress
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'

" Status line
" Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

" General Highlighter
" Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" Plug 'RRethy/vim-illuminate'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'lambdalisue/fern.vim'
"Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'ThePrimeagen/harpoon'
Plug 'junegunn/fzf.vim'
" Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension' }
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'kevinhwang91/rnvimr'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim',
Plug 'airblade/vim-rooter'
" Plug 'notjedi/nvim-rooter.lua'
Plug 'pechorin/any-jump.vim'


" Taglist
" Plug 'majutsushi/tagbar'
Plug 'liuchengxu/vista.vim'

" Debugger
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'wellle/tmux-complete.vim'

" Lint tool
" Plug 'dense-analysis/ale'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'


" Git
" Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
" Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive'
" Plug 'rbong/vim-flog'
Plug 'APZelos/blamer.nvim'
" Plug 'mhinz/vim-signify'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'

" Autoformat
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

" Tex
" Plug 'lervag/vimtex'

" CSharp
" Plug 'OmniSharp/omnisharp-vim'

" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
" Plug 'elzr/vim-json'
" Plug 'neoclide/jsonc.vim'
" Plug 'othree/html5.vim'
Plug 'NvChad/nvim-colorizer.lua'
" Plug 'alvan/vim-closetag'
" Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
" Plug 'pantharshit00/vim-prisma'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Python
" Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
" Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
"Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }
" Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'vimwiki/vimwiki'

" Other filetypes
" Plug 'jceb/vim-orgmode', {'for': ['vim-plug', 'org']}
" Plug ''
"
" Editor Enhancement
Plug 'petertriho/nvim-scrollbar'
Plug 'kwkarlwang/bufjump.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'kevinhwang91/nvim-hlslens'
"Plug 'Raimondi/delimitMate'
" Plug 'rstacruz/vim-closer'
" Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'

" Plug 'tmsvg/pear-tree'
Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim' "<space><space> to comment a line
Plug 'gbprod/substitute.nvim'
Plug 'machakann/vim-sandwich' 
" Plug 'tpope/vim-surround' " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word` type S in visualmode
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
    " This selects the next closest text object.
map <LEADER><ENTER> <Plug>(wildfire-fuel)

Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'folke/flash.nvim'
Plug 'rhysd/clever-f.vim'
" Plug 'Konfekt/FastFold'
"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'
" Plug 'svermeulen/vim-subversive'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'matze/vim-move'
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'Yggdroot/indentLine'

Plug 'theniceboy/pair-maker.vim'

" For general writing
" Plug 'junegunn/goyo.vim'
"Plug 'reedes/vim-wordy'
"Plug 'ron89/thesaurus_query.vim'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'


" Documentation
Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
Plug 'nvim-orgmode/orgmode'
Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'mhinz/vim-startify'
Plug 'eckon/treesitter-current-functions'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" Vim Applications

" Other visual enhancement
"Plug 'luochen1990/rainbow'
" Plug 'mg979/vim-xtabline'
Plug 'ryanoasis/vim-devicons'
Plug 'arecarn/vim-crunch'
Plug 'arecarn/vim-selection'
"
"


" Other useful utilities
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
" Plug 'makerj/vim-pdf'
"Plug 'xolox/vim-session'
"Plug 'xolox/vim-misc' " vim-session dep

" Dependencies
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'kana/vim-textobj-user'
" Plug 'roxma/nvim-yarp'






call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme  gruvbox

" ================== copilot ===================
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


" === tabnine ===
"lua <<EOF
"	require('tabnine').setup({
"    accept_keymap = "<right>"
"  })
"EOF
" === lualine === 
lua << END
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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { { 'filename', path = 3, shorting_target = 80, } , {'b:coc_current_function', align='left', shorting_target = 10}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = { 'coc#status'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
)
END
" ===
" === airline.vim
" ===
let g:airline_powerline_fonts = 0
" let g:airline#extensions#tagbar#flags = 'f'
" let g:airline#extensions#tagbar#enabled = 1
" let g:airline#extensions#vista#enabled = 1
let g:airline_section_y = ''
let g:airline_section_a = ''
let g:airline_section_c = '%F'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tagbar#max_filesize = 1000
" let g:airline_extensions = []
 let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
 let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
 let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
 let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
 let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
 let g:airline#extensions#tabline#show_tab_count = 1    " dont show tab numbers on the right                                                           
 let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline                                                 
 let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
 let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
 let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
 let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
" ===
" === coc.nvim
" ===
set tagfunc=CocTagFunc
let g:coc_global_extensions = ['coc-diagnostic',
	\ 'coc-gitignore',
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
autocmd CursorHold * silent call CocActionAsync('highlight')

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
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

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
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>cod  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>coe  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>coc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>coo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>cos  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>coj  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>cok  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>cop  :<C-u>CocListResume<CR>


let g:snips_author = 'Wang yiming'
let g:snips_email = 'yiming.1.wang@nokia-sbell.com'



"tag bar
let g:vista_close_on_jump=0
let g:vista_close_on_fzf_select=0
 let g:vista_default_executive="ctags"
nnoremap  tg :CocOutline<CR>
"nnoremap  <c-t> :Vista finder <CR>
augroup TagBar
    autocmd!
    autocmd FileType tagbar nnoremap <buffer> H <Nop>
    autocmd FileType tagbar nnoremap <buffer> L <Nop>
    autocmd FileType tagbar nnoremap <buffer> t <Nop>
augroup END
augroup Vista
    autocmd!
    autocmd FileType vista nmap <buffer> <c-f> <c-w>h :Vista finder<CR>
augroup END
"let g:ranger_map_keys = 0
let g:tagbar_width = 60
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'dir':s:find_git_root(),'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(s:find_git_root(), fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
   "\ 'enter': 'tab split',
  \ 'ctrl-v': 'vsplit' }

" nnoremap <C-j> :RG<CR>
nnoremap <C-j> :Telescope live_grep<CR>
nnoremap <C-f> :Telescope find_files<CR>
nnoremap <leader>, `[V`]<
nnoremap <leader>. `[V`]>

let g:SimpylFold_docstring_preview = 1

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



" ===
" === orgmode
" ===
lua <<EOF
-- init.lua

-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()
local disable_function = function(lang)
  if lang ~= "org" then
    return true
  end
end

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = disable_function,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
org_agenda_files = '~/orgfiles/**/*',
org_default_notes_file = '~/orgfiles/refile.org',
})
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
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
"
" ===
" === harpoon
" ===
"
lua << EOF
require("harpoon").setup({})
EOF
nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>hm :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <leader>hn :lua require("harpoon.ui").nav_next()<CR>
nnoremap <leader>hp :lua require("harpoon.ui").nav_prev()<CR>
"
" ===
" === FZF
" ===
"noremap <leader>; :History:<CR>
"
let g:fzf_preview_window = 'up:50%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'


let g:fzf_layout = { 'window': { 'width': 1, 'height': 1 } }


" ===
" === Leaderf
" ===
" let g:Lf_WindowPosition = 'popup'
let g:Lf_ShortcutB=''
" nnoremap <c-f> :Leaderf file <CR>
nnoremap <c-h> :Telescope oldfiles <CR>
nnoremap <c-b> :Telescope buffers<CR>
" nnoremap  tg :LeaderfFunction!<CR>
let g:Lf_QuickSelectAction = 'h'
let g:Lf_StlColorscheme = 'gruvbox'
let g:Lf_PreviewInPopup = 1
let g:Lf_ReverseOrder = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_PopupColorscheme = 'gruvbox'
let g:Lf_PopupWidth = 0.75
let g:Lf_WildIgnore = {
        \ 'dir': ['.git', 'vendor', 'node_modules'],
        \ 'file': ['__vim_project_root']
        \}
let g:Lf_UseMemoryCache = 0
let g:Lf_UseCache = 0
""let g:Lf_CommandMap = {'<C-t>': ['<CR>']}
" === gitsigns
lua <<EOF
require('gitsigns').setup({
	signs = {
    add          = { hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '▒', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
})
EOF

" === gitsigns

nnoremap <leader>lg :LazyGit<CR>
nnoremap <leader>log :Gclog! -5000 -- %
vnoremap <leader>log :Gclog! -5000<CR>
nnoremap <leader>cga /+++.*\.java<CR>
nnoremap <leader>cgj /+++.*[^Test]\.java<CR>
nnoremap <leader>cgt /+++.*Test\.java<CR>

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
nmap <leader>ml <Plug>BookmarkShowAll
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
" let g:undotree_DiffAutoOpen = 1
" let g:undotree_SetFocusWhenToggle = 1
" let g:undotree_ShortIndicators = 1
" let g:undotree_WindowLayout = 2
" let g:undotree_DiffpanelHeight = 8
" let g:undotree_SplitWidth = 24
" function g:Undotree_CustomMap()
augroup UndoTree
    autocmd!
    autocmd FileType undotree nmap <buffer> <c-j> <plug>UndotreeNextState
    autocmd FileType undotree nmap <buffer> <c-k> <plug>UndotreePreviousState
augroup END
" 	nmap <buffer> U 5<plug>UndotreeNextState
" 	nmap <buffer> E 5<plug>UndotreePreviousState
" endfunc
"
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
" === vim-scrollstatus
" ===

let g:scrollstatus_size = 15

" ===
" === fzf-gitignore
" ===
noremap <LEADER>gi :FzfGitignore<CR>


" ===
" === Ultisnips
" ===
"let g:tex_flavor = "latex"
"let g:UltiSnipsExpandTrigger="<c-n>"
"let g:UltiSnipsJumpForwardTrigger="<c-p>"
"let g:UltiSnipsJumpBackwardTrigger="<c-n>"
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
" silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
"" Solve extreme insert-mode lag on macOS (by disabling autotrigger)
"augroup ultisnips_no_auto_expansion
"    au!
"    au VimEnter * au! UltiSnips_AutoTrigger
"augroup END



" ===
" === vimtex
" ===
"let g:vimtex_view_method = ''
" let g:vimtex_view_general_viewer = 'llpp'
" let g:vimtex_mappings_enabled = 0
" let g:vimtex_text_obj_enabled = 0
" let g:vimtex_motion_enabled = 0
" let maplocalleader=' '



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
" === OmniSharp
" ===

let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_selector_ui = 'ctrlp'

autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>

sign define OmniSharpCodeActions text=💡

augroup OSCountCodeActions
	autocmd!
	autocmd FileType cs set signcolumn=yes
	autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

function! OSCountCodeActions() abort
	if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
	if !OmniSharp#IsServerRunning() | return | endif
	let opts = {
				\ 'CallbackCount': function('s:CBReturnCount'),
				\ 'CallbackCleanup': {-> execute('sign unplace 99')}
				\}
	call OmniSharp#CountCodeActions(opts)
endfunction

function! s:CBReturnCount(count) abort
	if a:count
		let l = getpos('.')[1]
		let f = expand('%:p')
		execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
	endif
endfunction


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
" noremap ' <Plug>(easymotion-s2)

noremap ' <Plug>(easymotion-overwin-f2)
" nmap ' <Plug>(easymotion-overwin-f2)
"map E <Plug>(easymotion-j)
"map U <Plug>(easymotion-k)
"nmap f <Plug>(easymotion-overwin-f)
"map \; <Plug>(easymotion-prefix)
"nmap ' <Plug>(easymotion-overwin-f2)
"map 'l <Plug>(easymotion-bd-jk)
"nmap 'l <Plug>(easymotion-overwin-line)
"map  'w <Plug>(easymotion-bd-w)
"nmap 'w <Plug>(easymotion-overwin-w)


" ===
" === goyo
" ===
map <LEADER>gy :Goyo<CR>


" ===
" === jsx
" ===
let g:vim_jsx_pretty_colorful_config = 1


" ===
" === fastfold
" ===
" nmap zuz <Plug>(FastFoldUpdate)
" let g:fastfold_savehook = 1
" let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
" let g:markdown_folding = 1
" let g:tex_fold_enabled = 1
" let g:vimsyn_folding = 'af'
" let g:xml_syntax_folding = 1
" let g:javaScript_fold = 1
" let g:sh_fold_enabled= 7
" let g:ruby_fold = 1
" let g:perl_fold = 1
" let g:perl_fold_blocks = 1
" let g:r_syntax_folding = 1
" let g:rust_fold = 1
" let g:php_folding = 1


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>


" ===
" === vim-session
" ===
"let g:session_directory = $HOME."/.config/nvim/tmp/sessions"
"let g:session_autosave = 'no'
"let g:session_autoload = 'no'
"set sessionoptions-=options
"noremap sl :OpenSession<CR>
"noremap sS :SaveSession<CR>
"noremap ss :SaveSession 
"noremap sc :SaveSession<CR>:CloseSession<CR>:q<CR>
"noremap so :OpenSession default<CR>
"noremap sD :DeleteSession<CR>
""noremap sA :AppendTabSession<CR>


" ===
" === context.vim
" ===
"let g:context_add_mappings = 0
"noremap <leader>ct :ContextToggle<CR>


" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%


" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
" noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ===
" === reply.vim
" ===
"noremap <LEADER>rp :w<CR>:Repl<CR><C-\><C-N><C-w><C-h>
"noremap <LEADER>rs :ReplSend<CR><C-w><C-l>a<CR><C-\><C-N><C-w><C-h>
"noremap <LEADER>rt :ReplStop<CR>


" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

"nnoremap tt <Cmd>CocCommand explorer<CR>

" nnoremap tt :Fern . -reveal=%<CR>
nnoremap tt :RangerCurrentFileExistingOrNewTab<CR>
nnoremap <leader>ex :CocCommand explorer<CR>
nnoremap <leader>f <nop>



" ===
" === vim-subversive
" ===
nmap s <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)

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

" ===
" === vim-surround
" ===

" === vim-move
" ===
"
" === nvim-rooter
" ===

" ===
" === any-jump
" ===
" nnoremap gr :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.9
let g:any_jump_window_height_ratio = 0.9
let g:any_jump_grouping_enabled = 1
nnoremap <leader>gd :AnyJump<CR>
nnoremap <leader>gb :AnyJumpLastResults<CR>
nnoremap <leader>gi :execute "AnyJumpArg " .. expand("<cword>") .. "Impl"<CR>



"vim.keymap.set('n', '<Leader>gi', [[':AnyJumpArg %sImpl' . expand('<cword>')]], kopts)
"			vim.keymap.set("n", "<Leader>gi", [[':<C-u>AnyJumpArg ' . expand('<cword>') . 'Impl<CR>']],
let g:any_jump_disable_default_keybindings = 1



" ===
" === typescript-vim
" ===
let g:typescript_ignore_browserwords = 1


" ===
" === Agit
" ===
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1



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

" ===================== minimap =====================t

let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1

" ===================== gtags =============================
let g:Gtags_No_Auto_Jump = 1
let g:Gtags_Close_When_Single = 0

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
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" ====================== flash =====================
let g:indentLine_setColors = 0

" ================telescope==================
lua <<EOF
  require('telescope').setup{
    defaults = {
      layout_strategy = 'vertical',
      layout_config = { height = 0.99, width = 0.99 },
    },
  }
EOF
" ===================== others ===========================
let g:python3_host_prog = 'python3'
noremap acm O==========================<CR>==========================<ESC>ko
