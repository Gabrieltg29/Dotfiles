return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- necessário para melhor performance
		cmd = {
			"CopilotChat",
			"CopilotChatToggle",
			"CopilotChatExplain",
			"CopilotChatFix",
			"CopilotChatOptimize",
			"CopilotChatDocs",
			"CopilotChatTests",
		},
		keys = {
			{ "<leader>cc", "<Cmd>CopilotChatToggle<CR>", desc = "CopilotChat toggle" },
			{ "<leader>ce", "<Cmd>CopilotChatExplain<CR>", desc = "CopilotChat explain" },
			{ "<leader>cf", "<Cmd>CopilotChatFix<CR>", desc = "CopilotChat fix" },
			{ "<leader>co", "<Cmd>CopilotChatOptimize<CR>", desc = "CopilotChat optimize" },
			{ "<leader>cd", "<Cmd>CopilotChatDocs<CR>", desc = "CopilotChat docs" },
			{ "<leader>ct", "<Cmd>CopilotChatTests<CR>", desc = "CopilotChat tests" },
			{ "<leader>cc", "<Cmd>CopilotChat<CR>", mode = "v", desc = "CopilotChat with selection" },
		},
		opts = {
			debug = false,
			model = "gpt-5.2-codex",
			-- mcp = {
			-- 	enabled = true,
			-- 	servers = {
			-- 		remoto = {
			-- 			transport = "http",
			-- 			url = "https://mcp.seuservidor.com",
			-- 			headers = {
			-- 				Authorization = "Bearer " .. os.getenv("MCP_JWT_TOKEN"),
			-- 			},
			-- 		},
			-- 	},
			-- },
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
		end,
	},
}
