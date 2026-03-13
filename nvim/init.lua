-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)



vim.lsp.inlay_hint.enable(true)

vim.opt.laststatus = 3
vim.opt.scrolloff = 10
vim.opt.synmaxcol = 0
vim.opt.iskeyword:append('-')
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.ts = 2
vim.opt.encoding = 'utf-8'
vim.opt.autoindent = true
vim.opt.autochdir = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.smartcase = true
vim.opt.cmdheight = 2
vim.opt.timeoutlen = 800
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

vim.opt.compatible = false
vim.cmd('filetype plugin on')
vim.cmd('syntax on')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.clipboard:append('unnamedplus')

vim.opt.hlsearch = true
vim.cmd('nohlsearch')
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.ww:append('h,l')
vim.opt.list = true
vim.opt.listchars = 'eol:↓,tab:\\ ┊,trail:●,extends:…,precedes:…,space:·'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_create_augroup('PreserveNoEOL', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
    group = 'PreserveNoEOL',
    callback = function(args)
        if not vim.b[args.buf].endofline then
            vim.b[args.buf].save_bin = vim.b[args.buf].binary
            vim.b[args.buf].save_eol = vim.b[args.buf].endofline
            vim.cmd('setlocal binary noeol')
        end
    end,
})
vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'PreserveNoEOL',
    callback = function(args)
        if vim.b[args.buf].save_bin then
            vim.b[args.buf].binary = vim.b[args.buf].save_bin
            vim.b[args.buf].endofline = vim.b[args.buf].save_eol
            vim.b[args.buf].save_bin = nil
            vim.b[args.buf].save_eol = nil
        end
    end,
})

vim.api.nvim_create_augroup('TabClosed', { clear = true })
local prevtabnum = vim.fn.tabpagenr('$')
vim.api.nvim_create_autocmd('TabEnter', {
    group = 'TabClosed',
    callback = function()
        if vim.fn.tabpagenr('$') < prevtabnum and vim.fn.tabpagenr() > 1 then
            vim.cmd('tabprevious')
        end
        prevtabnum = vim.fn.tabpagenr('$')
    end,
})

vim.api.nvim_create_augroup('NVIMRC', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'NVIMRC',
    pattern = 'init.vim',
    command = 'source %',
})

vim.api.nvim_create_augroup('FugitiveFileName', { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'FugitiveFileName',
    callback = function()
        local bufname = vim.fn.expand('%')
        if bufname:match('^fugitive://') then
            local p = vim.fn.searchpos('^[A-Z?] .\\|^diff --', 'bnW')
            local gitkeyline = vim.fn.getline(p[0])
            local match = vim.fn.matchlist(gitkeyline, 'diff --git a/.*/\\([^/]*\\) b/')
            if #match > 1 then
                print('viewing file:' .. match[2])
            else
                print('')
            end
        end
    end,
})

local function ShowFugitiveFileName()
    local bufname = vim.fn.expand('%')
    if bufname:match('^fugitive://') then
        local p = vim.fn.searchpos('^[A-Z?] .\\|^diff --', 'bnW')
        local gitkeyline = vim.fn.getline(p[0])
        local match = vim.fn.matchlist(gitkeyline, 'diff --git a/.*/\\([^/]*\\) b/')
        if #match > 1 then
            print('viewing file:' .. match[2])
        else
            print('')
        end
    end
end

local function EnsureTabExists(num)
    local current_tab = vim.fn.tabpagenr()
    if vim.fn.tabpagenr('$') < num then
        vim.cmd('tabnew')
        vim.cmd('tabnext ' .. current_tab)
    end
end

local last_list_win_type = 0
local function toggle_list()
    local loc_win = vim.fn.getloclist(0, { winid = 0 }).winid
    if loc_win and loc_win ~= 0 then
        vim.cmd('lcl')
        last_list_win_type = 1
        return
    end
    local qf_win = vim.fn.getqflist({ winid = 0 }).winid
    if qf_win and qf_win ~= 0 then
        vim.cmd('ccl')
        last_list_win_type = 2
        return
    end
    if last_list_win_type == 1 then
        vim.cmd('lopen')
        return
    end
    if last_list_win_type == 2 then
        vim.cmd('copen')
        return
    end
end

local function next_list()
    local loc_win = vim.fn.getloclist(0, { winid = 0 }).winid
    if loc_win and loc_win ~= 0 then
        vim.cmd('lnext')
        return
    end
    local qf_win = vim.fn.getqflist({ winid = 0 }).winid
    if qf_win and qf_win ~= 0 then
        vim.cmd('cnext')
        return
    end
end

local function prev_list()
    local loc_win = vim.fn.getloclist(0, { winid = 0 }).winid
    if loc_win and loc_win ~= 0 then
        vim.cmd('lprev')
        return
    end
    local qf_win = vim.fn.getqflist({ winid = 0 }).winid
    if qf_win and qf_win ~= 0 then
        vim.cmd('cprev')
        return
    end
end

local translator_target_lang = 'zh'
local function toggle_lang()
    if translator_target_lang == 'zh' then
        print('switch g:translator_target_lang to en')
        translator_target_lang = 'en'
    else
        print('switch g:translator_target_lang to zh')
        translator_target_lang = 'zh'
    end
end

local toggle_fs_enabled = false
local function ToggleFs()
    if toggle_fs_enabled then
        vim.cmd('wincmd =')
        toggle_fs_enabled = false
    else
        vim.cmd('wincmd _')
        vim.cmd('wincmd |')
        toggle_fs_enabled = true
    end
end

vim.keymap.set('n', '<leader>fs', ToggleFs)

local function SearchProtoBuf()
    local current_file = vim.fn.expand('%:t:r')
    require('fzf-lua').files({
        cwd = vim.fn.getcwd(),
        fzf_opts = { ["--query"] = current_file .. '.proto' }
    })
