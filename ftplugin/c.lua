local function snippets()
  local status_ok, ls = pcall(require, "luasnip")
  if not status_ok then
    return
  end

  local s = ls.snippet
  local fmt = require("luasnip.extras.fmt").fmt
  local i = ls.insert_node
  local d = ls.dynamic_node
  local t = ls.text_node
  local sn = ls.snippet_node

  local date_input = function(_, _, _, format)
    format = format or "%m/%d/%Y"
    return sn(nil, i(1, os.date(format)))
  end

  local file_name = function()
    local file_parts = vim.split(vim.api.nvim_buf_get_name(0), "/")
    local file = file_parts[#file_parts]
    if file == "" then
      return sn(nil, i(1))
    else
      return sn(nil, t(file))
    end
  end

  ls.add_snippets("c", {

    s("sfn", fmt([[
    static {} {}({}){{
      {}
    }}]], { i(1, "void"), i(2), i(3, "void"), i(0) })),

    s("fn", fmt([[
    {} {}({}){{
      {}
    }}]], { i(1, "void"), i(2), i(3, "void"), i(0) })),

    s("if", fmt([[
    if({}){{
      {}
    }}
    ]], { i(1), i(0) })),

    s("fori", fmt([[
    for(i = {}; i < {}; ++i){{
      {}
    }}
    ]], { i(1, "0"), i(2), i(0) })),

    s("!!", fmt([[
    /*****************************************************************************
     * File : {}
     *
     * Description : {}
     *
     * Author  : Vivek Roy <{}>
     * Date    : {}
     *
     *****/
     {}
    ]], {
      d(1, file_name),
      i(2),
      i(3, "vivek_roy@apple.com"),
      d(4, date_input, {}, { user_args = { "%m/%d/%Y" } }),
      i(0),
    }))

  })

end

snippets()
