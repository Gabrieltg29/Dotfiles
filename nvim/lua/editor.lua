vim.g.mapleader = " "

local configs = {
	clipboard = "unnamedplus",
	relativenumber = true,
	foldmethod = "indent",
	swapfile = false,
	colorcolumn = "80",
	ignorecase = true,
	number = true,
	scrolloff = 5,
	wildignore = "*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite",
	updatetime = 500,
}

for k, v in pairs(configs) do
	vim.opt[k] = v
end
vim.cmd("syntax enable")

local function map(mode, lhs, rhs, desc, opts)
	local options = vim.tbl_extend("force", {
		noremap = true,
		silent = true,
		desc = desc,
	}, opts or {})
	vim.keymap.set(mode, lhs, rhs, options)
end

map({ "n", "v" }, ">", ">gv", "Indent right and keep selection")
map({ "n", "v" }, "<", "<gv", "Indent left and keep selection")
map("n", "<C-j>", ":m .+1<CR>==", "Move line down")
map("n", "<C-k>", ":m .-2<CR>==", "Move line up")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("n", "<C-b>", "<Cmd>Neotree toggle<CR>", "Toggle Neo-tree")
map("n", "<leader>cr", "<Cmd>%s/\\r//g<CR>", "Remove carriage returns")


vim.diagnostic.config(
	{
		virtual_text = { current_line = true }
	}
)
