" ==
"
" === Auto load for first time uses
" ===
"silent curl -sL install-node.vercel.app/lts | bash

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd!
    autocmd CursorMoved * call ShowFugitiveFileName()

augroup END
augroup PreserveNoEOL
  autocmd!
  " Before write: if buffer is currently marked as no end-of-line, preserve it
  autocmd BufWritePre * if !&l:endofline | let b:__save_bin=&l:binary | let b:__save_eol=&l:endofline | setlocal binary noeol | endif
  " After write: restore options if we changed them
  autocmd BufWritePost * if exists('b:__save_bin') | let &l:binary=b:__save_bin | let &l:endofline=b:__save_eol | unlet b:__save_bin b:__save_eol | endif
augroup END


let s:prevtabnum=tabpagenr('$')
augroup TabClosed
    autocmd! TabEnter * :if tabpagenr('$')<s:prevtabnum && tabpagenr()>1
                \       |   tabprevious
                \       |endif
                \       |let s:prevtabnum=tabpagenr('$')
augroup END

" let g:syntax_maxlines=999999
" syntax sync minlines=999999
" autocmd BufEnter * :syntax sync fromstart
:lua vim.lsp.inlay_hint.enable(false)
set laststatus=3
set scrolloff=10
set synmaxcol=0
set iskeyword+=-
set termguicolors
set noswapfile
set hidden
set ts=2
set encoding=utf-8
set autoindent
set noautochdir
set expandtab
set shiftwidth=4
set cursorline
set showmatch
set nobackup
set nowritebackup
set smartcase
set cmdheight=2
set timeoutlen=800
set updatetime=300
set shortmess+=c
set signcolumn=yes


set nocompatible
filetype plugin on
syntax on
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set clipboard+=unnamedplus

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
    
set ww+=h,l
set list
set listchars=eol:↓,tab:\ \ ┊,trail:●,extends:…,precedes:…,space:·


let mapleader=" "
let maplocalleader=" "

" calculate selected
vnoremap <LEADER>c yo<c-r>=<c-r>"<CR>
" copy current file path
nnoremap <space>cp :let @*=expand('%:t')<CR>:echo "path copied"<CR>
nnoremap <space>cfp :let @*=expand('%')<CR>:echo "full path copied"<CR>
" set number in each V selected lines from 0, 1, 2...
xnoremap <silent> <leader>in0 :<C-u>'<,'>s/\d\+\ze\D*$/\=line('.')-line("'<")/<CR>:noh<CR>
" start from 1
xnoremap <silent> <leader>in1 :<C-u>'<,'>s/\d\+\ze\D*$/\=line('.')-line("'<")+1/<CR>:noh<CR>

" paste to new line
function! Pcol(...) abort
  let above = get(a:, 1, 0)
  let col = virtcol('.')
  execute 'normal!' above ? 'P' : 'p'
  call cursor('.', col)
endfunction

" jump to head and tail
nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
nnoremap j gj
nnoremap k gk
inoremap jk <ESC>
inoremap jh <ESC>^i
inoremap jl <ESC>A
inoremap jj <ESC>o
" copy to end
nnoremap Y y$
" b include current char
nnoremap db dvb
nnoremap cb cvb
nnoremap yb yvb
nnoremap <leader><down> 0i<cr><ESC>
nnoremap <leader><up> kdd
nnoremap = :noh<CR>
" scroll up and down
" nnoremap <c-d> 4j
" nnoremap <c-u> 4k
" vnoremap <c-d> 4j
" vnoremap <c-u> 4k
" search selected
nnoremap <silent> n <Cmd>execute('keepjumps normal! ' . v:count1 . 'n')<CR>
nnoremap <silent> N <Cmd>execute('keepjumps normal! ' . v:count1 . 'N')<CR>
nnoremap S :w<CR>
" nmap Q :call QuitWithQuickfixCheck()<CR>
nnoremap Q :Sayonara<CR>
function! QuitWithQuickfixCheck()
    if get(getqflist({'winid':0}), 'winid', 0)
        :cclose
        :Sayonara<CR>
    else
        :Sayonara<CR>
    endif
endfunction
nnoremap <LEADER>Q :qa!<CR>

" jump split window




" auto reload vimrc
augroup NVIMRC
    autocmd!
    autocmd BufWritePost init.vim exec ":so %"
augroup END
" split window
map <leader>sl :set nosplitright<CR>:set splitright<CR>:vnew<CR><c-w>l
map <leader>sv :set nosplitright<CR>:set splitright<CR>:vsplit $MYVIMRC<CR>
map <leader>st :set nosplitright<CR>:set splitright<CR>:vsplit ~/vimwiki/TODO.wiki<CR>
map <leader>sj :set nosplitbelow<CR>:set splitbelow<CR>:new<CR><c-w>j
" jump down/up/left/right split window
" quit vim
" resize window
" move pasted content indent to left/right
nnoremap <leader>, `[V`]<
nnoremap <leader>. `[V`]>
" new tab before current
nnoremap ti :-tabnew<CR>
" new tab after current
nnoremap ta :tabnew<CR>
" new tab after first tab
nnoremap tI :0tabnew<CR>
" new tab after last tab
nnoremap tA :$tabnew<CR>
"jump to left side tab
nnoremap <leader><left> :tabp<CR>
nnoremap th :tabp<CR>
nnoremap tH :tabfirst<CR>
"jump to right side tab
nnoremap <leader><right> :tabn<CR>
nnoremap tl :tabn<CR>
nnoremap tL :tablast<CR>
" duplicate current tab
nnoremap ts :tab split<CR>
" move current win to new tab
nnoremap tfs <C-W>T
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
function! EnsureTabExists(num)
  let l:current_tab = tabpagenr()
  if tabpagenr('$') < a:num
    tabnew
    execute 'tabnext ' . l:current_tab
  endif
endfunction

