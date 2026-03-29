return {
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	lazy = false, -- This plugin is already lazy
	init = function()
		local function rust_analyzer_cmd()
			local mason_rust_analyzer = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
			if vim.uv.fs_stat(mason_rust_analyzer) then
				return { mason_rust_analyzer }
			end
			return { "rust-analyzer" }
		end

		local function rustacean_codelldb_adapter()
			local mason_root = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
			local codelldb = mason_root .. "/adapter/codelldb"
			local liblldb = mason_root .. "/lldb/lib/liblldb.so"

			if vim.fn.has("mac") == 1 then
				liblldb = mason_root .. "/lldb/lib/liblldb.dylib"
			elseif vim.fn.has("win32") == 1 then
				codelldb = codelldb .. ".exe"
				liblldb = mason_root .. "/lldb/bin/liblldb.dll"
			end

			if vim.uv.fs_stat(codelldb) and vim.uv.fs_stat(liblldb) then
				return require("rustaceanvim.config").get_codelldb_adapter(codelldb, liblldb)
			end

			if vim.fn.executable("codelldb") == 1 then
				return {
					type = "server",
					host = "127.0.0.1",
					port = "${port}",
					executable = {
						command = "codelldb",
						args = { "--port", "${port}" },
					},
				}
			end

			return false
		end

		vim.g.rustaceanvim = {
			server = {
				cmd = rust_analyzer_cmd,
			},
			dap = {
				adapter = rustacean_codelldb_adapter,
			},
		}
	end,
}
