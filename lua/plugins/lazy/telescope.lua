return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	lazy = true,
	keys = {
		{ "<leader>f", "<ESC><cmd>Telescope find_files<CR>" },
		{ "<leader>b", "<ESC><cmd>Telescope buffers<CR>" },
		{ "<leader>gs", "<ESC><cmd>Telescope git_status<CR>" },
		{ "<leader>sw", "<ESC><cmd>Telescope live_grep<CR>" },
	},
	cnd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim", "natecraddock/telescope-zf-native.nvim" },
	config = function()
		local telescope = require("telescope")
		local action_layout = require("telescope.actions.layout")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--trim",
				},

				preview = {
					filesize_limit = 0.1, -- MB
					hide_on_startup = true,
				},

				sorting_strategy = "ascending",

				layout_config = {
					horizontal = {
						height = 0.9,
						width = 0.9,
						preview_cutoff = 120,
						prompt_position = "top",
						preview_width = function(_, cols, _)
							return math.floor(cols * 0.6)
						end,
					},
				},

				mappings = { n = {
					["t"] = action_layout.toggle_preview,
				} },
			},

			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
					debounce = 200,
				},
				live_grep = {
					debounce = 200,
				},
			},
		})

		telescope.load_extension("zf-native")
	end,
}
