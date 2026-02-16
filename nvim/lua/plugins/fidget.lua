return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	keys = {
		{
			"<leader>fn",
			function()
				require("fidget").notify("This is from fidget.notify().")
			end,
			desc = "Fidget notify",
		},
	},
	config = function()
		local fidget = require("fidget")
		fidget.setup({
			progress = {
				ignore_done_already = true,
				display = {
					done_icon = "✔️",
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			},
		})
	end,
}
