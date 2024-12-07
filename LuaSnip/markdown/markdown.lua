local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s({trig = "th2", snippetType = "autosnippet"},
    fmta(
      [[
        | <> | <> |
        |----|----|
      ]],
      {
        i(1, "Key"),
        i(2, "Value"),
      }
    ),
    {condition = line_begin}
  ),

  s({trig = "tr2", snippetType = "autosnippet"},
    fmta(
      [[
        | <> | <> |
      ]],
      {
        i(1, "Term"),
        i(2, "Definition"),
      }
    )
  ),

  s({trig = "th3", snippetType = "autosnippet"},
    fmta(
      [[
        | <> | <> | <> |
        |----|----|----|
      ]],
      {
        i(1, "Key"),
        i(2, "Value1"),
        i(3, "Value2")
      }
    ),
    {condition = line_begin}
  ),

  s({trig = "tr3", snippetType = "autosnippet"},
    fmta(
      [[
        | <> | <> | <> |
      ]],
      {
        i(1, "Term"),
        i(2, "Definition"),
        i(3, "Property")
      }
    )
  ),

}

