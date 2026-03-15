local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    {
      trig = "([^%a])ff",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Expands 'ff' into '\\frac{}{}'",
    },
    fmta([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    })
  ),

  s(
    {
      trig = "([^%a])ss",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      dscr = "Expands 'ss' into '$ $'",
    },
    fmta([[<>$<>$]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),

  s(
    {
      trig = "tt",
      snippetType = "autosnippet",
      dscr = "Expands 'tt' into '$$ $$'",
    },
    fmta(
      [[
           $$
           <>
           $$
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "align", snippetType = "autosnippet", dscr = "begin alignment environment" },
    fmta(
      [[
         \begin{align*}
            <>
         \end{align*}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),
}
