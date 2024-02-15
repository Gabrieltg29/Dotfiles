return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      opts = {
				ensure_installed = {
	  			"black",
	  			"debugpy",
	  			"mypy",
	  			"ruff",
	  			"pyright",
				}
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    opts = {},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
			vim.keymap.set('n', 'gs', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
			vim.keymap.set('n', 'gS', vim.lsp.buf.signature_help, opts)
			vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)

			lspconfig.pyright.setup {
				{
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true
						}
					}
				},
				capabilities = capabilities,
			}
			lspconfig.rust_analyzer.setup {
				capabilities = capabilities,
			}
			lspconfig.tsserver.setup {
				capabilities = capabilities,
			}
		end
  }
}
