

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set ts=4
"
"" " indent when moving to the next line while writing code
set autoindent
"
"" " expand tabs into spaces
set expandtab
"
"" " when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
"
"" " show a visual line under the cursor's current line
set cursorline
"
"" " show the matching part of the pair for [] {} and ()
set showmatch
"
"" " enable all Python syntax highlighting features
let python_highlight_all = 1
let g:python3_host_prog='/usr/local/bin/python3'



syntax on
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu


set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
noremap n nzz
noremap N Nzz
let mapleader=" "



map s <nop>
map S :w<CR>
map Q :q<CR>
map D <C-d>
map U <C-U>
map R :source $MYVIMRC<CR>
map <up> :res -5<CR>
map <down> :res +5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>
map sn :set nosplitright<CR>:set splitright<CR>:vsplit 
map <LEADER>w <C-w>w
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>/ :!

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
" assuming you're using vim-plug: https://github.com/junegunn/vim-plug
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'preservim/nerdtree'

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
Plug 'ncm2/ncm2-bufword'

call plug#end()


" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert,preview
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'
" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:ncm2_jedi#python_version = "3"  




