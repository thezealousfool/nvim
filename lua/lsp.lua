local on_attach = function(_, bufn)
  vim.api.nvim_buf_set_option(bufn, "omnifunc", "v:lua.vim.lsp.omnifunc")
  _G.lsp_keymaps(bufn)
end

local common_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  else
    print("cmp_nvim_lsp not found")
  end

  return capabilities
end



local M = {}

function M:setup()
  local lspconfig = require("lspconfig")
  local lsp_flags = {
    debounce_text_changes = 300,
  }
  local _common_capabilities = common_capabilities()
  local lsp_servers = {
    clangd = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = _common_capabilities,
    },
    pyright = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = _common_capabilities,
    },
    rust_analyzer = {
      on_attach = on_attach,
      flags = lsp_flags,
      capabilities = _common_capabilities,
      settings = {
        ["rust-analyzer"] = {}
      }
    },
  }

  for k, v in pairs(lsp_servers) do
    lspconfig[k].setup(v)
  end
end

return M
