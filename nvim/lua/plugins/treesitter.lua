return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local installed = ts.get_installed("parsers")
		if not vim.list_contains(installed, "svelte") then
			vim.schedule(function()
				pcall(ts.install, { "svelte" }, { summary = false })
			end)
		end
	end,
}
