local M = {}

function M:setup()
  local null_ls = require("null-ls")
  local h = require("null-ls.helpers")
  local methods = require("null-ls.methods")
  local FORMATTING = methods.internal.FORMATTING
  local lsp = require("lsp")
  local _common_capabilities = lsp:common_capabilities()

  null_ls.setup {
    on_attach = lsp.on_attach,
    flags = lsp.lsp_flags,
    capabilities = _common_capabilities,
    sources = {
      -- python (black)
      h.make_builtin({
        name = "black",
        method = FORMATTING,
        filetypes = { "python" },
        generator_opts = {
          command = "black",
          args = {
            "--stdin-filename",
            "$FILENAME",
            "-l",
            "80",
            "--quiet",
            "-",
          },
          to_stdin = true,
        },
        factory = h.formatter_factory,
      }),

      -- python (isort)
      h.make_builtin({
        name = "isort",
        method = FORMATTING,
        filetypes = { "python" },
        generator_opts = {
          command = "isort",
          args = {
            "--stdout",
            "--filename",
            "$FILENAME",
            "-",
          },
          to_stdin = true,
        },
        factory = h.formatter_factory,
      }),

      -- c (clang-format)
      h.make_builtin({
        name = "clang_format",
        method = { FORMATTING },
        filetypes = { "c", "cpp", "cs", "java", "cuda" },
        generator_opts = {
          command = "clang-format",
          args = h.range_formatting_args_factory(
            { "-assume-filename", "$FILENAME" },
            "--offset",
            "--length",
            { use_length = true }
          ),
          to_stdin = true,
        },
        factory = h.formatter_factory,
      }),

      -- rust
      h.make_builtin({
        name = "rustfmt",
        method = FORMATTING,
        filetypes = { "rust" },
        generator_opts = {
          command = "rustfmt",
          args = {
            "--emit=stdout",
            "--edition=2021",
          },
          to_stdin = true,
        },
        factory = h.formatter_factory,
      })
    }
  }
end

return M
