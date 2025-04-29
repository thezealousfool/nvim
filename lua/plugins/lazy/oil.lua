open_external = {
  desc = "Open the entry under the cursor in an external program",
  callback = function()
    local oil = require("oil")
    local entry = oil.get_cursor_entry()
    local dir = oil.get_current_dir()
    if not entry or not dir then
      return
    end
    local path = dir .. entry.name
    vim.ui.open(path)
  end,
}

return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({
			keymaps = {
				["<C-x>"] = "actions.select_split",
				["<C-v>"] = "actions.select_vsplit",
        ["-"] = "actions.parent",
        ["<CR>"] = "actions.select",
        ["g."] = "actions.toggle_hidden",
        ["gx"] = open_external,
			},
      use_default_keymaps = false,
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
