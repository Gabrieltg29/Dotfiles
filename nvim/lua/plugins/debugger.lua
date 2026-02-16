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
	},
	dependencies = {
		"mfussenegger/nvim-dap-python", -- integração Python
		"rcarriga/nvim-dap-ui",       -- UI bonitinha
		"nvim-neotest/nvim-nio"       -- dep. do dap-ui
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Adaptador para Python (debugpy)
		dap.adapters.python = {
			type = "server",
			host = "localhost",
			port = 5678, -- mesma porta que você expôs no docker-compose
		}

		dap.configurations.python = {
			{
				type = "python",
				request = "attach",
				name = "Attach to Docker Flask",
				connect = {
					host = "127.0.0.1",
					port = 5678,
				},
				mode = "remote",
				pathMappings = {
					{
						localRoot = vim.fn.getcwd(), -- pasta do projeto no host
						remoteRoot = "/app",   -- pasta montada dentro do container
					},
				},
			},
		}

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
