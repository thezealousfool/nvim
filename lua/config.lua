if vim.fn.has "nvim-0.7" ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Required v0.7+", vim.log.levels.WARN)
  vim.wait(1000, function()
    return false
  end)
  vim.cmd "cquit"
end

local M = {}

function M:init()
  require("utils")
  _G.xdg_home = getenv("HOME",
    function()
      vim.notify("Environment variable HOME undefined.", vim.log.levels.WARN)
      vim.wait(1000, function() return "" end)
      vim.cmd "cquit"
    end)
  _G.xdg_data = getenv("XDG_DATA_HOME", function() return _G.xdg_home .. "/.local/share" end)
  _G.xdg_config = getenv("XDG_CONFIG_HOME", function() return _G.xdg_home .. "/.config" end)
  _G.xdg_cache = getenv("XDG_CACHE_HOME", function() return _G.xdg_home .. "/.cache" end)

  _G.runtime_dir = join_paths(_G.xdg_data, "vv")
  _G.config_dir = join_paths(_G.xdg_config, "vv")
  _G.cache_dir = join_paths(_G.xdg_cache, "vv")
  _G.pack_dir = join_paths(_G.runtime_dir, "site", "pack")
  _G.packer_path = join_paths(_G.runtime_dir, "site", "pack", "packer", "start", "packer.nvim")
  _G.packer_cache_path = join_paths(_G.config_dir, "plugin", "packer_compiled.lua")
  _G.packer_rtp = join_paths(_G.runtime_dir, "site", "pack", "*", "start", "*")

  vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site"))
  vim.opt.rtp:remove(join_paths(vim.call("stdpath", "data"), "site", "after"))
  vim.opt.rtp:prepend(join_paths(_G.runtime_dir, "site"))
  vim.opt.rtp:append(join_paths(_G.runtime_dir, "site", "after"))
  vim.opt.rtp:remove(vim.call("stdpath", "config"))
  vim.opt.rtp:remove(join_paths(vim.call("stdpath", "config"), "after"))
  vim.opt.rtp:prepend(_G.config_dir)
  vim.opt.rtp:append(join_paths(_G.config_dir, "after"))

  vim.fn.stdpath = function(what)
    if what == "data" then
      return _G.runtime_dir
    elseif what == "config" then
      return _G.config_dir
    elseif what == "cache" then
      return _G.cache_dir
    else
      return vim.call("stdpath", what)
    end
  end

  vim.cmd [[let &packpath = &runtimepath]]
  M:load()
end

function M:load()
  require("defaults"):load()
  require("keybinds"):load()
  require("plugins"):load()
  require("autocmds"):setup()
  require("project"):setup()
end

function M:reload()
  vim.schedule(function()
    M:load()
  end)
end

return M
