-- only in lsp buffers
_G.lsp_keymaps = function(bufn)
  local opts = { noremap = true, silent = true }
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_next, opts)
  local status_ok, telescope = pcall(require, "telescope.builtin")
  if status_ok then
    vim.keymap.set("n", "<leader>dl", telescope.diagnostics, opts)
  end

  local bufopts = { noremap = true, silent = true, buffer = bufn }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, bufopts)
end

_G.project_keybinds = function()
  vim.keymap.set("n", "<leader>p",
    require("telescope").extensions.projects.projects, { noremap = true })
end

local M = {}

function M:load()
  local opts = { noremap = true }
  vim.g.mapleader = " "

  vim.keymap.set("n", "<leader>w", "<cmd> w<cr>", opts)
  vim.keymap.set("n", "<leader>q", "<cmd> q<cr>", opts)
  vim.keymap.set("n", "<leader>c", "<cmd> bd<cr>", opts)

  local nav_ok, nav = pcall(require, "nvim-tmux-navigation")
  if nav_ok then
    vim.keymap.set("n", "<C-H>", nav.NvimTmuxNavigateLeft, opts)
    vim.keymap.set("n", "<C-J>", nav.NvimTmuxNavigateDown, opts)
    vim.keymap.set("n", "<C-K>", nav.NvimTmuxNavigateUp, opts)
    vim.keymap.set("n", "<C-L>", nav.NvimTmuxNavigateRight, opts)
    vim.keymap.set("n", "<C-\\>", nav.NvimTmuxNavigateLastActive, opts)
  end

  local status_ok, telescope = pcall(require, "telescope.builtin")
  if status_ok then
    vim.keymap.set("n", "<leader>f", telescope.find_files, opts)
    vim.keymap.set("n", "<leader>b", function()
      telescope.buffers({
        ignore_current_buffer = true,
        sort_mru = true,
      })
    end, opts)
    vim.keymap.set("n", "<leader>sw", telescope.live_grep, opts)
    vim.keymap.set("v", "<leader>sw", function()
      local text = _G.selected_text()
      if text then
        telescope.grep_string({ search = text })
      end
    end, opts)
    vim.keymap.set("n", "<leader>ss", telescope.treesitter, opts)
    vim.keymap.set("n", "<leader>sb", telescope.current_buffer_fuzzy_find, opts)
    vim.keymap.set("v", "<leader>sb", function()
      local text = _G.selected_text()
      if text then
        telescope.current_buffer_fuzzy_find({ search = text })
      end
    end, opts)
    vim.keymap.set("n", "<leader>gs", telescope.git_status, opts)
  end
end

return M
