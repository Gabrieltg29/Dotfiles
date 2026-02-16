return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local install_dir = vim.fn.stdpath("data") .. "/site"
		local languages = {
			"astro",
			"cmake",
			"cpp",
			"css",
			"fish",
			"gitignore",
			"go",
			"graphql",
			"http",
			"javascript",
			"lua",
			"java",
			"php",
			"python",
			"rust",
			"scss",
			"sql",
			"svelte",
			"tsx",
			"typescript",
		}

		require("nvim-treesitter").setup({
			install_dir = install_dir,
		})

		local ok, task = pcall(require("nvim-treesitter").install, languages)
		if ok and task and type(task.wait) == "function" then
			pcall(task.wait, task, 120000)
		end
	end,
}
