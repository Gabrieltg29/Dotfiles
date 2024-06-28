return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				typescript = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } }, -- Irá tentar buscar o primeiro que encontrar
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
			notify_on_error = true,
		})
	end,
}
