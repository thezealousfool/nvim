-- Project specific configuration
local Path = require("plenary.path")

local function sputnik()
  vim.g.prevent_autoformat = true
end

local M = {}

function M:setup()
  local project_grp = vim.api.nvim_create_augroup("ProjectSettings", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    callback = function()
      local path = Path:new(vim.api.nvim_buf_get_name(0)):absolute()
      -- has the word sputnik and ends with .c or .h
      if path:match(".*sputnik/.*%.[ch]$") then
        sputnik()
      end
    end,
    group = project_grp,
  })
end

return M
