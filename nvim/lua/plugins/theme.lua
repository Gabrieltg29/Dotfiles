return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- transparent_background = true,
			})
		end,
	},
		{
			"scottmckendry/cyberdream.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("cyberdream").setup({})
				vim.cmd("colorscheme cyberdream")
				vim.keymap.set("n", "<leader>tt", "<Cmd>CyberdreamToggleMode<CR>", {
					noremap = true,
					silent = true,
					desc = "Toggle theme mode",
				})
			end
		}
	}
