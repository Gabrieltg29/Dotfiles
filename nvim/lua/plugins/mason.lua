return {
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
}
