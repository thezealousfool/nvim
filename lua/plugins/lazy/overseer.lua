return {
	"stevearc/overseer.nvim",
	keys = {
		{
			"<leader>or",
			function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					overseer.run_template()
				else
					overseer.run_action(tasks[1], "restart")
				end
			end,
			desc = "Run last",
		},
	},
	config = function()
		require("overseer").setup({
			strategy = "toggleterm",
		})
	end,
}
