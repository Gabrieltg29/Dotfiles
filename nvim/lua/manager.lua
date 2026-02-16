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
		require("plugins.autopairs"),
		require("plugins.autotag"),
		require("plugins.neodev"),
		require("plugins.mason"),
		require("plugins.treesitter"),
		require("plugins.neo_tree"),
		require("plugins.neogen"),
		require("plugins.telescope"),
		require("plugins.theme"),
		require("plugins.format"),
		require("plugins.mini_comment"),
		require("plugins.lualine"),
		require("plugins.lsp_signature"),
		require("plugins.rust_acean"),
		require("plugins.golang"),
		require("plugins.remote_sshfs"),
		require("plugins.cmp"),
		require("plugins.fidget"),
		require("plugins.tailwind"),
		require("plugins.ident_blackline"),
		require("plugins.glow"),
		require("plugins.debugger"),
		require("plugins.copilot")
	},
})
