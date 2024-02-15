vim.g.mapleader = ";"


local configs = {
	clipboard = "unnamedplus",
	relativenumber = true,
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

local mappings = {
	-- indent and keep selection
	{ "", ">", ">gv", {} },
	{ "", "<", "<gv", {} },
	-- move lines up and down
	{ "n", "<C-j>", ":m .+1<CR>==" },
	{ "n", "<C-k>", ":m .-2<CR>==" },
	{ "v", "K", ":m '<-2<CR>gv=gv" },
	{ "v", "J", ":m '>+1<CR>gv=gv" },
}

for _, v in pairs(mappings) do
		vim.keymap.set(unpack(v))
end