function! s:printGitFileName()
    " Get the current line
    let l:p = searchpos('^[A-Z?] .\|^diff --', 'bnW')
    let l:gitkeyline = getline(l:p[0])

    " Extract the filename using a regular expression
    " This assumes the format: diff --git a/.../filename b/.../filename
    let l:match = matchlist(l:gitkeyline, 'diff --git a/.*\/\([^\/]*\) b/')

    " Print the filename if matched
    if len(l:match) > 1
        echo "viewing file:" . l:match[1]
    else
        echo ""
    endif

endfunction

function! ShowFugitiveFileName()
    " Get the current buffer name
    let l:bufname = expand('%')

    " Check if it's a Fugitive buffer
    if l:bufname =~# '^fugitive://'
        " Extract the filename from the path
        call s:printGitFileName()
    else
        " :echo expand('%') | redraw
    endif
endfunction




" Optional: bind to a key
nnoremap <leader>t2 :call EnsureTabExists(2)<CR>
nnoremap <leader>t3 :call EnsureTabExists(3)<CR>
nnoremap <leader>t4 :call EnsureTabExists(4)<CR>
nnoremap <leader>t5 :call EnsureTabExists(5)<CR>



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
" keymap for quick list/location list
nnoremap <leader>qq :call <SID>toggle_list()<CR>
nnoremap <leader>nn :call <SID>next_list()<CR>
nnoremap <leader>pp :call <SID>prev_list()<CR>

" delete all background buffers
nnoremap <leader>db :DeleteHiddenBuffers<CR>

" === vim-translator ===
" translation current word
nmap <silent> ty :Translate<CR>
" translation selected word
vmap <silent> ty :Translate<CR>
" Replace the text with translation
nmap <silent> tr <Plug>TranslateR
vmap <silent> tr <Plug>TranslateRV
" switch language
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
let g:translator_default_engines = ['google', 'bing'] 
      
" toggle full screen for splited window
map <LEADER>fs :call ToggleFs()<CR>


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

" copilot
" Plug 'github/copilot.vim'
Plug 'Exafunction/windsurf.vim'
" chatgpt chat
Plug 'MunifTanjim/nui.nvim'
Plug 'jackMort/ChatGPT.nvim'
"Plug 'olimorris/codecompanion.nvim'


" Pretty Dress
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'overcache/NeoSolarized'
Plug 'doums/darcula'
Plug 'rebelot/kanagawa.nvim'
Plug 'catppuccin/vim'
Plug 'folke/tokyonight.nvim'

" Status line
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'
Plug 'yimingwangdell/nvim-gps'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
" General Highlighter

" File navigation
Plug 'nvim-telescope/telescope.nvim',
Plug 'LukasPietzschmann/telescope-tabs'
Plug 'StefanBartl/telescope-selected-index'
Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
Plug 'nvim-tree/nvim-tree.lua'
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}
Plug 'pechorin/any-jump.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'


" Outline
Plug 'stevearc/aerial.nvim', {'tag': 'nvim-0.9'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'tag': 'v0.10.0'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'


" LSP
Plug 'mfussenegger/nvim-jdtls'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}
Plug 'Saghen/blink.cmp'
" Plug 'ray-x/lsp_signature.nvim', {'branch': 'nvim-0.9'}


Plug 'folke/trouble.nvim'


" Snippets
Plug 'rafamadriz/friendly-snippets'


" Undo Tree
Plug 'mbbill/undotree'


" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'sindrets/diffview.nvim'


" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Java
Plug 'uiiaoo/java-syntax.vim'
"string color
hi String guifg=#11111


" Markdown
Plug 'dkarter/bullets.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'vimwiki/vimwiki' " best note taking tool
Plug 'nvim-orgmode/orgmode', {'tag': '0.6.0'}

"
" Editor Enhancement
Plug 'mhinz/vim-sayonara' " enhanced quit
Plug 'kevinhwang91/nvim-bqf' " quickfix zf search, zn new list <c-q> quit search
Plug 'romainl/vim-qf'
Plug 'junegunn/fzf'
Plug 'karunsiri/vim-delete-hidden-buffers'
Plug 'kwkarlwang/bufjump.nvim' "<M-o> jump back file
" Plug 'itchyny/vim-cursorword' " highlight current word
Plug 'RRethy/vim-illuminate'
Plug 'nvimtools/hydra.nvim'
Plug 'smoka7/multicursors.nvim'
Plug 'tomtom/tcomment_vim' " <space><space> to comment a line
Plug 'gbprod/substitute.nvim' " s to substitute
Plug 'machakann/vim-sandwich' " di" to delete inside of ""

Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'folke/flash.nvim' " best jump plugin
" Plug 'nvimdev/indentmini.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'matze/vim-move'
Plug 'windwp/nvim-autopairs'
Plug 'theniceboy/pair-maker.vim'
Plug 'kevinhwang91/nvim-hlslens'
" Plug 'karb94/neoscroll.nvim'


" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Windows management
Plug 'sindrets/winshift.nvim'


" Code Context
Plug 'wellle/context.vim'

" Other visual enhancement
Plug 'hiphish/rainbow-delimiters.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'azabiong/vim-highlighter'
"
"
" Other useful utilities
Plug 'lambdalisue/suda.vim' " :SudaWrite to write as root
Plug 'yimingwangdell/vim-translator' " ty to translate
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'} " open terminal in vim





call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" colorscheme  tokyonight-moon
colorscheme gruvbox
" colorscheme kanagawa-dragon
set background=dark
" set background=light

" ==================codeium===================
let g:codeium_no_map_tab = v:true
let g:codeium_workspace_root_hints = ['.bzr','.git','.hg','.svn','_FOSSIL_','package.json']

imap <script><silent><nowait><expr> <C-o> codeium#Accept()
imap <C-c>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-z>   <Cmd>call codeium#Clear()<CR>
if !empty(glob('~/dellcodeium.vim'))
    source ~/dellcodeium.vim
