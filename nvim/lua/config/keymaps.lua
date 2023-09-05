vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
	{ from = "S", to = ":w<CR>" },
	{ from = "Q", to = ":q<CR>" },
	{
		from = ";",
		to = ":",
		mode =
				mode_nv
	},
	{
		from = "Y",
		to = "\"+y",
		mode =
				mode_v
	},

	-- Movement
	{ from = "K",         to = "5k",                                                 mode = mode_nv },
	{ from = "J",         to = "5j",                                                 mode = mode_nv },
	{ from = "H",         to = "0",                                                  mode = mode_nv },
	{ from = "L",         to = "$",                                                  mode = mode_nv },
	{ from = "c,.",       to = "c%", },


	-- Useful actions
	{ from = ",.",        to = "%",                                                  mode = mode_nv },
	{ from = "<c-o>",     to = "<ESC>A {}<ESC>i<CR><ESC>ko",                         mode = mode_i },
	{ from = "<c-a>",     to = "<ESC>A",                                             mode = mode_i },
	{ from = "\\v",       to = "v$h", },

	-- Actions

	-- Useful actions

	-- Window & splits
	{ from = "<leader>k", to = "<C-w>k", },
	{ from = "<leader>j", to = "<C-w>j", },
	{ from = "<leader>h", to = "<C-w>h", },
	{ from = "<leader>l", to = "<C-w>l", },
	{ from = "qf",        to = "<C-w>o", },
	{ from = "s",         to = "<nop>", },
	{ from = "yw",        to = "yiw", },
	{ from = "sl",        to = ":set nosplitright<CR>:set splitright<CR>:vnew <CR>", },
	{ from = "sj",        to = ":set nosplitbelow<CR>:set splitbelow<CR>:new <CR>", },
	{ from = 'R',         to = ":luafile ~/.config/nvim/init.lua<CR>" },
	{
		from = "Y",
		to = "y$",
		mode =
				mode_n
	},
	{
		from = "gb",
		to = "<c-t>",
		mode =
				mode_n
	},
	-- Tab management
	{ from = "ti",         to = ":tabe<CR>", },
	{ from = "tI",         to = ":tab split<CR>", },
	{ from = "th",         to = ":-tabnext<CR>", },
	{ from = "tl",         to = ":+tabnext<CR>", },
	{ from = "tmh",        to = ":-tabmove<CR>", },
	{ from = "tml",        to = ":+tabmove<CR>", },


	-- Other
	{ from = "<leader>pr", to = ":profile start profile.log<CR>:profile func *<CR>:profile file *<CR>" },
	{ from = "sv",         to = ":set nosplitright<CR>:set splitright<CR>:vnew ~/.config/nvim/lua/config/plugins.lua<CR>" },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
