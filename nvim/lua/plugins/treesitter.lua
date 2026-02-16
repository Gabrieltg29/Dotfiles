return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
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
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
	},
	-- config = function(_, opts)
	-- 	require("nvim-treesitter.configs").setup(opts)
	-- end,
}
