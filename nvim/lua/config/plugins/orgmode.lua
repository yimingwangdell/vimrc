return {
	{
		'nvim-orgmode/orgmode',
		dependencies = {
			{ 'nvim-treesitter/nvim-treesitter', lazy = true },
		},
		event = 'VeryLazy',
		config = function()
			-- Load treesitter grammar for org
			require('orgmode').setup_ts_grammar()

			-- Setup treesitter
			require('nvim-treesitter.configs').setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { 'org' },
				},
				ensure_installed = { 'org' },
			})

			-- Setup orgmode
			require('orgmode').setup({
				org_agenda_files = '~/orgfiles/**/*',
				org_default_notes_file = '~/orgfiles/refile.org',
			})
			local cmp = require 'cmp'
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end
			require('cmp').setup({
				sources = {
					{ name = 'orgmode' }
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() then
								cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end,
					}),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
			})
		end,
	}
}
