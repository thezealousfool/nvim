return {
	"alexghergh/nvim-tmux-navigation",
	lazy = true,
	keys = {
		{ "<C-h>", "<ESC><cmd>NvimTmuxNavigateLeft<CR>" },
		{ "<C-j>", "<ESC><cmd>NvimTmuxNavigateDown<CR>" },
		{ "<C-k>", "<ESC><cmd>NvimTmuxNavigateUp<CR>" },
		{ "<C-l>", "<ESC><cmd>NvimTmuxNavigateRight<CR>" },
	},
	config = function()
		local nvim_tmux_nav = require("nvim-tmux-navigation")
		nvim_tmux_nav.setup({
			disable_when_zoomed = true,
		})
	end,
}
