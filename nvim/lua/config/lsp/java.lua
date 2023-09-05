return {
	setup = function(lspconfig, lsp)
		-- lspconfig.java_language_server.setup {}
		lspconfig.jdtls.setup {
			root_dir = function()
				return vim.fs.dirname(vim.fs.find({ 'build.gradle' }, { upward = true })[1])
			end,
			settings = {
				java = {
					configuration = {
						-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
						-- And search for `interface RuntimeOption`
						-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
						runtimes = {
							{
								name = "JavaSE-11",
								path = "/usr/lib/jvm/java-11-openjdk/",
							},
							{
								name = "JavaSE-17",
								path = "/usr/lib/jvm/java-17-openjdk/",
							},
						}
					},
					project = {
						referencedLibraries = {
							'/home/yimingwang/workspace/projects/storage/datasvc/objcontrolsvc/build/libs/storageos-objcontrolsvc.jar'
						}
					}
				}
			}

		}
	end
}