endif
highlight CodeiumSuggestion guifg=#555555 ctermfg=8
highlight link GitSignsCurrentLineBlame DiffAdd


" ==================chatgpt===================
lua <<EOF
require("chatgpt").setup({
openai_params = {
        -- NOTE: model can be a function returning the model name
        -- this is useful if you want to change the model on the fly
        -- using commands
        -- Example:
        -- model = function()
        --     if some_condition() then
        --         return "gpt-4-1106-preview"
        --     else
        --         return "gpt-3.5-turbo"
        --     end
        -- end,
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      }
})
EOF

nnoremap <leader>gpt :ChatGPT<CR>
" nnoremap <leader>gpt :Codeium Chat<CR>


" === codecompanion ===
" lua << EOF
"   require("codecompanion").setup()
" EOF


" ============== lualine =============
lua << EOF
local gps = require("nvim-gps")
require('lualine').setup(
 {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 10,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {{'branch', fmt = function(str) return str:sub(1,20) end}, 'diff',},
    lualine_c = {  {'filename', path = 0,   }},
    lualine_x = {{gps.get_location, cond = gps.is_available, color="WildMenu"}},
    lualine_y = {},
    lualine_z = {'filesize', 'progress', 'encoding', 'fileformat'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {{'branch', }, 'diff',},
    lualine_c = {  {'filename', path = 0,}},
    lualine_x = {},
    lualine_x = {{gps.get_location, cond = gps.is_available, color="Folded"}},

    lualine_y = { },
    lualine_z = {'progress', 'encoding', 'fileformat'}
  },
  tabline = { 
      lualine_a = {{'filename', path=3, shorting_target=15}},
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


lua<<EOF
require("blink.cmp").setup(
{
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    signature = { enabled = true,
         trigger = {
              enabled = false,
             -- Show the signature help window after typing any of alphanumerics, `-` or `_`
             show_on_keyword = true,
             blocked_trigger_characters = {},
             blocked_retrigger_characters = {},
             -- Show the signature help window after typing a trigger character
             show_on_trigger_character = true,
             -- Show the signature help window when entering insert mode
             show_on_insert = true,
             -- Show the signature help window when the cursor comes after a trigger character when entering insert mode
             show_on_insert_on_trigger_character = true,
         },
    },
    keymap = {
        preset = "none",
        ['<Tab>'] = {function(cmp)
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            if (cmp.snippet_active()) then
                return cmp.hide()
            else
                if (col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil) then
                    cmp.show({providers = { 'lsp', 'path', 'snippets', 'buffer' }})
                    cmp.show_documentation()
                else
                    return '\t'
                end
            end

        end, 'snippet_forward'},
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-k>'] = { 'show_signature'},
        ['<C-space>'] = { function(cmp)
            cmp.show({providers = { 'lsp', 'path', 'snippets', 'buffer' }})
        end, 'show_documentation', 'hide_documentation'},
        ['<Enter>'] = { 'select_and_accept', 'fallback_to_mappings' },
        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
        trigger = {
            prefetch_on_insert = false,
            show_on_backspace_after_accept = false,
            show_on_backspace_after_insert_enter = false,
            show_on_backspace_after_accept = false,
            show_on_keyword = true,
            show_on_trigger_character = false,
            show_on_blocked_trigger_characters = {' ', '\n', '\t'},
            show_on_accept_on_trigger_character = false,
            show_on_insert_on_trigger_character = false,
        },
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
      },


    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'buffer', 'snippets', 'path' },
      providers = {
        buffer = {
         module = 'blink.cmp.sources.buffer',
         score_offset = -3,
         opts = {
           -- default to all visible buffers
           get_bufnrs = function()
             return vim
               .iter(vim.api.nvim_list_wins())
               :map(function(win) return vim.api.nvim_win_get_buf(win) end)
               :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
               :totable()
           end,
           -- buffers when searching with `/` or `?`
           get_search_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
           -- Maximum total number of characters (in an individual buffer) for which buffer completion runs synchronously. Above this, asynchronous processing is used.
           max_sync_buffer_size = 400000,
           -- Maximum total number of characters (in an individual buffer) for which buffer completion runs asynchronously. Above this, the buffer will be skipped.
           max_async_buffer_size = 4000000,
           -- Maximum text size across all buffers (default: 500KB)
           max_total_buffer_size = 10000000,
           -- Order in which buffers are retained for completion, up to the max total size limit (see above)
           retention_order = { 'focused', 'visible', 'recency', 'largest' },
           -- Cache words for each buffer which increases memory usage but drastically reduces cpu usage. Memory usage depends on the size of the buffers from `get_bufnrs`. For 100k items, it will use ~20MBs of memory. Invalidated and refreshed whenever the buffer content is modified.
           use_cache = true,
           -- Whether to enable buffer source in substitute (:s), global (:g) and grep commands (:grep, :vimgrep, etc.).
           -- Note: Enabling this option will temporarily disable Neovim's 'inccommand' feature
           -- while editing Ex commands, due to a known redraw issue (see neovim/neovim#9783).
           -- This means you will lose live substitution previews when using :s, :smagic, or :snomagic
           -- while buffer completions are active.
           enable_in_ex_commands = false,
         }
       },

      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "lua" }
  }
)
EOF
lua<<EOF

  -- Set up lspconfig.
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['bashls'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['clangd'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['jsonls'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['lemminx'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['yamlls'].setup {
        capabilities = capabilities,
  }
  require('lspconfig')['lua_ls'].setup {
        capabilities = capabilities,
  }
EOF
"
"=== lsp_signature ===
"
"lua<<EOF
"     require "lsp_signature".setup()
"EOF


" === mason ===
lua<<EOF
 require("mason").setup()
EOF

" === trouble ===
lua<<EOF
 require("trouble").setup()
EOF

nnoremap <leader>dd :Trouble diagnostics toggle filter.buf=0<CR>
nnoremap <leader>gr :Trouble lsp toggle focus=false<CR>

" === aerial ===
" <leader>tg to show Outline (tags)
lua <<EOF
require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      backends = { "treesitter" },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
  disable_max_lines = 30000,
  layout={
    min_width = 60
  }

})
vim.keymap.set("n", "<leader>tg", "<cmd>AerialToggle!<CR><c-w>l")
vim.keymap.set("n", "<leader>nv", "<cmd>AerialNavToggle<CR>")
EOF


" === treesitter ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader><enter>", -- set to `false` to disable one of the mappings
      node_incremental = "<leader><enter>",
      scope_incremental = false,
      node_decremental = false,
    },
  },
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

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
    disable = { "c", "rust"},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
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
        ['@function.outer'] = 'v', -- linewise
        ['@class.outer'] = 'v', -- blockwise
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
      include_surrounding_whitespace = false,
    },
  },
}
EOF
lua <<EOF
require("nvim-gps").setup()
EOF


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

