local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

return {
  s("filename", {
    f(function()
      return vim.fn.expand("%:t")
    end, {}),
  }),
  s("author", {
    f(function()
      -- Check if we're in a git repository
      local git_check = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
      if vim.v.shell_error ~= 0 then
        return "Error: not a git repo"
      end

      -- Get git user name and email
      local name = vim.fn.system("git config user.name"):gsub("\n", "")
      local email = vim.fn.system("git config user.email"):gsub("\n", "")

      -- Check if both are set
      if name == "" or email == "" then
        return "Error: git user.name or user.email not configured"
      end

      return name .. " (" .. email .. ")"
    end, {}),
  }),
}
