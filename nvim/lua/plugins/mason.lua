local lsp_servers = {
	"lua_ls",
	"pyright",
	"svelte",
	"tailwindcss",
	"zls",
	"html",
	"gopls",
	"jedi_language_server",
}
return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = lsp_servers,
				automatic_enable = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.window = {
				workDoneProgress = true,
			}

			local on_attach = function(_, bufnr)
				local keymap_opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gs", vim.lsp.buf.hover, vim.tbl_extend("force", keymap_opts, { desc = "LSP hover" }))
				vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", keymap_opts, { desc = "LSP implementation" }))
				vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, vim.tbl_extend("force", keymap_opts, { desc = "LSP signature help" }))
				vim.keymap.set("n", "gD", vim.lsp.buf.definition, vim.tbl_extend("force", keymap_opts, { desc = "LSP definition" }))
				vim.keymap.set("n", "<leader>lw", vim.lsp.buf.document_symbol, vim.tbl_extend("force", keymap_opts, { desc = "LSP document symbols" }))
				vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, vim.tbl_extend("force", keymap_opts, { desc = "Line diagnostics" }))
			end

			local lua_ls_settings = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			local has_new_lsp_api = vim.lsp.config ~= nil and vim.lsp.enable ~= nil
			if has_new_lsp_api then
				-- Neovim 0.11+
				vim.lsp.config("*", {
					capabilities = capabilities,
					on_attach = on_attach,
				})

				vim.lsp.config("lua_ls", lua_ls_settings)
				vim.lsp.enable(lsp_servers)
				return
			end

			-- Neovim 0.10 fallback
			local lspconfig = require("lspconfig")
			for _, server in ipairs(lsp_servers) do
				local opts = {
					capabilities = capabilities,
					on_attach = on_attach,
				}
				if server == "lua_ls" then
					opts = vim.tbl_deep_extend("force", opts, lua_ls_settings)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
}
