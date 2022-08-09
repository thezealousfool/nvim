local M = {}

function M:setup()
  require "nvim-treesitter.configs".setup {
    ensure_installed = { "c", "cpp", "lua", "rust", "python" },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

return M
