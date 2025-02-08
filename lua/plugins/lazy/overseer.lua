return {
	"stevearc/overseer.nvim",
	event = { "VeryLazy" },
	cmd = { "OverseerToggle" },
	keys = {
		{
			"<leader>o",
			function()
				local overseer = require("overseer")
				overseer.toggle()
			end,
			desc = "Toggle overseer",
		},
	},
	config = function()
		require("overseer").setup({
			strategy = "toggleterm",
			task_list = {
				bindings = {
					["?"] = "ShowHelp",
					["g?"] = false,
					["<CR>"] = "RunAction",
					["<C-e>"] = "Edit",
					["o"] = "Open",
					["<C-v>"] = false,
					["<C-s>"] = false,
					["<C-f>"] = false,
					["<C-q>"] = false,
					["p"] = false,
					["<C-l>"] = false,
					["<C-h>"] = false,
					["L"] = false,
					["H"] = false,
					["["] = false,
					["]"] = false,
					["{"] = "PrevTask",
					["}"] = "NextTask",
					["<C-k>"] = false,
					["<C-j>"] = false,
					["q"] = false,
					["l"] = "<cmd>OverseerLoadBundle!<cr>",
					["s"] = "<cmd>OverseerQuickAction start<cr>",
					["r"] = "<cmd>OverseerQuickAction restart<cr>",
					["w"] = "<cmd>OverseerSaveBundle<cr>",
					["d"] = "<cmd>OverseerDeleteBundle<cr>",
					["o"] = "<cmd>OverseerBuild<cr>",
				},
			},
		})
	end,
}
