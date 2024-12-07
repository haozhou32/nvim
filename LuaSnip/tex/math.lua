local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end

return {

  s({trig = "intt", snippetType = "autosnippet", dscr="integral"},
    fmta(
      [[ 
        \int_{<>}^{<>} <> \mathrm{d}<>
      ]],
      {
        i(1,"from"),
        i(2,"to"),
        i(3,"f(x)"),
        i(4,"x")
      }
     ),
    { condition = tex_utils.in_mathzone }
  ),

  s({trig = "arr", snippetType = "autosnippet", dscr="array"},
    fmta(
      [[
        <> = \left\{\begin{array}{lll} <> &\text{if } <> \\ <> &\text{<>} <> \end{array}\right.
      ]],
      {
        i(1,"f(x)"),
        i(2,"1"),
        i(3,"1"),
        i(4,"0"),
        i(5,"otherwise"),
        i(6)
      }
     ),
    { condition = tex_utils.in_mathzone }
  ),

s(
    { trig = "([%a%)%]%}])(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

-- s(
--     { trig = "([%a%)%]%}])_(%d)(%d)", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
--     fmta("<>_{<><>}", {
--       f(function(_, snip)
--         return snip.captures[1]
--       end),
--       f(function(_, snip)
--         return snip.captures[2]
--       end),
--       f(function(_, snip)
--         return snip.captures[3]
--       end),
--     }),
--     { condition = tex_utils.in_mathzone }
--   ),

s(
    { trig = "([%a%)%]%}])(%a)%2", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 100 },
    fmta("<>_<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex_utils.in_mathzone }
  ),

-- s(
--     { trig = "([%a%)%]%}])_(%a)(%a)%3", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
--     fmta("<>_{<><>}", {
--       f(function(_, snip)
--         return snip.captures[1]
--       end),
--       f(function(_, snip)
--         return snip.captures[2]
--       end),
--       f(function(_, snip)
--         return snip.captures[3]
--       end),
--     }),
--     { condition = tex_utils.in_mathzone }
--   ),

s(
    { trig = "([%a%)%]%}])uu", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1)
    }),
    { condition = tex_utils.in_mathzone }
  ),

s(
    { trig = "([%a%)%]%}])ll", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1)
    }),
    { condition = tex_utils.in_mathzone }
  ),

 s(
    { trig = "sum", snippetType = "autosnippet" },
    c(1, {
      sn(nil, { t("\\sum\\limits_{"), i(1), t("} ") }),
      sn(nil, { t("\\sum\\limits_{"), i(1), t("}^{"), i(2), t("} ") }),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "prod", snippetType = "autosnippet" },
    c(1, {
      sn(nil, { t("\\prod\\limits_{"), i(1), t("} ") }),
      sn(nil, { t("\\prod\\limits_{"), i(1), t("}^{"), i(2), t("} ") }),
    }),
    { condition = tex_utils.in_mathzone }
  ),

s(
    { trig = "lim", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\lim_{<>}", {
      i(1),
    }),
    { condition = tex_utils.in_mathzone }
  ),

s(
    { trig = "cap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("\\bigcap\\limits_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "cup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("\\bigcup\\limits_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = tex_utils.in_mathzone }
  ),



}