end

local function SearchUTfile()
    local current_file = vim.fn.expand('%:t:r')
    require('fzf-lua').files({
        cwd = vim.fn.getcwd(),
        fzf_opts = { ["--query"] = current_file .. 'Test' }
    })
end

local function SearchCurrentFile()
    local current_file = vim.fn.expand('%')
    local current_line = vim.fn.line('.')
    local pos = vim.fn.getpos('.')
    EnsureTabExists(2)
    local path = current_file:gsub('diffview://', ''):gsub('.git/.-/', '')
    vim.cmd('tabnext')
    vim.cmd('edit ' .. path)
    vim.fn.setpos('.', pos)
end

vim.keymap.set('v', '<Leader>c', 'yo<c-r>=<c-r>"<CR>')
vim.keymap.set('n', '<Space>cp', ':let @*=expand("%:t")<CR>:echo "path copied"<CR>')
vim.keymap.set('n', '<Space>cfp', ':let @*=expand("%")<CR>:echo "full path copied"<CR>')

vim.keymap.set('x', '<leader>in0', [[:<C-u>'<,'>s/\d\+\ze\D*$/\=line('.')-line("'<")/<CR>:noh<CR>]])
vim.keymap.set('x', '<leader>in1', [[:<C-u>'<,'>s/\d\+\ze\D*$/\=line('.')-line("'<")+1/<CR>:noh<CR>]])

