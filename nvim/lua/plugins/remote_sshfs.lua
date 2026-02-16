return {
	"nosduco/remote-sshfs.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{
			"<leader>rc",
			function()
				require("remote-sshfs.api").connect()
			end,
			desc = "Remote SSHFS connect",
		},
		{
			"<leader>rd",
			function()
				require("remote-sshfs.api").disconnect()
			end,
			desc = "Remote SSHFS disconnect",
		},
		{
			"<leader>re",
			function()
				require("remote-sshfs.api").edit()
			end,
			desc = "Remote SSHFS edit",
		},
		{
			"<leader>rf",
			function()
				local api = require("remote-sshfs.api")
				local connections = require("remote-sshfs.connections")
				local builtin = require("telescope.builtin")
				if type(connections.is_connected) == "function" and connections.is_connected() then
					api.find_files()
				elseif connections.is_connected then
					api.find_files()
				else
					builtin.find_files()
				end
			end,
			desc = "Find files (remote-aware)",
		},
		{
			"<leader>rg",
			function()
				local api = require("remote-sshfs.api")
				local connections = require("remote-sshfs.connections")
				local builtin = require("telescope.builtin")
				if type(connections.is_connected) == "function" and connections.is_connected() then
					api.live_grep()
				elseif connections.is_connected then
					api.live_grep()
				else
					builtin.live_grep()
				end
			end,
			desc = "Live grep (remote-aware)",
		},
	},
	config = function()
		require("remote-sshfs").setup({
			opts = {
				-- Refer to the configuration section below
				-- or leave empty for defaults
				handlers = {
					on_connect = {
						change_dir = true, -- when connected change vim working directory to mount point
					},
					on_disconnect = {
						clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
					},
					on_edit = {}, -- not yet implemented
				},
				ui = {
					select_prompts=false,
					confirm = {
						connect = true,
						change_dir = true
					}
				},
				log = {
					enable = true, -- enable logging
					truncate = false, -- truncate logs
					types = { -- enabled log types
						all = true,
						util = false,
						handler = false,
						sshfs = false,
					},
				}
			}
		})
	end,

}
