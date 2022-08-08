local M = {}

function M.setup()
  local previewers = require("telescope.previewers")
  local Job = require("plenary.job")

  local _bad = { ".*%.csv" } -- Put all filetypes that slow you down in this array
  local bad_files = function(filepath)
    for _, v in ipairs(_bad) do
      if filepath:match(v) then
        return false
      end
    end

    return true
  end

  local new_maker = function(filepath, bufnr, opts)
    Job:new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          opts = opts or {}
          if opts.use_ft_detect == nil then opts.use_ft_detect = true end
          opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        else
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { j:result()[1] .. " file" })
          end)
        end
      end
    }):sync()
  end

  local telescope = require("telescope")

  telescope.setup {
    defaults = {
      buffer_previewer_maker = new_maker,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--trim"
      },
      layout_config = {
        width = 0.8,
        preview_cutoff = 120,
        horizontal = {
          preview_width = function(_, cols, _)
            return math.floor(cols * 0.6)
          end,
          mirror = false,
        },
        vertical = { mirror = false },
      },
    },
    pickers = {
      find_files = {
        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        debounce = 200,
      },
      live_grep = {
        debounce = 200,
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      }
    }
  }

  telescope.load_extension("fzf")
  telescope.load_extension("projects")
end

return M
