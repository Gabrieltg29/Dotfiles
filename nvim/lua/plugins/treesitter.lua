return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"astro",
			"cmake",
			"cpp",
			"css",
			"fish",
			"gitignore",
			"go",
			"graphql",
			"http",
			"lua",
			"java",
			"php",
			"rust",
			"scss",
			"sql",
			"svelte",
			"python",
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
