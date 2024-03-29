local function lsp_handlers()
  local diagnostics = {
    Error = "x",
    Hint = "h",
    Information = "i",
    Question = "?",
    Warning = "!",
  }
  local signs = {
    { name = "DiagnosticSignError", text = diagnostics.Error },
    { name = "DiagnosticSignWarn", text = diagnostics.Warning },
    { name = "DiagnosticSignHint", text = diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = diagnostics.Info },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      virtual_text = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        active = signs,
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  }

  vim.diagnostic.config(config.diagnostic)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

local function formatting(client, bufnr)
  if vim.g.prevent_autoformat then
    return
  end
  if client.name ~= "efm" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    return
  end
  if not client.server_capabilities.documentFormattingProvider then
    print("Formatting not supported", client.name)
    return
  end
  local lsp_format_grp = vim.api.nvim_create_augroup("LspFormat", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_format_grp,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

local M = {}

function M.on_attach(client, bufn)
  vim.api.nvim_buf_set_option(bufn, "omnifunc", "v:lua.vim.lsp.omnifunc")
  _G.lsp_keymaps(bufn)
  formatting(client, bufn)
end

function M:common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  else
    print("cmp_nvim_lsp not found")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }
    return capabilities
  end
end

M.lsp_flags = {
  debounce_text_changes = 300,
}

function M:setup()
  local lspconfig = require("lspconfig")
  local _common_capabilities = M:common_capabilities()
  local lsp_servers = {
    efm = {
      cmd = { "efm-langserver" },
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      capabilities = _common_capabilities,
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
      },
    },
    clangd = {
      cmd = { "clangd", "--background-index", "--enable-config", "--clang-tidy" },
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      capabilities = _common_capabilities,
    },
    pylsp = {
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      autostart = false,
      capabilities = _common_capabilities,
    },
    pyright = {
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      autostart = true,
      capabilities = _common_capabilities,
    },
    rust_analyzer = {
      cmd = { "rustup", "run", "stable", "rust-analyzer" },
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      capabilities = _common_capabilities,
      settings = {
        ["rust-analyzer"] = {}
      }
    },
    tsserver = {
      on_attach = M.on_attach,
      flags = M.lsp_flags,
      capabilities = _common_capabilities,
    }
  }

  lsp_handlers()
  for k, v in pairs(lsp_servers) do
    lspconfig[k].setup(v)
  end
end

return M
