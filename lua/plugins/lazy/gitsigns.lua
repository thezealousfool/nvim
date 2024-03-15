return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = { "BufRead" },
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				vim.keymap.set("n", "<leader>hs", gs.stage_hunk)
				vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
				vim.keymap.set("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				vim.keymap.set("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
				vim.keymap.set("n", "<leader>hd", gs.preview_hunk)
				vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)
				vim.keymap.set("n", "<leader>gB", gs.blame_line)
				vim.keymap.set("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
				vim.keymap.set("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
			end,
		})
	end,
}