" ===
" ===
" === vim-table-mode
noremap <LEADER>tb :TableModeToggle<CR>
let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" === vimwiki ====
nnoremap <leader>ww :VimwikiTabIndex<CR>
" ===
" === orgmode
" cit change state
lua << EOF

require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

EOF
" ===



" === markdown snippets
" au BufNewFile,BufRead *.wiki setl ft=markdown
autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown inoremap <buffer> <c-e> <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
" autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype vimwiki inoremap <buffer> ,b ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype vimwiki inoremap <buffer> ,s ~~ <++><Esc>F~i
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype vimwiki inoremap <buffer> ,i __ <++><Esc>F_i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> ,1 =<Space><Space>=<Enter><++><Esc>khi
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> ,2 ==<Space><Space>==<Enter><++><Esc>ki
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> ,3 ===<Space><Space>===<Enter><++><Esc>kli
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype vimwiki inoremap <buffer> ,4 ====<Space><Space>====<Enter><++><Esc>klli
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>
autocmd Filetype vimwiki inoremap <buffer> ,t [ ] <++><Esc>F]la



" ===
" === harpoon
" ===
"
lua <<EOF
local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup()
-- REQUIRED
vim.keymap.set("n", "<leader>aa", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>af", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>ad", function() harpoon:list():clear() end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>k", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>j", function() harpoon:list():next() end)
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
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
  on_attach = my_on_attach
})

EOF

"=====telescope======
"
"
" search recent files
nnoremap <leader>fr :Telescope oldfiles <CR>
nnoremap <leader>fh :Telescope resume <CR>
" nnoremap <leader>fb :Telescope telescope-tabs list_tabs<CR>
nnoremap <leader>fb :Telescope buffers<CR>
 "search word
" nnoremap <leader>fw :Telescope live_grep<CR>
" nnoremap <leader>fw :Telescope egrepify<CR>

" nnoremap <leader>fv :lua require('telescope.builtin').live_grep({default_text = " ", search_dirs = { "/root/vimwiki" }})<CR>
" search files
nnoremap <leader>ff :Telescope find_files<CR>
" search symbols in current file
nnoremap <leader>ft :Telescope aerial<CR>
nnoremap <leader>f/ :Telescope search_history<CR>
nnoremap <leader>f: :Telescope command_history<CR>
function! SearchProtoBuf()
    let l:current_file = expand('%:t:r')  " Get the current file name

    lua require('bufjump').backward()
    execute 'Telescope find_files default_text=' . l:current_file . ".proto"

endfunction
function! SearchUTfile()
    let l:current_file = expand('%:t:r')  " Get the current file name

    lua require('bufjump').backward()
    execute 'Telescope find_files default_text=' . l:current_file . "Test"

endfunction
function! SearchCurrentFile()
    let l:current_file = expand('%')  " Get the current file name
    " echo l:current_file
    let l:current_line = line('.')
    let l:pos = getpos('.')
    call EnsureTabExists(2)
    " execute 'Telescope find_files default_text=' . l:current_file
    " call feedkeys("\<CR>", "x")
    let path = substitute(l:current_file, 'diffview:\/\/', '', '')
    let path = substitute(path, '\.git/\x\+/', '', '')
    execute 'tabnext'
    execute 'edit ' . path
    call setpos('.', l:pos)
endfunction
nnoremap <leader>fp :call SearchProtoBuf()<CR>
nnoremap <leader>fc :call SearchCurrentFile()<CR>
nnoremap <leader>fu :call SearchUTfile()<CR>


" === lazygit ===
nnoremap <leader>lg :LazyGitCurrentFile<CR>



" === diffview



lua <<EOF
-- Lua
local actions = require("diffview.actions")

require("diffview").setup({
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
  git_cmd = { "git" },      -- The git executable followed by default args.
  hg_cmd = { "hg" },        -- The hg executable followed by default args.
  use_icons = true,         -- Requires nvim-web-devicons
  show_help_hints = true,   -- Show hints for how to open the help panel
  watch_index = true,       -- Update views and index buffers when the git index changes.
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see |diffview-config-view.x.layout|.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_horizontal",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_horizontal",
      disable_diagnostics = true,   -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = true,           -- See |diffview-config-view.x.winbar_info|
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_horizontal",
      disable_diagnostics = false,  -- Temporarily disable diagnostics for diff buffers while in the view.
      winbar_info = false,          -- See |diffview-config-view.x.winbar_info|
    },
  },
  file_panel = {
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = {                      -- See |diffview-config-win_config|
      position = "bottom",
      width = 35,
      height = 10,
      win_opts = {},
    },
  },
  file_history_panel = {
    log_options = {   -- See |diffview-config-log_options|
      git = {
        single_file = {
          diff_merges = "combined",
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      },
      hg = {
        single_file = {},
        multi_file = {},
      },
    },
    win_config = {    -- See |diffview-config-win_config|
      position = "bottom",
      height = 16,
      win_opts = {},
    },
  },
  commit_log_panel = {
    win_config = {},  -- See |diffview-config-win_config|
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See |diffview-config-hooks|
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    view = {
      -- The `view` bindings are active in the diff buffers, only when the current
      -- tabpage is a Diffview.
      { "n", "<leader>nn",       actions.select_next_entry,              { desc = "Open the diff for the next file" } },
      { "n", "<leader>pp",     actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
    },
  },
})
EOF
" ===
" === vim-bookmarks
" ===
" let g:bookmark_no_default_key_mappings = 1
nmap <leader>ma <Plug>BookmarkToggle
nmap <leader>mt <Plug>BookmarkAnnotate
nmap <leader>ml :BookmarkShowAll<CR>
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
    nmap <buffer> <c-k> <plug>UndotreeNextState
    nmap <buffer> <c-j> <plug>UndotreePreviousState
