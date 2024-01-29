return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
	require("neo-tree").setup({
  source_switcher = {
    enable = true,
    tabs_default = { icon = "裡", hl = "NeoTreeTitleBar", hl_active = "NeoTreeModified" },
    tabs = { -- could be table or string (=icon), missing keys fall back to `tabs_default`
      filesystem = { icon = "", text = "Files", hl = "ErrorMsg" },
      -- buffers = "", -- no need to specify all sources (will use default then)
      git_status = "", -- no icon
    },
    -- not implemented but maybe nice to have configs
    justify = "center", -- start, end, center, between, around (idea from bootstrap https://getbootstrap.com/docs/4.0/utilities/flex/#justify-content)
  },
})
    end,
}
