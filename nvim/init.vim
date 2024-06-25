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
autocmd TabClosed * tabprevious
set laststatus=3
set scrolloff=10
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
set nohidden
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
nnoremap <space>cp :let @*=expand('%:t')<CR>:echo "path copied"<CR>
nnoremap <space>cfp :let @*=expand('%')<CR>:echo "full path copied"<CR>
" fix wrong cursor postion in vim after yanking
vmap y ygv<Esc>
" paste to new line
nnoremap P o<Esc>p

noremap H 0
noremap L $
" jump to end in insert mode
inoremap jk <ESC>
" copy whole line
nnoremap Y y$
nnoremap db dvb
nnoremap cb cvb
nnoremap yb yvb
nnoremap <c-d> 3<c-e>
nnoremap <c-u> 3<c-y>
vnoremap <c-d> 4j
vnoremap <c-u> 4k
" search selection
vnoremap / y/<c-r>0<cr>
map s <nop>
map S :w<CR>
map J <nop>
map ; <nop>
map , <nop>
nmap Q :Sayonara<CR>


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
nnoremap ta :tablast\|:tabnew<CR>
"jump to left side tab
nnoremap <leader><left> :tabp<CR>
nnoremap th :tabp<CR>
"jump to right side tab
nnoremap <leader><right> :tabn<CR>
nnoremap <leader><down> 0i<cr><ESC>
nnoremap <leader><up> kdd
nnoremap tl :tabn<CR>
nnoremap ts :tab split<CR>
nnoremap tn <C-W>T
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

let s:last_list_win_type = 0
function! s:toggle_list()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        exec "lcl"
        let s:last_list_win_type = 1
        return
    endif
    if get(getqflist({'winid':0}), 'winid', 0)
        exec "ccl"
        let s:last_list_win_type = 2
        return
    endif
    if s:last_list_win_type == 1
        exec "lopen"
        return
    endif
    if s:last_list_win_type == 2
        exec "copen"
        return
    endif
endfunction
function! s:next_list()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        exec "lnext"
        return
    endif
    if get(getqflist({'winid':0}), 'winid', 0)
        exec "cnext"
        return
    endif
endfunction
function! s:prev_list()
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        exec "lprev"
        return
    endif
    if get(getqflist({'winid':0}), 'winid', 0)
        exec "cprev"
        return
    endif
endfunction
nnoremap <leader>qq :call <SID>toggle_list()<CR>
nnoremap <leader>nn :call <SID>next_list()<CR>
nnoremap <leader>pp :call <SID>prev_list()<CR>

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

        
    " the location window is open
let g:translator_window_type = 'preview'
let g:translator_default_engines = ['google', 'bing'] 
map <LEADER>k <C-w>k
map <LEADER>h <C-w><left>
map <LEADER>j <C-w><down>
map <LEADER>l <C-w><right>
map <LEADER>Q :qa!<CR>
      
map <LEADER>fs :call ToggleFs()<CR>

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

let s:enabled = 0
function! ToggleFs()
    if s:enabled
        normal <c-w>=
        :exe "norm \<c-w>="
        let s:enabled = 0
    else
        :exe "norm \<c-w>|"
        let s:enabled = 1
    endif
endfunction

call plug#begin('~/.vim/plugged')
" let g:plug_url_format = 'git@github.com:%s.git'
let g:plug_url_format = 'https://git::@github.com/%s.git'
Plug 'itchyny/vim-cursorword'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" copilot
" Plug 'github/copilot.vim'
Plug 'Exafunction/codeium.vim', { 'tag': '1.8.37' }
"


" Pretty Dress
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'

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
Plug 'LukasPietzschmann/telescope-tabs'
Plug 'junegunn/fzf'
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
" Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim',
" Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'


" Taglist
Plug 'liuchengxu/vista.vim'
Plug 'stevearc/aerial.nvim'

" Debugger

" Auto Complete
Plug 'mfussenegger/nvim-jdtls'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'aznhe21/actions-preview.nvim'

" Lint tool

" Snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

"$HOME/.config/nvim/Ultisnips/",
"$HOME/.config/nvim/plugged/vim-snippets/UltiSnips/"

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
Plug 'mhinz/vim-sayonara'
Plug 'petertriho/nvim-scrollbar'
Plug 'kwkarlwang/bufjump.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'azabiong/vim-highlighter'

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
Plug 'kevinhwang91/nvim-bqf' "zf search zn new list <c-q> quit search
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
" colorscheme  PaperColor 

" ==================codeium===================
let g:codeium_no_map_tab = v:true
imap <script><silent><nowait><expr> <C-j> codeium#Accept()
imap <C-c>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-x>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-z>   <Cmd>call codeium#Clear()<CR>
if !empty(glob('~/dellcodeium.vim'))
    source ~/dellcodeium.vim