endfunc

" === fugitive ===
let g:fugitive_summary_format = "%<(16,trunc)%an||%<(27,trunc)%ad||%s"
nnoremap <leader>rc :Gvdiffsplit!<CR>
" start to resolve conflicts in project
nnoremap <leader>df :G diff
nnoremap <leader>dfv :DiffViewOpen
" Gvdiffsplit <commitId> <commitId>
" === git blame ===
map <LEADER>bl V:Git blame<CR>
vnoremap <leader>bl :Git blame<CR>
" view file with commit id :Gedit <commitId>:<file>
nnoremap <leader>ge :Gedit <commitid>:<file>
" git log
nnoremap <leader>log :call <SID>log()<CR>

"current file log with related commits
nnoremap <leader>logd :0Gclog! -5000 -- %<CR>:copen<CR>
"current file log with only current file changes
nnoremap <leader>logcc :Git --paginate log -500 --patch  -- %
nnoremap <leader>logc :call <SID>logc()<CR>
function! s:LoadMoreCommits() abort
    if s:logenabled == 1
        let s:logindex += 500
        execute 'Gclog! -500 --skip='.s:logindex
    endif
    if s:logcenabled == 1
        let s:logcindex += 500
        execute 'Gclog! -500 --skip='.s:logcindex' -- %'
    endif
endfunction
function! s:LoadLessCommits() abort
    if s:logenabled == 1
        let s:logindex -= 500
        if s:logindex < 0
            let s:logindex = 0
        endif
        execute 'Gclog! -500 --skip='.s:logindex
    endif
    if s:logcenabled == 1
        let s:logcindex -= 500
        if s:logcindex < 0
            let s:logcindex = 0
        endif
        execute 'Gclog! -500 --skip='.s:logcindex' -- %'
    endif
endfunction
function! s:log() abort
    let s:logindex = 0
    let s:logenabled = 1
    let s:logcenabled = 0
    execute ':Gclog! -500 --'
endfunction

function! s:logc() abort
    let s:logcindex = 0
    let s:logenabled = 0
    let s:logcenabled = 1
    execute 'Gclog! -500 -- %'
endfunction
command! -nargs=? GMore call <SID>LoadMoreCommits()
command! -nargs=? GLess call <SID>LoadLessCommits()
nnoremap <leader>ln :GMore<CR>
nnoremap <leader>lp :GLess<CR>

" selected lines log
vnoremap <leader>log <ESC>:-tabnew<CR>gv:Gclog! -5000<CR>:copen<CR>


" === gitsign ===
lua <<EOF
require('gitsigns').setup({ current_line_blame = true })
EOF
nnoremap [[ :Gitsign prev_hunk<CR>
nnoremap ]] :Gitsign next_hunk<CR>
nnoremap <leader>u :Gitsign reset_hunk<CR>
let g:gruvbox_invert_signs=1

" === 
" === vim-illuminate
" ===

lua << EOF
-- default configuration
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        --'treesitter',
        'regex',
        --'lsp',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
    -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = 10000,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
    -- should_enable: a callback that overrides all other settings to
    -- enable/disable illumination. This will be called a lot so don't do
    -- anything expensive in it.
    should_enable = function(bufnr) return true end,
    -- case_insensitive_regex: sets regex case sensitivity
    case_insensitive_regex = false,
    -- disable_keymaps: disable default keymaps
    disable_keymaps = false,
})
EOF




" ===
" === multicursors
" ===
lua <<EOF
require('multicursors').setup{}
EOF
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
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === rainbow
" ===
let g:rainbow_active = 1




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


" === ranger ===
nnoremap <leader>ra :RangerCurrentFileNewTab<CR>
let g:ranger_map_keys = 0

" === nvim-tree ===
nnoremap <leader>e :NvimTreeFindFileToggle<CR>



" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl



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

let g:move_key_modifier = '<leader>'
let g:move_map_keys = 0
nmap <leader><down>  <Plug>MoveLineDown
nmap <leader><up> <Plug>MoveLineUp

" === vim-auto-pairs
lua << EOF
require("nvim-autopairs").setup {}
EOF

" === hlslens ===

lua <<EOF
require('hlslens').setup()
EOF

" === neoscroll ===
" lua << EOF
" require('neoscroll').setup({})
" EOF


"===== indent =====
lua <<EOF
require("ibl").setup()
EOF


" ===
" === any-jump
" ===
" nnoremap gr :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.9
let g:any_jump_window_height_ratio = 0.9
nnoremap <leader>gd :AnyJump<CR>
let g:any_jump_grouping_enabled = 1
nnoremap <leader>gh :AnyJumpLastResults<CR>
nnoremap <leader>gi :execute "AnyJumpArg " .. expand("<cword>") .. "Impl"<CR>
let g:any_jump_disable_default_keybindings = 1


" ==================== context ====================
let g:context_add_mappings = 0
"let g:context_presenter= 'preview'
let g:context_enabled = 0
nnoremap <leader>ct :ContextToggleWindow<CR>





" === vim-highlighter ===
let g:HiMapKeys=0

