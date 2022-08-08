local on_attach = function(client, bufn)
  vim.api.nvim_buf_set_option(bufn, "omnifunc", "v:lua.vim.lsp.omnifunc")
  if _G.lsp_keymaps then
    _G.lsp_keymaps(bufn)
  end
end

local lsp_flags = {
  debounce_text_changes = 300,
}

_G.lsp_servers = {
  clangd = {
    on_attach = on_attach,
    flags = lsp_flags,
  },
  pyright = {
    on_attach = on_attach,
    flags = lsp_flags,
  },
  rust_analyzer = {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {}
    }
  },
}

local M = {}

function M:setup()
  local lspconfig = require("lspconfig")
  for k, v in pairs(_G.lsp_servers) do
    lspconfig[k].setup(v)
  end
end

return M
