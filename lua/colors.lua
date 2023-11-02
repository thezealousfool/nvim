vim.opt.background = dark

local colorscheme = {
	Normal = {
		ctermbg = 0,
	},
	CursorLine = {
		ctermbg = 237,
	},
	LineNr = {
		ctermfg = 240,
	},
	CursorLineNr = {
		ctermfg = 11, -- bright yellow
	},
	SignColumn = {
		ctermbg = 0,
	},
	Visual = {
		ctermbg = 238,
	},
	MatchParen = {
		ctermfg = 9, -- bright red
	},
	Search = {
		ctermbg = 238,
		ctermfg = nil,
	},
	IncSearch = {
		ctermbg = 11, -- bright yellow
		ctermfg = 0,
	},
	NormalFloat = {
		ctermbg = 236,
	},
	GitSignsAdd = {
		ctermbg = nil,
		ctermfg = 10, -- bright green
	},
	GitSignsChange = {
		ctermbg = nil,
		ctermfg = 12, -- bright blue
	},
	GitSignsDelete = {
		ctermbg = nil,
		ctermfg = 9, -- bright red
	},
	Comment = {
		ctermfg = 239, -- grey
	},
	Function = {
		ctermfg = 2, -- green
		cterm = { bold },
	},
  Identifier = {
    ctermfg = nil,
    cterm = { standout },
  },
	Type = {
		ctermfg = 4, -- blue
	},
  String = {
    ctermfg = 3, -- yellow
  },
}

if vim.g.colors_name then
	vim.cmd([[hi clear]])
end

vim.g.colors_name = "vvk"

local highlight = function(group, hlValue)
	vim.api.nvim_set_hl(0, group, hlValue)
end

for k, v in pairs(colorscheme) do
	highlight(k, v)
end
