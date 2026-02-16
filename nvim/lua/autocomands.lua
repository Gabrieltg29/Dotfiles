local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

augroup("setIndent", { clear = true })
autocmd("FileType", {
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
		"json",
		"svelte",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd("LspAttach", {
	callback = function(args)
		if args.data and args.data.client_id then
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client and client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
		end
	end
})
