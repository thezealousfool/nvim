vim.lsp.enable({
  "clangd",
  "pyrefly",
  "efm",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name ~= "efm" then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end
  end,
})

vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap('n', 'grr', "<cmd>Telescope lsp_references<CR>", opts)
keymap('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", opts)
keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>lf", vim.lsp.buf.format, opts)
keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
