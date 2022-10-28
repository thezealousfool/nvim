local M = {}

function M:setup()
  local yank_highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
      require("vim.highlight").on_yank { higroup = "Search", timeout = 100 }
    end,
    group = fold_group,
  })
end

return M
