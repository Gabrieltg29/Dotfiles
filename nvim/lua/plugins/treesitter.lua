return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
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

		require("nvim-treesitter").setup({})
		require("nvim-treesitter").install(languages)
	end,
}