nnoremap <leader>ah :Hi +<CR>
vnoremap <leader>ah y:Hi +x <c-r>"<CR>
nnoremap <leader>dh :Hi -<CR>
nnoremap <leader>ch :Hi Clear<CR>


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
    vim.keymap.set("n", "s", require('substitute').operator, { noremap = true })
    --vim.keymap.set("n", "ss", require('substitute').line, { noremap = true })
    --vim.keymap.set("n", "S", require('substitute').eol, { noremap = true })
    vim.keymap.set("x", "s", require('substitute').visual, { noremap = true })
EOF
"nnoremap s <Cmd>lua require("substitute").operator()<CR>
"vnoremap s <Cmd>lua require("substitute").visual()<CR>
" ==================== WhichKey ====================
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" ====================== flash =====================
hi Blue guibg=blue guifg=blue
hi Red guifg=red
lua <<EOF
require("flash").setup ({
      -- labels = "abcdefghijklmnopqrstuvwxyz",
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        -- search/jump in all windows
        multi_window = true,
        -- search direction
        forward = true,
        -- when `false`, find only matches in the given direction
        wrap = true,
        ---@type Flash.Pattern.Mode
        -- Each mode will take ignorecase and smartcase into account.
        -- * exact: exact match
        -- * search: regular search
        -- * fuzzy: fuzzy search
        -- * fun(str): custom function that returns a pattern
        --   For example, to only match at the beginning of a word:
        --   mode = function(str)
        --     return "\\<" .. str
        --   end,
        mode = "exact",
        -- behave like `incsearch`
        incremental = false,
        -- Excluded filetypes and custom window filters
        ---@type (string|fun(win:window))[]
        exclude = {
          "notify",
          "cmp_menu",
          "noice",
          "flash_prompt",
          function(win)
            -- exclude non-focusable windows
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
        -- Optional trigger character that needs to be typed before
        -- a jump label can be used. It's NOT recommended to set this,
        -- unless you know what you're doing
        trigger = "",
        -- max pattern length. If the pattern length is equal to this
        -- labels will no longer be skipped. When it exceeds this length
        -- it will either end in a jump or terminate the search
        max_length = false, ---@type number|false
      },
      jump = {
        -- save location in the jumplist
        jumplist = true,
        -- jump position
        pos = "start", ---@type "start" | "end" | "range"
        -- add pattern to search history
        history = false,
        -- add pattern to search register
        register = false,
        -- clear highlight after jump
        nohlsearch = false,
        -- automatically jump when there is only one match
        autojump = false,
        -- You can force inclusive/exclusive jumps by setting the
        -- `inclusive` option. By default it will be automatically
        -- set based on the mode.
        inclusive = nil, ---@type boolean?
        -- jump position offset. Not used for range jumps.
        -- 0: default
        -- 1: when pos == "end" and pos < current position
        offset = nil, ---@type number
      },
      label = {
        -- allow uppercase labels
        uppercase = true,
        -- add any labels with the correct case here, that you want to exclude
        exclude = "",
        -- add a label for the first match in the current window.
        -- you can always jump to the first match with `<CR>`
        current = true,
        -- show the label after the match
        after = true, ---@type boolean|number[]
        -- show the label before the match
        before = false, ---@type boolean|number[]
        -- position of the label extmark
        style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
        -- flash tries to re-use labels that were already assigned to a position,
        -- when typing more characters. By default only lower-case labels are re-used.
        reuse = "lowercase", ---@type "lowercase" | "all" | "none"
        -- for the current window, label targets closer to the cursor first
        distance = true,
        -- minimum pattern length to show labels
        -- Ignored for custom labelers.
        min_pattern_length = 0,
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
          enabled = false,
          -- number between 1 and 9
          shade = 5,
        },
        -- With `format`, you can change how the label is rendered.
        -- Should return a list of `[text, highlight]` tuples.
        ---@class Flash.Format
        ---@field state Flash.State
        ---@field match Flash.Match
        ---@field hl_group string
        ---@field after boolean
        ---@type fun(opts:Flash.Format): string[][]
        format = function(opts)
          return { { opts.match.label, opts.hl_group } }
        end,
      },
      highlight = {
        -- show a backdrop with hl FlashBackdrop
        backdrop = true,
        -- Highlight the search matches
        matches = true,
        -- extmark priority
        priority = 5000,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
      -- action to perform when picking a label.
      -- defaults to the jumping logic depending on the mode.
      ---@type fun(match:Flash.Match, state:Flash.State)|nil
      action = nil,
      -- initial pattern to use when opening flash
      pattern = "",
      -- When `true`, flash will try to continue the last search
      continue = false,
      -- Set config to a function to dynamically change the config
      config = nil, ---@type fun(opts:Flash.Config)|nil
      -- You can override the default options for a specific mode.
      -- Use it with `require("flash").jump({mode = "forward"})`
      ---@type table<string, Flash.Config>
      modes = {
        -- options used when flash is activated through
        -- a regular search with `/` or `?`
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = false,
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
          search = {
            -- `forward` will be automatically set to the search direction
            -- `mode` is always set to `search`
            -- `incremental` is set to `true` when `incsearch` is enabled
          },
        },
        -- options used when flash is activated through
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = true,
          -- dynamic configuration for ftFT motions
          config = function(opts)
            -- autohide flash when in operator-pending mode
            opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")
    
            -- disable jump labels when not enabled, when using a count,
            -- or when recording/executing registers
            opts.jump_labels = opts.jump_labels
              and vim.v.count == 0
              and vim.fn.reg_executing() == ""
              and vim.fn.reg_recording() == ""
    
            -- Show jump labels only in operator-pending mode
            -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
          end,
          -- hide after jump when not using jump labels
          autohide = false,
          -- show jump labels
          jump_labels = true,
          -- set to `false` to use the current line only
          multi_line = false,
          -- When using jump labels, don't use these keys
          -- This allows using those keys directly after the motion
          label = { exclude = "hjkliardc" },
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          -- If you rather use another key, you can map them
          -- to something else, e.g., { [";"] = "L", [","] = H }
          keys = { "f", "F", "t", "T", ";", "," },
          ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
          -- The direction for `prev` and `next` is determined by the motion.
          -- `left` and `right` are always left and right.
          char_actions = function(motion)
            return {
              [";"] = "next", -- set to `right` to always go right
              [","] = "prev", -- set to `left` to always go left
              -- clever-f style
              [motion:lower()] = "next",
              [motion:upper()] = "prev",
              -- jump2d style: same case goes next, opposite case goes prev
              -- [motion] = "next",
              -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
            }
          end,
          search = { wrap = false, mode = "exact"},
          highlight = { backdrop = true },
          jump = {
            register = false,
            -- when using jump labels, set to 'true' to automatically jump
            -- or execute a motion when there is only one match
            autojump = false,
          },
        },
        -- options used for treesitter selections
        -- `require("flash").treesitter()`
        treesitter = {
          labels = "abcdefghijklmnopqrstuvwxyz",
          jump = { pos = "range", autojump = true },
          search = { incremental = false },
          label = { before = true, after = true, style = "inline" },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
        treesitter_search = {
          jump = { pos = "range" },
          search = { multi_window = true, wrap = true, incremental = false },
          remote_op = { restore = true },
          label = { before = true, after = true, style = "inline" },
        },
        -- options used for remote flash
        remote = {
          remote_op = { restore = true, motion = true },
        },
      },
      -- options for the floating window that shows the prompt,
      -- for regular jumps
      -- `require("flash").prompt()` is always available to get the prompt text
      prompt = {
        enabled = true,
        prefix = { { "⚡", "FlashPromptIcon" } },
        win_config = {
          relative = "editor",
          width = 1, -- when <=1 it's a percentage of the editor width
          height = 1,
          row = -1, -- when negative it's an offset from the bottom
          col = 0, -- when negative it's an offset from the right
          zindex = 1000,
        },
      },
      -- options for remote operator pending mode
      remote_op = {
        -- restore window views and cursor position
        -- after doing a remote operation
        restore = false,
        -- For `jump.pos = "range"`, this setting is ignored.
        -- `true`: always enter a new motion when doing a remote operation
        -- `false`: use the window's cursor position and jump target
        -- `nil`: act as `true` for remote windows, `false` for the current window
        motion = false,
      },
    })
