return { 
    "danymat/neogen", 
    dependencies = "nvim-treesitter/nvim-treesitter", 
    config = true,
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({ type = 'class' })
				end,
				desc = "Neogen Comment",
			},
		},
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
}
