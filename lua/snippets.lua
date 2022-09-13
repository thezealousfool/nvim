local M = {}

function M:setup()
  local ls = require("luasnip")

  ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }
end

return M
