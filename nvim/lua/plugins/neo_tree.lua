return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			window = {
				width = 30,
			},
			source_selector = {
				winbar = true,
				statusline = false,
				show_scrolled_off_parent_node = false,
				sources = { -- table
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
