local M = {}

function M:setup()
  local null_ls = require("null-ls")
  local lsp = require("lsp")
  local _common_capabilities = lsp:common_capabilities()

  null_ls.setup {
    on_attach = lsp.on_attach,
    flags = lsp.lsp_flags,
    capabilities = _common_capabilities,
    sources = {
      -- python (black)
      null_ls.builtins.formatting.black,

      -- python (isort)
      null_ls.builtins.formatting.isort,

      -- python (ruff)
      null_ls.builtins.diagnostics.ruff,
      null_ls.builtins.formatting.ruff,

      -- rust
      null_ls.builtins.formatting.rustfmt,

      -- typescript
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettier,

      -- zig
      null_ls.builtins.formatting.zigfmt,
    }
  }
end

return M
