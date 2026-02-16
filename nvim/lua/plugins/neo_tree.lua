return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	init = function()
		-- Prefer Neo-tree over netrw when opening a directory (e.g. `nvim .`)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local arg = vim.fn.argv(0)
				if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
					vim.cmd("Neotree current dir=" .. vim.fn.fnameescape(arg))
				end
			end,
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "open_default",
			},
			window = {
				width = 30,
			},
			source_selector = {
				statusline = true,
				sources = {
					{
						source = "filesystem",
						display_name = " 󰉓 Files ",
					},
					{
						source = "buffers",
						display_name = " 󰈚 Buffers ",
					},
					{
						source = "git_status",
						display_name = " 󰊢 Git ",
					},
				},
			},
		})
	end,
}
