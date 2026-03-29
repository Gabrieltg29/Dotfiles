local lsp_servers = {
	"lua_ls",
	"pyright",
	"vtsls",
	"vue_ls",
	"angularls",
	"svelte",
	"tailwindcss",
	"eslint",
	"cssls",
	"jsonls",
	"emmet_ls",
	"zls",
	"html",
	"gopls",
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
			local function source_action(bufnr, kinds)
				vim.lsp.buf.code_action({
					bufnr = bufnr,
					apply = true,
					context = {
						only = kinds,
						diagnostics = {},
					},
				})
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.window = {
				workDoneProgress = true,
			}

			local on_attach = function(_, bufnr)
				local keymap_opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", keymap_opts, { desc = "LSP definition" }))
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", keymap_opts, { desc = "LSP declaration" }))
				vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", keymap_opts, { desc = "LSP references" }))
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", keymap_opts, { desc = "LSP implementation" }))
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", keymap_opts, { desc = "LSP type definition" }))
				vim.keymap.set("n", "gs", vim.lsp.buf.hover, vim.tbl_extend("force", keymap_opts, { desc = "LSP hover" }))
				vim.keymap.set("n", "gS", vim.lsp.buf.signature_help, vim.tbl_extend("force", keymap_opts, { desc = "LSP signature help" }))
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", keymap_opts, { desc = "LSP rename" }))
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", keymap_opts, { desc = "LSP code action" }))
				vim.keymap.set("n", "<leader>ee", vim.diagnostic.open_float, vim.tbl_extend("force", keymap_opts, { desc = "Line diagnostics" }))
				vim.keymap.set("n", "<leader>lw", vim.lsp.buf.document_symbol, vim.tbl_extend("force", keymap_opts, { desc = "LSP document symbols" }))
				vim.keymap.set("n", "<leader>ai", function()
					source_action(bufnr, {
						"source.addMissingImports.ts",
						"source.addMissingImports",
					})
				end, vim.tbl_extend("force", keymap_opts, { desc = "Add missing imports" }))
				vim.keymap.set("n", "<leader>oi", function()
					source_action(bufnr, {
						"source.organizeImports.ts",
						"source.organizeImports",
					})
				end, vim.tbl_extend("force", keymap_opts, { desc = "Organize imports" }))

				if vim.bo[bufnr].filetype == "typescript"
					or vim.bo[bufnr].filetype == "typescriptreact"
					or vim.bo[bufnr].filetype == "javascript"
					or vim.bo[bufnr].filetype == "javascriptreact"
					or vim.bo[bufnr].filetype == "vue"
					or vim.bo[bufnr].filetype == "svelte"
				then
					local group = vim.api.nvim_create_augroup("lspAutoImports", { clear = false })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = group,
						buffer = bufnr,
						callback = function()
							source_action(bufnr, {
								"source.addMissingImports.ts",
								"source.organizeImports.ts",
								"source.organizeImports",
							})
						end,
					})
				end
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
			local pyright_settings = {
				settings = {
					python = {
						analysis = {
							autoImportCompletions = true,
						},
					},
				},
			}
			local vtsls_settings = {
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				settings = {
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
					},
					javascript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
					},
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
				},
			}
			local vue_ls_settings = {
				filetypes = { "vue" },
			}

			local has_new_lsp_api = vim.lsp.config ~= nil and vim.lsp.enable ~= nil
			if has_new_lsp_api then
				-- Neovim 0.11+
				vim.lsp.config("*", {
					capabilities = capabilities,
					on_attach = on_attach,
				})

				vim.lsp.config("lua_ls", lua_ls_settings)
				vim.lsp.config("pyright", pyright_settings)
				vim.lsp.config("vtsls", vtsls_settings)
				vim.lsp.config("vue_ls", vue_ls_settings)
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
				elseif server == "pyright" then
					opts = vim.tbl_deep_extend("force", opts, pyright_settings)
				elseif server == "vtsls" then
					opts = vim.tbl_deep_extend("force", opts, vtsls_settings)
				elseif server == "vue_ls" then
					opts = vim.tbl_deep_extend("force", opts, vue_ls_settings)
				end
				lspconfig[server].setup(opts)
			end
		end,
	},
}
