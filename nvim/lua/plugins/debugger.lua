return {
	"mfussenegger/nvim-dap",
	keys = {
		{ "<F5>", function() require("dap").continue() end, desc = "DAP continue" },
		{ "<F10>", function() require("dap").step_over() end, desc = "DAP step over" },
		{ "<F11>", function() require("dap").step_into() end, desc = "DAP step into" },
		{ "<F12>", function() require("dap").step_out() end, desc = "DAP step out" },
		{ "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "DAP toggle breakpoint" },
		{
			"<leader>B",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "DAP set conditional breakpoint",
		},
		{ "<leader>dr", function() require("dap").repl.open() end, desc = "DAP open REPL" },
		{ "<leader>dl", function() require("dap").run_last() end, desc = "DAP run last" },
		{ "<leader>du", function() require("dapui").toggle() end, desc = "DAP toggle UI" },
		{ "<leader>dx", function() require("dap").terminate() end, desc = "DAP terminate" },
	},
	dependencies = {
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"jay-babu/mason-nvim-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local mason_path = vim.fn.stdpath("data") .. "/mason"
		local js_debug_path = mason_path .. "/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
		local codelldb_path = mason_path .. "/bin/codelldb"
		local debugpy_path = mason_path .. "/packages/debugpy/venv/bin/python"

		require("mason-nvim-dap").setup({
			ensure_installed = { "delve", "codelldb", "js-debug-adapter", "python" },
			automatic_installation = true,
		})
		require("nvim-dap-virtual-text").setup({})

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual", numhl = "" })

		-- Python
		require("dap-python").setup(debugpy_path)
		dap.adapters.python = {
			type = "server",
			host = "localhost",
			port = 5678,
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "attach",
				name = "Python: Attach localhost:5678",
				connect = {
					host = "127.0.0.1",
					port = 5678,
				},
				pathMappings = {
					{
						localRoot = vim.fn.getcwd(),
						remoteRoot = "/app",
					},
				},
			},
			{
				type = "python",
				request = "launch",
				name = "Python: Launch current file",
				program = "${file}",
				console = "integratedTerminal",
			},
		}

		-- Go
		dap.adapters.go = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}
		dap.configurations.go = {
			{
				type = "go",
				name = "Go: Debug package",
				request = "launch",
				program = "${workspaceFolder}",
			},
			{
				type = "go",
				name = "Go: Debug current file",
				request = "launch",
				program = "${file}",
			},
			{
				type = "go",
				name = "Go: Attach local process",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}

		-- Rust + Zig (codelldb)
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = codelldb_path,
				args = { "--port", "${port}" },
			},
		}
		dap.configurations.rust = {
			{
				name = "Rust: Launch executable",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.zig = {
			{
				name = "Zig: Launch executable",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- JavaScript / TypeScript (Node + Browser)
		for _, adapter in ipairs({ "pwa-node", "pwa-chrome", "node-terminal" }) do
			dap.adapters[adapter] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path, "${port}" },
				},
			}
		end

		local js_ts_filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte" }
		for _, language in ipairs(js_ts_filetypes) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Node: Launch current file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Node: Attach process",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Web: Chrome localhost:5173",
					url = "http://localhost:5173",
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
				},
			}
		end

		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

	end,
}
