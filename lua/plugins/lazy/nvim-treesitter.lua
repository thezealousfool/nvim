return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
  priority = 1000,
	event = { "VeryLazy" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"diff",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"typst",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
			"zig",
		},
		sync_install = false,

		highlight = { enable = true },
		indent = { enable = true },
    textobjects = { enable = true },
	},
	init = function(plugin)
		-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
		-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
		-- no longer trigger the **nvim-treesitter** module to be loaded in time.
		-- Luckily, the only things that those plugins need are the custom queries, which we make available
		-- during startup.
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	config = function(_, opts)
		require("nvim-treesitter.install").compilers = { "clang" }
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.typst = {
			install_info = {
				url = "https://github.com/uben0/tree-sitter-typst.git",
				files = { "src/parser.c", "src/scanner.c" },
			},
			filetype = "typst", -- if filetype does not agrees with parser name
		}
		require("nvim-treesitter.configs").setup(opts)
	end,
}
