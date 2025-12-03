return {
    { "L3MON4D3/LuaSnip", keys = {} },
    {
      "saghen/blink.cmp",
      dependencies = {
          "rafamadriz/friendly-snippets",
      },
      version = "*",
      config = function()
        require("blink.cmp").setup({
          snippets = { preset = "luasnip" },
          signature = { enabled = true },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
          },
          sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            providers = { cmdline = { min_keyword_length = 2 } },
          },
          completion = {
            accept = {
              auto_brackets = {
                enabled = true,
              },
            },
            menu = {
              border = nil,
              scrolloff = 1,
              scrollbar = false,
              draw = {
                columns = {
                  { "kind_icon" },
                  { "label", "label_description", gap = 1 },
                  { "kind" },
                },
              },
            },
            documentation = {
              window = {
                border = nil,
                scrollbar = false,
                winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
              },
              auto_show = true,
              auto_show_delay_ms = 500,
            },
          },
          keymap = { 
            preset = 'none',
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<Esc>'] = { 'hide', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
            ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
            ['<Up>'] = { 'select_prev', 'fallback' },
            ['<Down>'] = { 'select_next', 'fallback' },
          },
        })
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
}
