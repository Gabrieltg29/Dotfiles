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
			vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
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
