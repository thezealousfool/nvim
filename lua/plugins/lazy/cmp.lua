return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		vim.opt.completeopt = "menu,menuone,noselect"
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
				border = "rounded",
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			mapping = cmp.mapping.preset.insert({
				["<Esc>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
			}),
			formatting = {
				fields = { "kind", "abbr" },
				format = function(entry, vim_item)
					vim_item.kind = ({
						buffer = "",
						nvim_lsp = "",
						luasnip = "󰩫",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		local map = vim.keymap.set
		map("n", "c<Tab>", luasnip.unlink_current, {})
		map("n", "<Tab>", function()
			if luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			end
		end, {})
		map("n", "<S-Tab>", function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, {})
	end,
}
