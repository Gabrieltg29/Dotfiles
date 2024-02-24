local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		require("plugins.neodev"),
		require("plugins.mason"),
		require("plugins.treesitter"),
		require("plugins.neo_tree"),
		require("plugins.neogen"),
		require("plugins.telescope"),
		require("plugins.cmp"),
		require("plugins.colorscheme"),
		require("plugins.format"),
		require("plugins.mini_comment"),
		require("plugins.lualine"),
	},
})
