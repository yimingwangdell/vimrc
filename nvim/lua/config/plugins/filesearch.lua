local m = { noremap = true }
return {
	"ibhagwan/fzf-lua",
	keys = { "<c-j>" },
	config = function()
		local fzf = require('fzf-lua')
		local actions = require "fzf-lua.actions"
		vim.keymap.set('n', '<c-j>', function()
			-- fzf.live_grep_resume({ multiprocess = true, debug = true })
			fzf.grep({ search = "", fzf_opts = { ['--layout'] = 'default' } })
		end, m)
		vim.keymap.set('x', '<c-j>', function()
			-- fzf.live_grep_resume({ multiprocess = true, debug = true })
			fzf.grep_visual({ fzf_opts = { ['--layout'] = 'default' } })
		end, m)
		fzf.setup({
			global_resume = true,
			global_resume_query = true,
			winopts = {
				height     = 1,
				width      = 1,
				preview    = {
					layout = 'vertical',
					scrollbar = 'float',
				},
				fullscreen = true,
				vertical   = 'down:45%', -- up|down:size
				horizontal = 'right:60%', -- right|left:size
				hidden     = 'nohidden',
			},
			keymap = {
				builtin = {
					["<c-p>"] = "toggle-preview",
					["<c-l>"] = "preview-page-down",
					["<c-h>"] = "preview-page-up",
				},
				fzf = {
					["esc"]    = "abort",
					["ctrl-j"] = "down",
					["ctrl-k"] = "up",
				},
			},
			actions = {
				files = {
					["default"] = actions.file_tabedit,
				}
			},
			previewers = {
				head = {
					cmd  = "head",
					args = nil,
				},
				git_diff = {
					cmd_deleted   = "git diff --color HEAD --",
					cmd_modified  = "git diff --color HEAD",
					cmd_untracked = "git diff --color --no-index /dev/null",
					-- pager        = "delta",      -- if you have `delta` installed
				},
				man = {
					cmd = "man -c %s | col -bx",
				},
				builtin = {
					syntax         = true,   -- preview syntax highlight?
					syntax_limit_l = 0,      -- syntax limit (lines), 0=nolimit
					syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
				},
			},
			files = {
				-- previewer      = "bat",          -- uncomment to override previewer
				-- (name from 'previewers' table)
				-- set to 'false' to disable
				prompt       = 'Files❯ ',
				multiprocess = true, -- run command in a separate process
				git_icons    = true, -- show git icons?
				file_icons   = true, -- show file icons?
				color_icons  = true, -- colorize file|git icons
				-- executed command priority is 'cmd' (if exists)
				-- otherwise auto-detect prioritizes `fd`:`rg`:`find`
				-- default options are controlled by 'fd|rg|find|_opts'
				-- NOTE: 'find -printf' requires GNU find
				-- cmd            = "find . -type f -printf '%P\n'",
				find_opts    = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts      = "--color=never --files --hidden --follow -g '!.git'",
				fd_opts      = "--color=never --type f --hidden --follow --exclude .git",
			},
			buffers = {
				prompt        = 'Buffers❯ ',
				file_icons    = true, -- show file icons?
				color_icons   = true, -- colorize file|git icons
				sort_lastused = true, -- sort buffers() by last used
			},
		})
	end

}
