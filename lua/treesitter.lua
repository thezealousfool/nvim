local M = {}

function M:setup()
  require "nvim-treesitter.configs".setup {
    ensure_installed = {
      "c",
      "cmake",
      "cpp",
      "json",
      "lua",
      "python",
      "rust",
      "toml",
      "yaml",
      "zig",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    }
  }
end

return M
