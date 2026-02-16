local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

augroup("setIndent", { clear = true })
autocmd("FileType", {
	group = "setIndent",
	pattern = {
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"lua",
		"markdown",
		"md",
		"typescript",
		"typescriptreact",
		"scss",
		"xml",
		"xhtml",
		"yaml",
		"lua",
		"json",
		"svelte",
		"vue",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

autocmd({ "BufRead", "BufNewFile" }, {
	group = "setIndent",
	pattern = { "*.svelte" },
	callback = function()
		vim.bo.filetype = "svelte"
	end,
})

autocmd("FileType", {
	group = "setIndent",
	pattern = {
		"astro",
		"css",
		"go",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"lua",
		"python",
		"rust",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
		"zig",
	},
	callback = function()
		local has_parser = pcall(vim.treesitter.get_parser, 0)
		if has_parser then
			pcall(vim.treesitter.start)
		elseif vim.bo.filetype == "svelte" then
			-- Fallback syntax highlight when parser is missing/unavailable.
			vim.bo.syntax = "html"
		end
		pcall(function()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end)
	end,
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

augroup("ideWorkflow", { clear = true })

autocmd("TextYankPost", {
	group = "ideWorkflow",
	callback = function()
		vim.highlight.on_yank({ timeout = 180 })
	end,
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = "ideWorkflow",
	command = "checktime",
})

autocmd("BufReadPost", {
	group = "ideWorkflow",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd("FileType", {
	group = "ideWorkflow",
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd("FileType", {
	group = "ideWorkflow",
	pattern = {
		"help",
		"man",
		"qf",
		"lspinfo",
		"checkhealth",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<Cmd>close<CR>", {
			buffer = event.buf,
			noremap = true,
			silent = true,
			desc = "Close window",
		})
	end,
})
