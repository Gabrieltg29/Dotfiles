return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			log_level = vim.log.levels.DEBUG,
			-- formatters = {
			-- 	djlint = {
			-- 		command = "djlint",
			-- 		args = { "$FILENAME", "--reformat", "--indent", "2" },
			-- 		stdout = false
			-- 	}
			-- },
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				htmldjango = { "djlint" },
				typescript = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier" }, -- Irá tentar buscar o primeiro que encontrar
				typescriptreact = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				svelte = { "prettier" },
				vue = { "prettier" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
			notify_on_error = true,
		})
	end,
}
