local options = {
	undofile = true, -- persistent undo
	swapfile = false, -- create swapfiles
	wrap = false, -- line wrapping
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- spaces for each indentation
	tabstop = 2, -- 2 spaces for a tab
  showmode = false, -- we do not need to see things like -- INSERT -- anymore
  ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- smart case
	smartindent = true, -- indent from context
  clipboard = "unnamedplus", -- use system clipboard
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  shortmess = "atI", -- abbreviate, truncate, disable intro message
  laststatus = 0, -- disable status line
  ruler = true, -- line and column number counters
  fillchars = [[eob: ,fold: ,foldopen:ᐯ,foldsep: ,foldclose:ᐳ]], -- end of buffer and fold chars
  colorcolumn = "81",
  termguicolors = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = " "

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = function() end,
    ['*'] = function() end,
  },
}

if vim.env.TMUX ~= nil then
  local copy = {'tmux', 'load-buffer', '-w', '-'}
  local paste = {'bash', '-c', 'tmux refresh-client -l && sleep 0.05 && tmux save-buffer -'}
  vim.g.clipboard = {
    name = 'tmux',
    copy = {
      ['+'] = copy,
      ['*'] = copy,
    },
    paste = {
      ['+'] = paste,
      ['*'] = paste,
    },
    cache_enabled = 0,
  }
end

local keymap = vim.keymap.set
keymap("n", "<leader>w", "<cmd>w<CR>")
keymap("n", "<leader>q", "<cmd>q<CR>")

vim.filetype.add({ extension = { typ = "typst" } })
