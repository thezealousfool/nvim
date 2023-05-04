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
    use { "loctvl842/monokai-pro.nvim", config = function()
      require("monokai-pro").setup({
        terminal_colors = true,
        styles = {
          comment = "italic",
        },
        filter = "spectrum",
        background_clear = { "float_win" },
      })
      vim.cmd("colorscheme monokai-pro")
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
          "neovim/nvim-lspconfig",
          config = function()
            require("lsp"):setup()
          end
        },
        {
          "jose-elias-alvarez/null-ls.nvim",
          config = function()
            require("nullls"):setup()
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

    -- Auto match character pairs
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }

    -- Commenting
    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end
    }

    -- Git signs
    use {
      "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup {
          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local nav_ok, nav = pcall(require, "nvim-tmux-navigation")
            vim.keymap.set({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
            vim.keymap.set({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
            vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)
            vim.keymap.set("n", "<leader>gB", gs.blame_line)
            vim.keymap.set("n", "]c", function()
              if vim.wo.diff then return "]c" end
              vim.schedule(function() gs.next_hunk() end)
              return "<Ignore>"
            end, { expr=true })
            vim.keymap.set("n", "[c", function()
              if vim.wo.diff then return "[c" end
              vim.schedule(function() gs.prev_hunk() end)
              return "<Ignore>"
            end, { expr=true })
          end
        }
      end
    }

    -- Folding
    use {
      "kevinhwang91/nvim-ufo",
      event = { "BufRead" },
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup()

        vim.keymap.set("n", "zR", require("ufo").openAllFolds)
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      end
    }

    use {
      "lewis6991/foldsigns.nvim",
      config = function()
        require("foldsigns").setup()
      end
    }

    use { "alexghergh/nvim-tmux-navigation" }
    
    use {
      "junegunn/vim-easy-align",
      config = function()
        vim.keymap.set("x", "a", ":EasyAlign")
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
