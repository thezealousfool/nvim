return {
	"akinsho/toggleterm.nvim",
	lazy = true,
	keys = {
		{ "<leader>t", "<ESC><cmd>ToggleTerm<CR>" },
	},
	config = function()
		require("toggleterm").setup({
			direction = "float",
		})
		vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
		vim.keymap.set("t", "<C-Esc>", [[<Esc>]], { noremap = true })
	end,
}
