function live_multigrep(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local make_entry = require("telescope.make_entry")
	local conf = require("telescope.config").values

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end

			local pieces = vim.split(prompt, "  ")
			local args = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--trim",
			}
			if pieces[1] then
				table.insert(args, "-e")
				table.insert(args, pieces[1])
			end
			if pieces[2] then
				table.insert(args, "-g")
				table.insert(args, pieces[2])
			end
			return args
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			finder = finder,
			prompt_title = "Multi Grep",
			debounce = 200,
			previewer = conf.grep_previewer(opts),
			sorter = require("telescope.sorters").empty(),
		})
		:find()
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	lazy = true,
	keys = {
		{ "<leader>f", "<ESC><cmd>Telescope find_files<CR>" },
		{ "<leader>b", "<ESC><cmd>Telescope buffers<CR>" },
		{ "<leader>gs", "<ESC><cmd>Telescope git_status<CR>" },
		{
			"<leader>sw",
			function()
				live_multigrep()
			end,
			mode = "n",
		},
		{
			"<leader>sw",
			function()
				-- Get selected text
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})
				text = string.gsub(text, "\n", "")
				if string.len(text) == 0 then
					text = nil
				end

				live_multigrep({ default_text = text, initial_mode = "normal" })
			end,
			mode = "v",
		},
	},
	cmd = "Telescope",
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