endif
highlight CodeiumSuggestion guifg=#555555 ctermfg=8



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

    lualine_y = { },
    lualine_z = {'progress', 'encoding', 'fileformat'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {{'branch', fmt = function(str) return str:sub(1,20) end}, 'diff',},
    lualine_c = {  {'filename', path = 3, shorting_target = 60 }},
    lualine_x = {{gps.get_location, cond = gps.is_available, color="Folded"}},

    lualine_y = { },
    lualine_z = {'progress', 'encoding', 'fileformat'}
  },
  tabline = { 
      lualine_a = {{'tabs',tab_max_length = 40, max_length = vim.o.columns*35/36 , use_mode_colors = false, mode=2, path=0}},
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


" === nvim-cmp ===
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF


nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gD :tab sp<CR>:lua vim.lsp.buf.definition()<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gy :lua vim.lsp.buf.type_definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
" nnoremap <leader>fm :lua vim.lsp.buf.format()
xnoremap <leader>fm :lua function() vim.lsp.buf.format({ async = true }) end<CR>
xnoremap <leader>ac :lua require("actions-preview").code_actions()<CR>
nnoremap <leader>ac :lua require("actions-preview").code_actions()<CR>
nnoremap [g :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]g :lua vim.diagnostic.goto_next()<CR>

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
" === nvim-jdtls ===



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
" === vimwiki ====
nnoremap <leader>ww :VimwikiTabIndex<CR>
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

nnoremap <leader>fr :tabnew<CR>:Telescope oldfiles <CR>
nnoremap <leader>fh :Telescope resume <CR>
nnoremap <leader>fb :Telescope telescope-tabs list_tabs<CR>
nnoremap <leader>fw :tabnew<CR>:Telescope live_grep<CR>
nnoremap <leader>fv :tabnew<CR>:lua require('telescope.builtin').live_grep({default_text = " ", search_dirs = { "/root/vimwiki" }})<CR>

nnoremap <leader>ff :tabnew<CR>:Telescope find_files<CR>
nnoremap <leader>ft :Telescope aerial<CR>
nnoremap <leader>f/ :Telescope search_history<CR>


nnoremap <leader>lg :LazyGitCurrentFile<CR>
nnoremap <leader>log :tab split<CR>:Gclog! -5000 -- <left><left><left><left><left><left><left>
"show commit
nnoremap <leader>logd :0Gclog! -5000 -- %<CR>:copen<CR>
"show only file changes
nnoremap <leader>logc :tab Git --paginate log -5000 --patch -- %<CR>
vnoremap <leader>log <ESC>:tab split<CR>gv:Gclog! -5000<CR>:copen<CR>

nnoremap <leader>cga /\.java<CR>
nnoremap <leader>cgj /^(Test)\.java$<CR>
nnoremap <leader>cgt /Test\.java<CR>



" ===
" === vim-bookmarks
" ===
" let g:bookmark_no_default_key_mappings = 1
nmap <leader>ma <Plug>BookmarkToggle
nmap <leader>mt <Plug>BookmarkAnnotate
nmap <leader>ml :BookmarkShowAll<CR>
" nmap mi <Plug>BookmarkNext
" nmap mn <Plug>BookmarkPrev
nmap <leader>mc <Plug>BookmarkClear
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

" === fugitive ===
let g:fugitive_summary_format = "%<(16,trunc)%an||%<(27,trunc)%ad||%s"
nnoremap <leader>rc :Gvdiffsplit!<CR>
" resolve conflict
nnoremap <leader>df :Gvdiffsplit 
" Gvdiffsplit <commitId> <commitId>
" === git blame ===
map <LEADER>bl :Gitsigns blame_line<CR>
vnoremap <leader>bl :Git blame<CR><c-w>T
nnoremap <leader>ge :Gedit :<left>

" === gitsign ===
lua <<EOF
require('gitsigns').setup()
EOF
nnoremap [[ :Gitsign prev_hunk<CR>
nnoremap ]] :Gitsign next_hunk<CR>
nnoremap <leader>u :Gitsign reset_hunk<CR>


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

" au FileType go silent exe "GoGuruScope " . s:go_guru_scope_from_git_root()


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
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
        },
      },
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
	require('telescope').load_extension 'telescope-tabs'
  require('telescope-tabs').setup {
			-- Your custom config :^)
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
    return false
        end,
    win_height = 999,
    win_vheight = 999,

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
" ==================== context ====================
let g:context_add_mappings = 0
"let g:context_presenter= 'preview'
let g:context_enabled = 0
nnoremap <leader>ct :ContextToggleWindow<CR>
" ===================== others ===========================
let g:python3_host_prog = 'python3'
hi String guifg=#11111
set background=light
inoremap jh <ESC>0i
inoremap jl <ESC>A
