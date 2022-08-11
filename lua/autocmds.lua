local M = {}

function M:setup()
  local fold_group = vim.api.nvim_create_augroup("Fold", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType", "BufWritePost" }, {
    callback = function()
      vim.cmd("normal zx")
    end,
    group = fold_group,
  })
end

return M
