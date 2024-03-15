local lsps = {
	{
		"efm",
		cmd = { "efm-langserver" },
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
	},
	{ "clangd", cmd = { "clangd", "--background-index", "--enable-config", "--clang-tidy" } },
  { "pyright", cmd = { "pyright" } },
	{ "rust_analyzer", cmd = { "rustup", "run", "stable", "rust-analyzer" } },
  "tsserver",
	"zls",
	"bashls",
  "marksman",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local keymap = vim.keymap.set
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr
			keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
			keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
			keymap("n", "gD", vim.lsp.buf.declaration, opts)
			keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
			keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
			keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
			keymap("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
			keymap("n", "<leader>D", vim.diagnostic.open_float, opts)
			keymap("n", "]d", vim.diagnostic.goto_next, opts)
			keymap("n", "[d", vim.diagnostic.goto_prev, opts)
			keymap("n", "K", vim.lsp.buf.hover, opts)
			keymap("n", "<leader>lf", vim.lsp.buf.format, opts)
			keymap("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
			if client.name ~= "efm" then
				client.resolved_capabilities.document_formatting = false
			end
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local flags = {
			debounce_text_changes = 300,
		}

		for _, lsp in pairs(lsps) do
			local cfg = { on_attach = on_attach, flags = flags, capabilities = capabilities }
			if type(lsp) == "table" then
				local name = lsp[1]
				for k, v in pairs(lsp) do
					if type(k) == "string" then
						cfg[k] = v
					end
				end
				lspconfig[name].setup(cfg)
			elseif type(lsp) == "string" then
				lspconfig[lsp].setup(cfg)
			end
		end
	end,
}
