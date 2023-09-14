return {
	"ycm-core/YouCompleteMe",
	config = function()

	end,
	opts = {
		git = {
			-- defaults for the `Lazy log` command
			-- log = { "-10" }, -- show the last 10 commits
			log = { "-8" }, -- show commits from the last 3 days
			timeout = false, -- kill processes that take more than 2 minutes
			url_format = "https://github.com/%s.git",
			-- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
			-- then set the below to false. This should work, but is NOT supported and will
			-- increase downloads a lot.
			filter = true,
		},
	}
}