vim.keymap.set('n', 'H', '0')
vim.keymap.set('v', 'H', '0')
vim.keymap.set('n', 'L', '$')
vim.keymap.set('v', 'L', '$')
vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end, { expr = true })
vim.keymap.set('i', '<M-h>', '<Left>')
vim.keymap.set('i', '<M-j>', '<Down>')
vim.keymap.set('i', '<M-k>', '<Up>')
vim.keymap.set('i', '<M-l>', '<Right>')
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'jh', '<ESC>^i')
vim.keymap.set('i', 'jl', '<ESC>A')
vim.keymap.set('i', 'jj', '<ESC>o')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('n', 'db', 'dvb')
vim.keymap.set('n', 'cb', 'cvb')
vim.keymap.set('n', 'yb', 'yvb')
vim.keymap.set('n', '<Leader><down>', '0i<cr><ESC>')
vim.keymap.set('n', '<Leader><up>', 'kdd')
vim.keymap.set('n', '=', ':nohlsearch<CR>')
vim.keymap.set('n', '(', 'vaf`<<ESC>')
vim.keymap.set('n', ')', 'vaf<ESC>')
vim.keymap.set('n', '<C-e>', 'ea')
vim.keymap.set('n', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
vim.keymap.set('n', 'N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
vim.keymap.set('n', 'S', ':w<CR>')
vim.keymap.set('n', 'Q', ':Sayonara<CR>')
vim.keymap.set('n', '<Leader>Q', ':qa!<CR>')

vim.keymap.set('n', '<leader>sl', ':set nosplitright<CR>:set splitright<CR>:vnew<CR><c-w>l')
vim.keymap.set('n', '<leader>sv', ':set nosplitright<CR>:set splitright<CR>:vsplit $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>st', ':set nosplitright<CR>:set splitright<CR>:vsplit ~/vimwiki/TODO.wiki<CR>')
vim.keymap.set('n', '<leader>sj', ':set nosplitbelow<CR>:set splitbelow<CR>:new<CR><c-w>j')

vim.keymap.set('n', '<leader>,', '`[V`]"<')
vim.keymap.set('n', '<leader>.', '`[V`]">')
vim.keymap.set('n', '<leader>ti', ':-tabnew<CR>')
vim.keymap.set('n', '<leader>ta', ':tabnew<CR>')
vim.keymap.set('n', '<leader>tI', ':0tabnew<CR>')
vim.keymap.set('n', '<leader>tA', ':$tabnew<CR>')
vim.keymap.set('n', '<leader><left>', ':tabp<CR>')
vim.keymap.set('n', '<leader>th', ':tabp<CR>')
vim.keymap.set('n', '<leader>tH', ':tabfirst<CR>')
vim.keymap.set('n', '<leader><right>', ':tabn<CR>')
vim.keymap.set('n', '<leader>tl', ':tabn<CR>')
vim.keymap.set('n', '<leader>tL', ':tablast<CR>')
vim.keymap.set('n', '<leader>ts', ':tab split<CR>')
vim.keymap.set('n', 'tfs', '<C-W>T')
vim.keymap.set('n', 't1', ':tabn1<CR>')
vim.keymap.set('n', 't2', ':tabn2<CR>')
vim.keymap.set('n', 't3', ':tabn3<CR>')
vim.keymap.set('n', 't4', ':tabn4<CR>')
vim.keymap.set('n', 't5', ':tabn5<CR>')
vim.keymap.set('n', 't6', ':tabn6<CR>')
vim.keymap.set('n', 't7', ':tabn7<CR>')
vim.keymap.set('n', 't8', ':tabn8<CR>')
vim.keymap.set('n', 't9', ':tabn9<CR>')

vim.keymap.set('n', '<leader>t2', ':call EnsureTabExists(2)<CR>')
vim.keymap.set('n', '<leader>t3', ':call EnsureTabExists(3)<CR>')
vim.keymap.set('n', '<leader>t4', ':call EnsureTabExists(4)<CR>')
vim.keymap.set('n', '<leader>t5', ':call EnsureTabExists(5)<CR>')

vim.keymap.set('n', '<leader>qq', toggle_list)
vim.keymap.set('n', '<leader>nn', next_list)
vim.keymap.set('n', '<leader>pp', prev_list)

vim.keymap.set('n', '<leader>db', ':DeleteHiddenBuffers<CR>')

vim.keymap.set('n', 'ty', ':Translate<CR>')
vim.keymap.set('v', 'ty', ':Translate<CR>')
vim.keymap.set('n', 'tr', '<Plug>TranslateR')
vim.keymap.set('v', 'tr', '<Plug>TranslateRV')
vim.keymap.set('n', 'tw', toggle_lang)

-- vim.keymap.set('n', '<Leader>fs', ':call ToggleFs()<CR>')
vim.keymap.set('n', '<leader>fs', ToggleFs)

vim.g.translator_window_type = 'preview'
vim.g.translator_default_engines = { 'google', 'bing' }

vim.g.codeium_no_map_tab = true
vim.g.codeium_workspace_root_hints = { '.bzr', '.git', '.hg', '.svn', '_FOSSIL_', 'package.json' }

vim.api.nvim_set_keymap('i', '<script><silent><nowait><expr> <C-o>', 'codeium#Accept()',
    { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<C-c>', '<Cmd>call codeium#CycleCompletions(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-z>', '<Cmd>call codeium#Clear()<CR>', { noremap = true, silent = true })

vim.cmd([[
if !empty(glob('~/dellcodeium.vim'))
    source ~/dellcodeium.vim
endif
]])
vim.cmd('highlight CodeiumSuggestion guifg=#555555 ctermfg=8')
vim.cmd('highlight link GitSignsCurrentLineBlame DiffAdd')

vim.g.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.cmd('colorscheme everforest')
        vim.opt.background = 'dark'
    end,
})


vim.keymap.set('n', 'U', ':UndotreeToggle<CR>')
vim.g.undotree_DiffAutoOpen = 1
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.g.undotree_DiffpanelHeight = 8
vim.g.undotree_SplitWidth = 24

vim.g.fugitive_summary_format = '%<(16,trunc)%an||%<(27,trunc)%ad||%s'
vim.keymap.set('n', '<leader>rc', ':Gvdiffsplit!<CR>')
vim.keymap.set('n', '<leader>df', ':G diff')
vim.keymap.set('n', '<leader>dfv', ':DiffViewOpen')
vim.keymap.set('n', '<leader>ge', ':Gedit <commitid>:<file>')
vim.keymap.set('n', '<leader>log', function()
    vim.g.logindex = 0
    vim.g.logenabled = 1
    vim.g.logcenabled = 0
    vim.cmd('Gclog! -500 --')
end)
vim.keymap.set('n', '<leader>bl', 'V:Git blame<CR>')
vim.keymap.set('v', '<leader>bl', ':Git blame<CR>')
vim.keymap.set('n', '<leader>logd', ':0Gclog! -5000 -- %<CR>:copen<CR>')
vim.keymap.set('n', '<leader>logcc', ':Git --paginate log -500 --patch  -- %')
vim.keymap.set('n', '<leader>logc', function()
    vim.g.logcindex = 0
    vim.g.logenabled = 0
    vim.g.logcenabled = 1
    vim.cmd('Gclog! -500 -- %')
end)

vim.g.logindex = 0
vim.g.logcindex = 0
vim.g.logenabled = 0
vim.g.logcenabled = 0

vim.api.nvim_create_user_command('GMore', function()
    if vim.g.logenabled == 1 then
        vim.g.logindex = vim.g.logindex + 500
        vim.cmd('Gclog! -500 --skip=' .. vim.g.logindex)
    end
    if vim.g.logcenabled == 1 then
        vim.g.logcindex = vim.g.logcindex + 500
        vim.cmd('Gclog! -500 --skip=' .. vim.g.logcindex .. ' -- %')
    end
end, {})

vim.api.nvim_create_user_command('GLess', function()
    if vim.g.logenabled == 1 then
        vim.g.logindex = vim.g.logindex - 500
        if vim.g.logindex < 0 then vim.g.logindex = 0 end
        vim.cmd('Gclog! -500 --skip=' .. vim.g.logindex)
    end
    if vim.g.logcenabled == 1 then
        vim.g.logcindex = vim.g.logcindex - 500
        if vim.g.logcindex < 0 then vim.g.logcindex = 0 end
        vim.cmd('Gclog! -500 --skip=' .. vim.g.logcindex .. ' -- %')
    end
end, {})

vim.keymap.set('n', '<leader>ln', ':GMore<CR>')
vim.keymap.set('n', '<leader>lp', ':GLess<CR>')

vim.keymap.set('v', '<leader>log', '<ESC>:-tabnew<CR>gv:Gclog! -5000<CR>:copen<CR>')
vim.keymap.set('n', '[[', ':Gitsign prev_hunk<CR>')
vim.keymap.set('n', ']]', ':Gitsign next_hunk<CR>')
vim.keymap.set('n', '<leader>u', ':Gitsign reset_hunk<CR>')

vim.g.gruvbox_invert_signs = 1

vim.keymap.set('n', '<leader>ma', '<Plug>BookmarkToggle')
vim.keymap.set('n', '<leader>mt', '<Plug>BookmarkAnnotate')
vim.keymap.set('n', '<leader>ml', ':BookmarkShowAll<CR>')
vim.keymap.set('n', '<leader>mc', '<Plug>BookmarkClear')
vim.g.bookmark_auto_save = 1
vim.g.bookmark_highlight_lines = 1
vim.g.bookmark_manage_per_buffer = 0
vim.g.bookmark_save_per_working_dir = 0
vim.g.bookmark_center = 1
vim.g.bookmark_auto_close = 1
vim.g.bookmark_location_list = 1

vim.keymap.set('n', '<leader>ra', ':RangerCurrentFileNewTab<CR>')
vim.g.ranger_map_keys = 0
vim.keymap.set('n', '<leader>e', '<cmd>lua require("nvim-tree.api").tree.toggle({ find_file = true })<CR>')

vim.g.Illuminate_delay = 750
vim.cmd('highlight illuminatedWord cterm=undercurl gui=undercurl')

vim.g.tcomment_textobject_inlinecomment = ''
vim.keymap.set('n', '<Leader><Leader>', 'gcc', { remap = true })
vim.keymap.set('v', '<Leader><Leader>', 'gcc', { remap = true })

vim.g.move_key_modifier = '<leader>'
vim.g.move_map_keys = 0
vim.keymap.set('n', '<leader><down>', '<Plug>MoveLineDown')
vim.keymap.set('n', '<leader><up>', '<Plug>MoveLineUp')

vim.g.any_jump_window_width_ratio = 0.9
vim.g.any_jump_window_height_ratio = 0.9
vim.keymap.set('n', '<leader>gd', ':AnyJump<CR>')
vim.g.any_jump_grouping_enabled = 1
vim.keymap.set('n', '<leader>gh', ':AnyJumpLastResults<CR>')
vim.keymap.set('n', '<leader>gi', ':execute "AnyJumpArg " .. expand("<cword>") .. "Impl"<CR>')
vim.g.any_jump_disable_default_keybindings = 1

vim.g.context_add_mappings = 0
vim.g.context_enabled = 0
vim.keymap.set('n', '<leader>ct', ':ContextToggleWindow<CR>')

vim.g.HiMapKeys = 0
vim.keymap.set('n', '<leader>ah', ':Hi +<CR>')
vim.keymap.set('v', '<leader>ah', 'y:Hi +x <c-r>"<CR>')
vim.keymap.set('n', '<leader>dh', ':Hi -<CR>')
vim.keymap.set('n', '<leader>ch', ':Hi Clear<CR>')

vim.keymap.set('n', '<M-o>', ':lua require("bufjump").backward()<cr>')
vim.keymap.set('n', '<M-i>', ':lua require("bufjump").forward()<cr>')

vim.keymap.set('n', '<silent><leader>', ':WhichKey \'<Space>\'<CR>')

vim.keymap.set('n', "'", '<Cmd>lua require("flash").jump()<CR>')

vim.g.cursorword = 1

vim.keymap.set('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', ':tab sp<CR>:lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gI', ':tab sp<CR>:lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gy', ':lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gY', ':tab sp<CR>:lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', '<leader>fm', ':lua vim.lsp.buf.format({async=true})<CR>')
vim.keymap.set('v', '<leader>fm', ':lua vim.lsp.buf.format()<CR>')

vim.keymap.set('n', '<leader>ac', ':FzfLua lsp_code_actions<CR>')
vim.keymap.set('v', '<leader>ac', ':FzfLua lsp_code_actions<CR>')
vim.keymap.set('n', '[g', ':lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']g', ':lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', '<leader>ae', '<Cmd>lua require("jdtls").extract_variable()<CR>')

vim.keymap.set('n', '<leader>ihe', ':lua vim.lsp.inlay_hint.enable(true)<CR>')
vim.keymap.set('n', '<leader>ihd', ':lua vim.lsp.inlay_hint.enable(false)<CR>')
vim.keymap.set('n', '<leader>did', ':lua vim.diagnostic.disable()<CR>')
vim.keymap.set('n', '<leader>die', ':lua vim.diagnostic.enable()<CR>')

vim.keymap.set('n', '<silent>n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
vim.keymap.set('n', '<silent>N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
vim.keymap.set('n', '*', '*N<Cmd>lua require("hlslens").start()<CR>')
vim.keymap.set('n', '#', '#<Cmd>lua require("hlslens").start()<CR>')
vim.keymap.set('n', 'g*', 'g*<Cmd>lua require("hlslens").start()<CR>')
vim.keymap.set('n', 'g#', 'g#<Cmd>lua require("hlslens").start()<CR>')
vim.keymap.set('v', '*', 'y/<c-r>0<cr>')

vim.keymap.set('n', '<Leader>ww', ':e ~/vimwiki/index.wiki<CR>')

vim.keymap.set('n', '<leader>fr', ':FzfLua oldfiles<CR>')
vim.keymap.set('n', '<leader>fh', ':FzfLua resume<CR>')
vim.keymap.set('n', '<leader>fb', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>ff', ':FzfLua files <CR>')
vim.keymap.set('n', '<leader>ft', ':lua require("aerial").fzf_lua_picker()<CR>')
vim.keymap.set('n', '<leader>f/', ':FzfLua search_history<CR>')
vim.keymap.set('n', '<leader>f:', ':FzfLua command_history<CR>')
vim.keymap.set('n', '<leader>fw', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>fv', ':FzfLua live_grep search_paths={"~/vimwiki"}<CR>')
vim.keymap.set('n', '<leader>fq', ':FzfLua grep_quickfix<CR>')
vim.keymap.set('n', '<leader>fp', SearchProtoBuf)
vim.keymap.set('n', '<leader>fc', SearchCurrentFile)
vim.keymap.set('n', '<leader>fu', SearchUTfile)

vim.keymap.set('n', '<leader>lg', ':LazyGitCurrentFile<CR>')

vim.keymap.set('n', '<leader>dd', ':Trouble diagnostics toggle filter.buf=0<CR>')
vim.keymap.set('n', '<leader>gr', ':Trouble lsp toggle focus=false<CR>')

vim.keymap.set('n', '<leader>tm', ':execute "ToggleTerm direction=float dir=" .. expand("%:p:h")<CR>')
vim.keymap.set('v', '<leader>tm', ':ToggleTermSendVisualLines<CR>')

vim.keymap.set('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>')

vim.g.python3_host_prog = 'python3'
vim.g.rooter_patterns = { '.git' }

vim.keymap.set('n', '<Leader>tb', ':TableModeToggle<CR>')
vim.g.table_mode_disable_mappings = 1
vim.g.table_mode_cell_text_object_i_map = 'k<Bar>'

vim.keymap.set('n', '<leader>ww', ':VimwikiTabIndex<CR>')

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'markdown', 'vimwiki' },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.smarttab = true
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
        vim.keymap.set('n', '<leader>w', 'yiWi[<esc>Ea](<esc>pa)', { buffer = true })
        vim.keymap.set('i', ',f', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', { buffer = true })
        vim.keymap.set('i', '<c-e>', '<Esc>/<++><CR>:nohlsearch<CR>"_c4l', { buffer = true })
        vim.keymap.set('i', ',w', '<Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>', { buffer = true })
        vim.keymap.set('i', ',n', '---<Enter><Enter>', { buffer = true })
        vim.keymap.set('i', ',b', '**** <++><Esc>F*hi', { buffer = true })
        vim.keymap.set('i', ',s', '~~~~ <++><Esc>F~hi', { buffer = true })
        vim.keymap.set('i', ',i', '** <++><Esc>F*i', { buffer = true })
        vim.keymap.set('i', ',d', '`` <++><Esc>F`i', { buffer = true })
        vim.keymap.set('i', ',c', '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA', { buffer = true })
        vim.keymap.set('i', ',m', '- [ ] ', { buffer = true })
        vim.keymap.set('i', ',p', '![](<++>) <++><Esc>F[a', { buffer = true })
        vim.keymap.set('i', ',a', '[](<++>) <++><Esc>F[a', { buffer = true })
        vim.keymap.set('i', ',1', '# <Enter><++><Esc>kA', { buffer = true })
        vim.keymap.set('i', ',2', '## <Enter><++><Esc>kA', { buffer = true })
        vim.keymap.set('i', ',3', '### <Enter><++><Esc>kA', { buffer = true })
        vim.keymap.set('i', ',4', '#### <Enter><++><Esc>kA', { buffer = true })
        vim.keymap.set('i', ',l', '--------<Enter>', { buffer = true })
        vim.keymap.set('i', ',t', '[ ] <++><Esc>F]la', { buffer = true })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'vimwiki',
    callback = function()
        vim.keymap.set('i', ',b', '** <++><Esc>F*i', { buffer = true })
        vim.keymap.set('i', ',s', '~~ <++><Esc>F~i', { buffer = true })
        vim.keymap.set('i', ',i', '__ <++><Esc>F_i', { buffer = true })
        vim.keymap.set('i', ',1', '= = =<Enter><++><Esc>khi', { buffer = true })
        vim.keymap.set('i', ',2', '== ==<Enter><++><Esc>ki', { buffer = true })
        vim.keymap.set('i', ',3', '=== ===<Enter><++><Esc>kli', { buffer = true })
        vim.keymap.set('i', ',4', '==== ====<Enter><++><Esc>klli', { buffer = true })
        vim.keymap.set('i', ',t', '[ ] <++><Esc>F]la', { buffer = true })
    end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
        vim.cmd(':GoImports')
        vim.cmd(':GoLint!')
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        vim.cmd('call after_object#enable("=", ":", "-", "#", " ")')
    end,
})

vim.g.rainbow_active = 1

vim.cmd('cnoreabbrev sudowrite w suda://%')
vim.cmd('cnoreabbrev sw w suda://%')

vim.g.vmt_cycle_list_item_markers = 1
vim.g.vmt_fence_text = 'TOC'
vim.g.vmt_fence_closing_text = '/TOC'

vim.g.vim_go_options = {
    gopls_options = { '-remote=auto' },
    echo_go_info = 0,
    doc_popup_window = 1,
    def_mapping_enabled = 0,
    template_autocreate = 0,
    textobj_enabled = 1,
    auto_type_info = 1,
    highlight_array_whitespace_error = 1,
    highlight_build_constraints = 1,
    highlight_chan_whitespace_error = 1,
    highlight_extra_types = 1,
    highlight_fields = 1,
    highlight_format_strings = 1,
    highlight_function_calls = 1,
    highlight_function_parameters = 1,
    highlight_functions = 1,
    highlight_generate_tags = 1,
    highlight_methods = 1,
    highlight_operators = 1,
    highlight_space_tab_error = 1,
    highlight_string_spellcheck = 1,
    highlight_structs = 1,
    highlight_trailing_whitespace_error = 1,
    highlight_types = 1,
    highlight_variable_assignments = 0,
    highlight_variable_declarations = 0,
    doc_keywordprg_enabled = 0,
}




require('lazy').setup({
    { 'nickjvandyke/opencode.nvim' },
    { 'Exafunction/windsurf.vim' },
    { 'MunifTanjim/nui.nvim' },
    { 'NLKNguyen/papercolor-theme' },
    { 'morhetz/gruvbox' },
    { 'neanias/everforest-nvim' },
    { 'overcache/NeoSolarized' },
    { 'doums/darcula' },
    { 'rebelot/kanagawa.nvim' },
    { 'catppuccin/vim' },
    { 'folke/tokyonight.nvim' },
    { 'nvim-lualine/lualine.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'ThePrimeagen/harpoon',       branch = 'harpoon2' },
    { 'pechorin/any-jump.vim' },
    { 'francoiscabrol/ranger.vim' },
    { 'rbgrouleff/bclose.vim' },
    { 'stevearc/aerial.nvim', },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        tag = 'v0.10.0',
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    { 'nvim-treesitter/nvim-treesitter-textobjects' },
    { 'mfussenegger/nvim-jdtls' },
    { 'williamboman/mason.nvim' },
    { 'neovim/nvim-lspconfig',                      tag = 'v2.5.0' },
    { 'Saghen/blink.cmp' },
    { 'folke/trouble.nvim' },
    { 'rafamadriz/friendly-snippets' },
    { 'mbbill/undotree' },
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim' },
    { 'kdheepak/lazygit.nvim' },
    { 'sindrets/diffview.nvim' },
    { 'fatih/vim-go',                               ['for'] = { 'go', 'vim-plug' } },
    { 'uiiaoo/java-syntax.vim' },
    { 'dkarter/bullets.vim' },
    { 'mzlogin/vim-markdown-toc' },
    { 'suan/vim-instant-markdown',                  ['for'] = 'markdown' },
    { 'dhruvasagar/vim-table-mode',                 ['on'] = 'TableModeToggle',    ['for'] = { 'text', 'markdown', 'vim-plug' } },
    { 'vimwiki/vimwiki' },
    { 'nvim-orgmode/orgmode',                       tag = '0.6.0' },
    { 'mhinz/vim-sayonara' },
    { 'kevinhwang91/nvim-bqf' },
    { 'romainl/vim-qf' },
    { 'junegunn/fzf' },
    { 'karunsiri/vim-delete-hidden-buffers' },
    { 'kwkarlwang/bufjump.nvim' },
    { 'RRethy/vim-illuminate' },
    { 'mg979/vim-visual-multi' },
    { 'tomtom/tcomment_vim' },
    { 'gbprod/substitute.nvim' },
    { 'machakann/vim-sandwich' },
    { 'junegunn/vim-after-object' },
    { 'folke/flash.nvim' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'matze/vim-move' },
    { 'windwp/nvim-autopairs' },
    { 'theniceboy/pair-maker.vim' },
    { 'kevinhwang91/nvim-hlslens' },
    { 'MattesGroeger/vim-bookmarks' },
    { 'sindrets/winshift.nvim' },
    { 'wellle/context.vim' },
    { 'hiphish/rainbow-delimiters.nvim' },
    { 'ryanoasis/vim-devicons' },
    { 'azabiong/vim-highlighter' },
    { 'lambdalisue/suda.vim' },
    { 'yimingwangdell/vim-translator' },
    { 'akinsho/toggleterm.nvim' },
    { 'ibhagwan/fzf-lua' },
    { 'vim-scripts/PreserveNoEOL' }
}, {})

vim.g.opencode_opts = {}

vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
    { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
    { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
    { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
    { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
    { desc = "Scroll opencode down" })

vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

require('lualine').setup(
    {
        options = {
            icons_enabled = true,
            theme = 'everforest',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
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
            lualine_b = { { 'branch', fmt = function(str) return str:sub(1, 20) end }, 'diff', },
            lualine_c = { { 'filename', path = 0, } },
            lualine_x = { {
                "aerial",
                -- The separator to be used to separate symbols in status line.
                sep = " ) ",

                -- The number of symbols to render top-down. In order to render only 'N' last
                -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                -- be used in order to render only current symbol.
                depth = nil,

                -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                -- a single icon that represents the kind of current symbol is rendered at
                -- the beginning of status line.
                dense = false,

                -- The separator to be used to separate symbols in dense mode.
                dense_sep = ".",

                -- Color the symbol icons.
                colored = true,
            } },
            lualine_y = {},
            lualine_z = { 'filesize', 'progress', 'encoding', 'fileformat' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = { { 'branch', }, 'diff', },
            lualine_c = { { 'filename', path = 0, } },
            lualine_x = {},
            lualine_x = { {
                "aerial",
                -- The separator to be used to separate symbols in status line.
                sep = " ) ",

                -- The number of symbols to render top-down. In order to render only 'N' last
                -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
                -- be used in order to render only current symbol.
                depth = nil,

                -- When 'dense' mode is on, icons are not rendered near their symbols. Only
                -- a single icon that represents the kind of current symbol is rendered at
                -- the beginning of status line.
                dense = false,

                -- The separator to be used to separate symbols in dense mode.
                dense_sep = ".",

                -- Color the symbol icons.
                colored = true,
            } },

            lualine_y = {},
            lualine_z = { 'progress', 'encoding', 'fileformat' }
        },
        tabline = {
            lualine_a = { { 'tabs', tabs_color = { active = 'StatusLineNC', inactive = { 'StatusLine' } } }, { 'filename', path = 3, shorting_target = 15 } },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'diagnostics' }
        },
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
)

require('blink.cmp').setup({
    signature = {
        enabled = true,
        trigger = {
            enabled = false,
            show_on_keyword = true,
            blocked_trigger_characters = {},
            blocked_retrigger_characters = {},
            show_on_trigger_character = true,
            show_on_insert = true,
            show_on_insert_on_trigger_character = true,
        },
    },
    keymap = {
        preset = 'enter',
        ['<C-space>'] = {
            function(cmp)
                cmp.show({ providers = { 'lsp', 'path', 'snippets', 'buffer' } })
            end,
            'show_documentation',
            'hide_documentation',
        },
        ['<C-k>'] = { 'show_signature' },
    },
    appearance = {
        nerd_font_variant = 'mono',
    },
    completion = {
        trigger = {
            prefetch_on_insert = false,
            show_on_backspace_after_accept = false,
            show_on_backspace_after_insert_enter = false,
            show_on_backspace_after_accept = false,
            show_on_keyword = true,
            show_on_trigger_character = false,
            show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
            show_on_accept_on_trigger_character = false,
            show_on_insert_on_trigger_character = false,
        },
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        menu = {
            draw = {
                treesitter = { 'lsp' },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },
    sources = {
        default = { 'buffer', 'snippets', 'path' },
        providers = {
            buffer = {
                module = 'blink.cmp.sources.buffer',
                score_offset = -3,
                opts = {
                    get_bufnrs = function()
                        return vim
                            .iter(vim.api.nvim_list_wins())
                            :map(function(win)
                                return vim.api.nvim_win_get_buf(win)
                            end)
                            :filter(function(buf)
                                return vim.bo[buf].buftype ~= 'nofile'
                            end)
                            :totable()
                    end,
                    get_search_bufnrs = function()
                        return { vim.api.nvim_get_current_buf() }
                    end,
                    max_sync_buffer_size = 400000,
                    max_async_buffer_size = 4000000,
                    max_total_buffer_size = 10000000,
                    retention_order = { 'focused', 'visible', 'recency', 'largest' },
                    use_cache = true,
                    enable_in_ex_commands = false,
                },
            },
        },
    },
    fuzzy = { implementation = 'lua' },
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
require('lspconfig').pylsp.setup({
    capabilities = capabilities,
})
require('lspconfig').bashls.setup({
    capabilities = capabilities,
})
require('lspconfig').clangd.setup({
    capabilities = capabilities,
})
require('lspconfig').jsonls.setup({
    capabilities = capabilities,
})
require('lspconfig').lemminx.setup({
    capabilities = capabilities,
})
require('lspconfig').yamlls.setup({
    capabilities = capabilities,
})
require('lspconfig').lua_ls.setup({
    capabilities = capabilities,
})

require('mason').setup()
require('trouble').setup()

require('aerial').setup({
    backends = { 'treesitter' },
    on_attach = function(bufnr)
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end,
    disable_max_lines = 30000,
    layout = {
        min_width = 60,
    },
})
vim.keymap.set('n', '<leader>tg', '<cmd>AerialToggle!<CR><c-w>l')
vim.keymap.set('n', '<leader>nv', '<cmd>AerialNavToggle<CR>')

require('nvim-treesitter.configs').setup({
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<leader><enter>',
            node_incremental = '<leader><enter>',
            scope_incremental = false,
            node_decremental = false,
        },
    },
    ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' },
    sync_install = false,
    auto_install = true,
    ignore_install = { 'javascript' },
    highlight = {
        enable = true,
        disable = { 'c', 'rust' },
        disable = function(lang, buf)
            local max_filesize = 1000 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
    },
})

require('treesitter-context').setup({
    enable = false,
    throttle = true,
    max_lines = 0,
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
    },
    exact_patterns = {},
})


require('orgmode').setup({
    org_agenda_files = { '~/Dropbox/org/*', '~/my-orgs/**/*' },
    org_default_notes_file = '~/Dropbox/org/refile.org',
})

local harpoon = require('harpoon')
harpoon:setup()
vim.keymap.set('n', '<leader>aa', function()
    harpoon:list():add()
end)
vim.keymap.set('n', '<leader>af', function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set('n', '<leader>ad', function()
    harpoon:list():clear()
end)
vim.keymap.set('n', '<leader>k', function()
    harpoon:list():prev()
end)
vim.keymap.set('n', '<leader>j', function()
    harpoon:list():next()
end)

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.map.on_attach.default(bufnr)
    -- custom mappings
    vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require('nvim-tree').setup({
    sort_by = 'case_sensitive',
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
        },
    },
    on_attach = my_on_attach,
})

local actions = require('diffview.actions')
require('diffview').setup({
    diff_binaries = false,
    enhanced_diff_hl = false,
    git_cmd = { 'git' },
    hg_cmd = { 'hg' },
    use_icons = true,
    show_help_hints = true,
    watch_index = true,
    icons = {
        folder_closed = '',
        folder_open = '',
    },
    signs = {
        fold_closed = '',
        fold_open = '',
        done = '✓',
    },
    view = {
        default = {
            layout = 'diff2_horizontal',
            disable_diagnostics = false,
            winbar_info = false,
        },
        merge_tool = {
            layout = 'diff3_horizontal',
            disable_diagnostics = true,
            winbar_info = true,
        },
        file_history = {
            layout = 'diff2_horizontal',
            disable_diagnostics = false,
            winbar_info = false,
        },
    },
    file_panel = {
        listing_style = 'tree',
        tree_options = {
            flatten_dirs = true,
            folder_statuses = 'only_folded',
        },
        win_config = {
            position = 'bottom',
            width = 35,
            height = 10,
            win_opts = {},
        },
    },
    file_history_panel = {
        log_options = {
            git = {
                single_file = {
                    diff_merges = 'combined',
                },
                multi_file = {
                    diff_merges = 'first-parent',
                },
            },
            hg = {
                single_file = {},
                multi_file = {},
            },
        },
        win_config = {
            position = 'bottom',
            height = 16,
            win_opts = {},
        },
    },
    commit_log_panel = {
        win_config = {},
    },
    default_args = {
        DiffviewOpen = {},
        DiffviewFileHistory = {},
    },
    hooks = {},
    keymaps = {
        disable_defaults = false,
        view = {
            { 'n', '<leader>nn', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
            { 'n', '<leader>pp', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
        },
    },
})

require('gitsigns').setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 1000,
        use_focus = true,
        virt_text = true,
        virt_text_pos = "eol",
        virt_text_priority = 100
    },
    current_line_blame_formatter = '<author_time:%R> | <author> | <summary>',
})

require('illuminate').configure({
    providers = {
        'regex',
    },
    delay = 100,
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = 10000,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
    should_enable = function(bufnr)
        return true
    end,
    case_insensitive_regex = false,
    disable_keymaps = false,
})

vim.g.VM_theme = 'iceblue'

vim.cmd('runtime macros/sandwich/keymap/surround.vim')

vim.g.bullets_enabled_file_types = {
    'markdown',
    'text',
    'gitcommit',
    'scratch',
}

require('nvim-autopairs').setup({})
require('hlslens').setup()



require('substitute').setup({
    highlight_substituted_text = {
        enabled = true,
        timer = 200,
    },
})
vim.keymap.set('n', 's', require('substitute').operator, { noremap = true })
vim.keymap.set('x', 's', require('substitute').visual, { noremap = true })

require('flash').setup({
    labels = 'asdfghjklqwertyuiopzxcvbnm',
    search = {
        multi_window = true,
        forward = true,
        wrap = true,
        mode = 'exact',
        incremental = false,
        exclude = {
            'notify',
            'cmp_menu',
            'noice',
            'flash_prompt',
            function(win)
                return not vim.api.nvim_win_get_config(win).focusable
            end,
        },
        trigger = '',
        max_length = false,
    },
    jump = {
        jumplist = true,
        pos = 'start',
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
        inclusive = nil,
        offset = nil,
    },
    label = {
        uppercase = true,
        exclude = '',
        current = true,
        after = true,
        before = false,
        style = 'overlay',
        reuse = 'lowercase',
        distance = true,
        min_pattern_length = 0,
        rainbow = {
            enabled = false,
            shade = 5,
        },
        format = function(opts)
            return { { opts.match.label, opts.hl_group } }
        end,
    },
    highlight = {
        backdrop = true,
        matches = true,
        priority = 5000,
        groups = {
            match = 'FlashMatch',
            current = 'FlashCurrent',
            backdrop = 'FlashBackdrop',
            label = 'FlashLabel',
        },
    },
    action = nil,
    pattern = '',
    continue = false,
    config = nil,
    modes = {
        search = {
            enabled = false,
            highlight = { backdrop = false },
            jump = { history = true, register = true, nohlsearch = true },
            search = {},
        },
        char = {
            enabled = true,
            config = function(opts)
                opts.autohide = opts.autohide or (vim.fn.mode(true):find('no') and vim.v.operator == 'y')
                opts.jump_labels = opts.jump_labels
                    and vim.v.count == 0
                    and vim.fn.reg_executing() == ''
                    and vim.fn.reg_recording() == ''
            end,
            autohide = false,
            jump_labels = true,
            multi_line = false,
            label = { exclude = 'hjkliardc' },
            keys = { 'f', 'F', 't', 'T', ';', ',' },
            char_actions = function(motion)
                return {
                    [';'] = 'next',
                    [','] = 'prev',
                    [motion:lower()] = 'next',
                    [motion:upper()] = 'prev',
                }
            end,
            search = { wrap = false, mode = 'exact' },
            highlight = { backdrop = true },
            jump = {
                register = false,
                autojump = false,
            },
        },
        treesitter = {
            labels = 'abcdefghijklmnopqrstuvwxyz',
            jump = { pos = 'range', autojump = true },
            search = { incremental = false },
            label = { before = true, after = true, style = 'inline' },
            highlight = {
                backdrop = false,
                matches = false,
            },
        },
        treesitter_search = {
            jump = { pos = 'range' },
            search = { multi_window = true, wrap = true, incremental = false },
            remote_op = { restore = true },
            label = { before = true, after = true, style = 'inline' },
        },
        remote = {
            remote_op = { restore = true, motion = true },
        },
    },
    prompt = {
        enabled = true,
        prefix = { { '⚡', 'FlashPromptIcon' } },
        win_config = {
            relative = 'editor',
            width = 1,
            height = 1,
            row = -1,
            col = 0,
            zindex = 1000,
        },
    },
    remote_op = {
        restore = false,
        motion = false,
    },
})

require("ibl").setup()

require('fzf-lua').setup({
    global_icon_columns = { 'gitstatus' },
    winopts = {
        height = 0.99,
        width = 0.99,
        preview = {
            vertical = 'down:40%',
        },
    },
    previewers = {
        aerial = {
            show_nesting = {
                ['_'] = false,
                json = true,
                yaml = true,
            },
        },
        codeaction = {
            -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
            diff_opts = { ctxlen = 3 },
        },
        codeaction_native = {
            diff_opts = { ctxlen = 3 },
            -- git-delta is automatically detected as pager, set `pager=false`
            -- to disable, can also be set under 'lsp.code_actions.preview_pager'
            -- recommended styling for delta
            --pager = [[delta --width=$COLUMNS --hunk-header-style="omit" --file-style="omit"]],
        },
    },
    defaults = {
        actions = { ["ctrl-q"] = { fn = require "fzf-lua".actions.file_sel_to_qf, prefix = "select-all" } },
        formatter = { "path.filename_first" }
    },
})

require('toggleterm').setup()

require('bqf').setup {
    auto_enable = false,
    auto_resize_height = true, -- highly recommended enable
    preview = {
        win_height = 12,
        win_vheight = 12,
        delay_syntax = 80,
        border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
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
            action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
            extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' }
        }
    }
}

local function get_type_hierarchy(method)
    vim.lsp.buf_request(0, 'textDocument/prepareTypeHierarchy', vim.lsp.util.make_position_params(), function(_, result)
        if not result then
            vim.notify_once('Does not support typeHierarchy', vim.log.levels.INFO)
            return
        end
        vim.lsp.buf_request(0, method, { item = result[1] }, function(_, res)
            if not res or #res == 0 then
                return
            end
            if #res == 1 then
                vim.lsp.util.jump_to_location(res[1], 'utf-8', true)
                return
            end
            vim.ui.select(res, {
                format_item = function(item)
                    local kind = vim.lsp.protocol.SymbolKind[item.kind] or 'Unknown'
                    return kind .. ': ' .. item.name
                end,
                prompt = 'Jump to definition',
            }, function(item)
                if item then
                    vim.lsp.util.jump_to_location(item, 'utf-8', true)
                end
            end)
        end)
    end)
end

vim.keymap.set('n', 'gp', function()
    get_type_hierarchy('typeHierarchy/supertypes')
end)

vim.api.nvim_create_autocmd({ 'CursorHold' }, {
    pattern = '*',
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = 'cursor',
            focusable = false,
            close_events = {
                'CursorMoved',
                'CursorMovedI',
                'BufHidden',
                'InsertCharPre',
                'WinLeave',
            },
        })
    end,
})



-- configuration
require("nvim-treesitter-textobjects").setup {
    select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V',  -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
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
}

-- keymaps
-- You can use the capture groups defined in `textobjects.scm`
vim.keymap.set({ "x", "o" }, "af", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ "x", "o" }, "as", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
end)
