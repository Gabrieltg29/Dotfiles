return {
	"ellisonleao/glow.nvim",
	cmd = "Glow",
	ft = { "markdown" },
	config = function()
		require("glow").setup({})
	end
}
