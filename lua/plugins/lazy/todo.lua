return {
	"folke/todo-comments.nvim",
	lazy = true,
	event = { "BufRead" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo = require("todo-comments")
		todo.setup()
		vim.keymap.set("n", "<leader>?", ":TodoTelescope keywords=TODO,FIX<enter>")
		vim.keymap.set("n", "]t", function()
			todo.jump_next()
		end)
		vim.keymap.set("n", "[t", function()
			todo.jump_prev()
		end)
	end,
}
