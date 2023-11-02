return {
	"numToStr/Comment.nvim",
	lazy = true,
	keys = {
		{ "gcc", "<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>", mode = "n" },
		{ "gbc", "<ESC><cmd>lua require('Comment.api').toggle.blockwise.current()<CR>", mode = "n" },
		{ "gc", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v" },
		{ "gb", "<ESC><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", mode = "v" },
	},
	config = function()
		require("Comment").setup({
			ignore = "^$",
		})
	end,
}
