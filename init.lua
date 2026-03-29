vim.lsp.config["lua-language-server"] = {
	cmd = { "~/.local/share/nvim/mason/bin/lua-language-server" },
	root_markers = { ".luarc.json" },
	filetypes = { "lua" }
}

vim.lsp.enable("lua-language-server")


vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(cv)
		local client = vim.lsp.get_client_by_id(cv.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, cv.buf, { autotrigger = true })
		end
	end,
})

vim.cmd("set completeopt+=noselect")


vim.o.winborder = "rounded"

vim.diagnostic.config({
	virtual_text = { current_line = true }
})