EOF
nnoremap ' <Cmd>lua require('flash').jump()<CR>


" ================telescope==================
lua <<EOF
  require('telescope').setup{
    defaults = {
      path_display={"filename_first"},
      layout_strategy = 'vertical',
          layout_config = {
            height = 0.99, width = 0.99,
            prompt_position = "bottom",
            preview_cutoff = 0,
          },
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<CR>"] = require("telescope.actions").select_default,
          ["<c-q>"] = function(_prompt_bufnr)
          require("telescope.actions").smart_send_to_qflist(_prompt_bufnr)
          require("telescope.actions").open_qflist(_prompt_bufnr)
          end,
        },
      },
    },
    pickers = {
					search_history = {
						mappings = {
							i = {
								["<CR>"] = require("telescope.actions").select_default,
							},
						}
					},
					command_history = {
						mappings = {
							i = {
								["<CR>"] = require("telescope.actions").select_default,
							},
						}
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
  require('telescope').load_extension('fzf')
  require('telescope-tabs').setup {
			-- Your custom config :^)
  }
EOF

lua <<EOF
local builtin = require('telescope.builtin')
local config = require('telescope.config')

-- Return a list of files found in quickfix, skipping duplicates
local quickfix_files = function()
  local qflist = vim.fn.getqflist()
  local files = {}
  local seen = {}
  for k in pairs(qflist) do
    local path = vim.fn.bufname(qflist[k]["bufnr"])
    if not seen[path] then
      files[#files + 1] = path
      seen[path] = true
    end
  end
  table.sort(files)
  return files
end

-- Invoke live_grep on all files in quickfix
local grep_on_quickfix = function()
  local args = {}

  for i, v in ipairs(config.values.vimgrep_arguments) do
    args[#args+1] = v
  end
  for i, v in ipairs(quickfix_files()) do
    args[#args+1] = '-g/'..v
  end

  builtin.live_grep({vimgrep_arguments = args})
end

vim.keymap.set('n', '<Leader>fq', grep_on_quickfix, {})
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values
local api = vim.api
local utils = require "telescope.utils"

local ns_previewer = vim.api.nvim_create_namespace("")

local my_previewer = function()
  local jump_to_line = function (self, bufnr, entry)
      pcall(api.nvim_buf_clear_namespace, bufnr, ns_previewer, 0, -1)

    if entry.lnum and entry.lnum > 0 then
      local lnum, lnend = entry.lnum - 1, (entry.lnend or entry.lnum) - 1

      local col, colend = 0, -1
      -- Both col delimiters should be provided for them to take effect.
      -- This is to ensure that column range highlighting was opted in, as `col`
      -- is already used to determine the buffer jump position elsewhere.
      if entry.col and entry.colend then
        col, colend = entry.col - 1, entry.colend - 1
      end

      for i = lnum, lnend do
        pcall(
          utils.hl_range,
          bufnr,
          ns_previewer,
          "TelescopePreviewLine",
          { i, i == lnum and col or 0 },
          { i, i == lnend and colend or -1 }
        )
      end

      local middle_ln = math.floor(lnum + (lnend - lnum) / 2)
      pcall(api.nvim_win_set_cursor, self.state.winid, { middle_ln + 1, 0 })
      vim.api.nvim_buf_add_highlight(bufnr, ns_previewer, "TelescopePreviewLine", middle_ln, 0, -1)
      if bufnr ~= nil then
        api.nvim_buf_call(bufnr, function()
          vim.cmd "norm! zz"
        end)
      end
  end


  end
   return previewers.new_buffer_previewer {
     title = "Test previewer",
     get_buffer_by_name = function (self, entry)
       return entry.path
     end,
     define_preview = function (self, entry)
       local p = entry.path
       return conf.buffer_previewer_maker(p, self.state.bufnr, {
         bufname = self.state.bufname,
         winid = self.state.winid,
         callback = function(bufnr)
           jump_to_line(self, bufnr, entry)
         end,
       })
     end,
   }
end



local livegrep = function()
    -- require("telescope").extensions.egrepify.egrepify({previewer = my_previewer()})
    require("telescope.builtin").live_grep({previewer = my_previewer()})
end
local livegrepvimwiki = function()
    require("telescope.builtin").live_grep({previewer = my_previewer(), default_text = " ", search_dirs = { "/root/vimwiki" }})
end
vim.keymap.set('n', '<leader>fw', livegrep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fv', livegrepvimwiki, { desc = 'Telescope grep vimwiki'})

EOF


"===cursorword===
let g:cursorword = 1

" ============== toggleterm ================================

lua require("toggleterm").setup()
nnoremap <leader>tm :execute "ToggleTerm direction=float dir=" .. expand("%:p:h")<CR>
vnoremap <leader>tm :ToggleTermSendVisualLines<CR>
" <c-\> <c-n> to switch to normal mode

"
" =================bqf=============================

lua <<EOF
local bqf_pv_timer
require('bqf').setup{
   auto_enable = true,
    auto_resize_height = true, -- highly recommended enable
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
        show_title = false,
        should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 10000 * 1024 then
                -- skip file size greater than 1000k
                ret = false
            elseif bufname:match('^fugitive://') then
                -- skip fugitive buffer
                ret = false
            end
            return ret
        end
    },
    -- make `drop` and `tab drop` to become preferred
    func_map = {
        drop = 'o',
        openc = 'O',
        split = '<C-s>',
        tabdrop = '<C-t>',
        -- set to empty string to disable
        tabc = '',
        ptogglemode = 'z,',
    },
    filter = {
        fzf = {
            action_for = {['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop'},
            extra_opts = {'--bind', 'ctrl-o:toggle-all', '--prompt', '> '}
        }
    }
}


EOF

" LSP key map
nnoremap K :lua vim.lsp.buf.hover()<CR>
" nnoremap K :Lspsaga hover_doc<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gD :tab sp<CR>:lua vim.lsp.buf.definition()<CR>
" noremap gd :Lspsaga peek_definition<CR>
nnoremap gi :lua vim.lsp.buf.implementation()<CR>
nnoremap gI :tab sp<CR>:lua vim.lsp.buf.implementation()<CR>
nnoremap gy :lua vim.lsp.buf.type_definition()<CR>
nnoremap gY :tab sp<CR>:lua vim.lsp.buf.type_definition()<CR>
" nnoremap gy :Lspsaga peek_type_definition<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
" nnoremap gr :tab sp<CR>:lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>fm :lua vim.lsp.buf.format({async=true})<CR>
lua <<EOF
local function get_type_hierarchy(method)
  vim.lsp.buf_request(0, "textDocument/prepareTypeHierarchy", vim.lsp.util.make_position_params(), function(_, result)
    if not result then
      vim.notify_once("Does not support typeHierarchy", vim.log.levels.INFO)
      return
    end
    vim.lsp.buf_request(0, method, { item = result[1] }, function(_, res)
      if not res or #res == 0 then
        return
      end

      if #res == 1 then
        vim.lsp.util.jump_to_location(res[1], "utf-8", true)
        return
      end

      vim.ui.select(res, {
        format_item = function(item) ---@param item lsp.TypeHierarchyItem
          local kind = vim.lsp.protocol.SymbolKind[item.kind] or "Unknown"
          return kind .. ": " .. item.name
        end,
        prompt = "Jump to definition",
      }, function(item) ---@param item lsp.TypeHierarchyItem
        if item then
          vim.lsp.util.jump_to_location(item, "utf-8", true)
        end
      end)
    end)
  end)
end
vim.keymap.set('v', '<leader>fm', vim.lsp.buf.format)
vim.keymap.set('n', 'gp', function() get_type_hierarchy("typeHierarchy/supertypes") end)

vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

EOF
vnoremap <leader>ac :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>ac :lua vim.lsp.buf.code_action()<CR>
" xnoremap <leader>ac :Lspsaga code_action<CR>
" nnoremap <leader>ac :Lspsaga code_action<CR>
nnoremap [g :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]g :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>ae <Cmd>lua require('jdtls').extract_variable()<CR>
" nnoremap [g :Lspsaga diagnostic_jump_prev<CR>
" nnoremap ]g :Lspsaga diagnostic_jump_next<CR>
" lua <<EOF
" require('lspsaga').setup{}
" EOF

" ===================== others ===========================
let g:python3_host_prog = 'python3'
nnoremap <leader>ihe :lua vim.lsp.inlay_hint.enable(true)<CR>
nnoremap <leader>ihd :lua vim.lsp.inlay_hint.enable(false)<CR>
nnoremap <leader>did :lua vim.diagnostic.disable()<CR>
nnoremap <leader>die :lua vim.diagnostic.enable()<CR>
" nnoremap <leader>df :lua vim.diagnostic.open_float(0, {scope="line"})<CR>

nnoremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
nnoremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
nnoremap * *N<Cmd>lua require('hlslens').start()<CR>
nnoremap # #<Cmd>lua require('hlslens').start()<CR>
nnoremap g* g*<Cmd>lua require('hlslens').start()<CR>
nnoremap g# g#<Cmd>lua require('hlslens').start()<CR>
vnoremap * y/<c-r>0<cr>
nnoremap <LEADER>ww :e ~/vimwiki/index.wiki<CR>
nnoremap <LEADER><c-n> :MCstart<CR>
