---Join path segments that were passed as input
---@return string
function _G.join_paths(...)
  local result = table.concat({ ... }, "/")
  return result
end

---Require a module in protected mode without relying on its cached value
---@param module string
---@return any
function _G.require_clean(module)
  package.loaded[module] = nil
  _G[module] = nil
  local _, requested = pcall(require, module)
  return requested
end

---Return value of environment variable name or default value
---if environment variable not set
---@return string
function _G.getenv(name, default)
  local value = os.getenv(name)
  if not value or value == "" then
    return default()
  end
  return value
end

---Checks if a given path exists and is a file
---@param path (string) path to check
---@returns (bool)
function _G.is_file(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file" or false
end

---Checks if a given path exists and is a directory
---@param path (string) path to check
---@returns (bool)
function _G.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

---Selected text in visual mode
--@returns (string or nil)
function _G.selected_text()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})
  text = string.gsub(text, "\n", "")
  if string.len(text) == 0 then
    text = nil
  end
  return text
end
