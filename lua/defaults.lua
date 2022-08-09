_G.undo_dir = join_paths(_G.cache_dir, "undo")
if not is_directory(_G.undo_dir) then
  vim.fn.mkdir(_G.undo_dir, "p")
end

local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  fileencoding = "utf-8", -- the encoding written to a file
  foldmethod = "expr", -- folding, set to "expr" for treesitter based folding
  foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  hidden = true, -- required to keep multiple buffers and open multiple buffers
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  showmode = false, -- we do not need to see things like -- INSERT -- anymore
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true, -- set the title of window to the value of the titlestring
  undodir = _G.undo_dir, -- set an undo directory
  undofile = true, -- enable persistent undo
  updatetime = 300, -- faster completion
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  relativenumber = false, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  wrap = false, -- display lines as one long line
  shadafile = join_paths(_G.cache_dir, "vv.shada"),
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
  sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
  shortmess = "atI", -- abbreviate, truncate, disable intro message
  laststatus = 0, -- disable status line
  ruler = false, -- disable line and column number counters
  colorcolumn = "80,120", -- highlight the 80th column
}

local headless_options = {
  shortmess = "", -- try to prevent echom from cutting messages off or prompting
  more = false, -- do not pause listing when screen is filled
  cmdheight = 9999, -- helps avoiding |hit-enter| prompts.
  columns = 9999, -- set the widest screen possible
  swapfile = false, -- do not use a swap file
}

local M = {}

function M:load()
  if #vim.api.nvim_list_uis() == 0 then
    for k, v in pairs(headless_options) do
      vim.opt[k] = v
    end
  else
    for k, v in pairs(options) do
      vim.opt[k] = v
    end
  end
end

return M
