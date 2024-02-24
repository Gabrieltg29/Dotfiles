local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

augroup("setIndent", { clear = true })
autocmd("Filetype", {
	group = "setIndent",
	pattern = {
		"css",
		"html",
		"javascript",
		"lua",
		"markdown",
		"md",
		"typescript",
		"scss",
		"xml",
		"xhtml",
		"yaml",
		"lua",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})
