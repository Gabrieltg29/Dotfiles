return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Find files" },
		{ "<leader>fF", "<Cmd>Telescope find_files hidden=true no_ignore=true<CR>", desc = "Find all files" },
		{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Live grep" },
		{
			"<leader>fG",
			function()
				local glob = vim.fn.input("Glob pattern (e.g. *.ts): ")
				if glob == nil or glob == "" then
					return
				end
				require("telescope.builtin").live_grep({
					prompt_title = "Live grep (" .. glob .. ")",
					additional_args = function()
						return { "--hidden", "--glob", glob }
					end,
				})
			end,
			desc = "Live grep with glob",
		},
		{ "<leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "Grep current word" },
		{ "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "List buffers" },
		{ "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Help tags" },
		{ "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Recent files" },
		{ "<leader>fR", "<Cmd>Telescope resume<CR>", desc = "Resume last picker" },
		{ "<leader>fc", "<Cmd>Telescope commands<CR>", desc = "Commands" },
		{ "<leader>fk", "<Cmd>Telescope keymaps<CR>", desc = "Keymaps" },
		{ "<leader>fd", "<Cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
		{ "<leader>fs", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
		{ "<leader>fS", "<Cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
		{ "<leader>gc", "<Cmd>Telescope git_commits<CR>", desc = "Git commits" },
		{ "<leader>gb", "<Cmd>Telescope git_branches<CR>", desc = "Git branches" },
	},
	config = function()
		local actions = require("telescope.actions")
		local telescope = require("telescope")
		local themes = require("telescope.themes")
		local ts_lang = vim.treesitter and vim.treesitter.language

		-- Compat between Telescope and Neovim Treesitter API renames.
		if ts_lang then
			if ts_lang.ft_to_lang == nil and type(ts_lang.get_lang) == "function" then
				ts_lang.ft_to_lang = ts_lang.get_lang
			elseif ts_lang.get_lang == nil and type(ts_lang.ft_to_lang) == "function" then
				ts_lang.get_lang = ts_lang.ft_to_lang
			end
		end

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "smart" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = { prompt_position = "top", preview_width = 0.55 },
					vertical = { mirror = false },
					width = 0.9,
					height = 0.85,
				},
				file_ignore_patterns = { "%.git/", "node_modules/", "dist/", "build/", "%.next/", "target/" },
				mappings = {
					i = {
						["<C-d>"] = actions.delete_buffer,
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<Esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
			extensions = {
				["ui-select"] = themes.get_dropdown({
					previewer = false,
				}),
			},
		})

		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
		pcall(telescope.load_extension, "fidget")
	end,
}
