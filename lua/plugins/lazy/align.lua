return {
    'Vonr/align.nvim',
    branch = "v2",
    lazy = true,
    init = function()
      local NS = { noremap = true, silent = true }
      vim.keymap.set(
        'x',
        'gaa',
        function()
          require'align'.align_to_char({
            length = 1,
          })
        end,
        NS
      )
      vim.keymap.set(
        'x',
        'gaw',
        function()
          require'align'.align_to_string({
            preview = true,
            regex = false,
          })
        end,
        NS
      )
    end,
}
