local M = {}

function M:load()
  if vim.fn.empty(vim.fn.glob(_G.packer_path)) > 0 then
    Packer_bootstrap = vim.fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      _G.packer_path
    })
    vim.cmd [[packadd packer.nvim]]
  end
  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
  end
  packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end
    }
  }
  return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- packer can manage itself

    -- Colorscheme
    use { "EdenEast/nightfox.nvim", config = function()
      require("nightfox").setup({
        options = {
          dim_inactive = true,
          styles = {
            comments = "italic",
            functions = "italic",
          },
        }
      })
      vim.cmd("colorscheme nightfox")
    end }

    -- Treesitter interface
    use { "nvim-treesitter/nvim-treesitter", config = function()
      require("treesitter"):setup()
    end
    }


    -- Autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        -- LSP
        {
          "neovim/nvim-lspconfig", config = function()
            require("lsp"):setup()
          end
        },
        -- Snippets
        { "L3MON4D3/LuaSnip",
          config = function()
            require("snippets"):setup()
          end
        },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        require("completions"):setup()
      end
    }

    -- Fuzzy finding
    use {
      "nvim-telescope/telescope.nvim", branch = "0.1.x",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
        require("fuzzyfinding").setup()
      end,
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- Auto cd using projects
    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {
          patterns = { ".git", "package.json", "Cargo.toml" },
          datapath = _G.cache_dir,
        }
        _G.project_keybinds()
      end
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then
      packer.sync()
    end
  end)
end

return M
