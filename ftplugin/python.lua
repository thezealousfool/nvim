local function snippets()
  local status_ok, ls = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  local s = ls.snippet
  local fmt = require("luasnip.extras.fmt").fmt
  local i = ls.insert_node
  local rep = require("luasnip.extras").rep

  ls.add_snippets("python", {

    s("main", fmt([[
    def {}({}):
        {}


    if __name__ == "__main__":
        {}({})
    ]], { rep(1), i(3), i(0), i(1, "main"), i(2) })),

  })

end

snippets()
