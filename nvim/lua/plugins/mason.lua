return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			local opts = {
				ensure_installed = {
					"lua_ls",
					"pyright",
				},
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local opts = {}
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local on_attach = function(_, bufnr)
				opts.buffer = bufnr
				vim.print(bufnr)
				vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "gs", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>lw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
			end

			lspconfig["pyright"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["html"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
}
