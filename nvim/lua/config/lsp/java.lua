return {
	setup = function(lspconfig, lsp)
		lspconfig.jdtls.setup {
			cmd = {
				"/usr/lib64/jvm/jdk-11.0.19/bin/java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				"/root/workspace/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
				"-configuration",
				"/root/workspace/jdtls/config_linux",
				"-data",
				"/root/workspace/jdtls/workspace/folder"
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
			settings = {
				java = {}
			},
			init_options = {
				bundles = {}
			}
		}
	end
}
