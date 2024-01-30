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
				}
			}
			lspconfig.rust_analyzer.setup {}
			lspconfig.tsserver.setup {}
		end
  }
}
