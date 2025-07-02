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
tex_utils.in_mathzone = function() -- math context detection
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function() -- comment detection
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end
tex_utils.in_env = function(name) -- generic environment detection
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function() -- equation environment detection
  return tex_utils.in_env("equation")
end
tex_utils.in_itemize = function() -- itemize environment detection
  return tex_utils.in_env("itemize")
end
tex_utils.in_tikz = function() -- TikZ picture environment detection
  return tex_utils.in_env("tikzpicture")
end
return {

  s({ trig = ";a", snippetType = "autosnippet" }, {
    t("\\alpha"),
  }),

  s({ trig = ";b", snippetType = "autosnippet" }, {
    t("\\beta"),
  }),

  s({ trig = ";d", snippetType = "autosnippet" }, {
    t("\\delta"),
  }),

  s({ trig = ";D", snippetType = "autosnippet" }, {
    t("\\Delta"),
  }),

  s({ trig = ";e", snippetType = "autosnippet" }, {
    t("\\epsilon"),
  }),

  s({ trig = ";n", snippetType = "autosnippet" }, {
    t("\\eta"),
  }),

  s({ trig = ";p", snippetType = "autosnippet" }, {
    t("\\pi"),
  }),

  s({ trig = ";P", snippetType = "autosnippet" }, {
    t("\\Pi"),
  }),

  s({ trig = ";g", snippetType = "autosnippet" }, {
    t("\\gamma"),
  }),

  s({ trig = ";G", snippetType = "autosnippet" }, {
    t("\\Gamma"),
  }),

  s({ trig = ";m", snippetType = "autosnippet" }, {
    t("\\mu"),
  }),

  s({ trig = ";w", snippetType = "autosnippet" }, {
    t("\\omega"),
  }),

  s({ trig = ";W", snippetType = "autosnippet" }, {
    t("\\Omega"),
  }),

  s({ trig = ";o", snippetType = "autosnippet" }, {
    t("\\theta"),
  }),

  s({ trig = ";O", snippetType = "autosnippet" }, {
    t("\\Theta"),
  }),

  s({ trig = ";s", snippetType = "autosnippet" }, {
    t("\\sigma"),
  }),

  s({ trig = ";S", snippetType = "autosnippet" }, {
    t("\\Sigma"),
  }),

  s({ trig = ";t", snippetType = "autosnippet" }, {
    t("\\tau"),
  }),

  s({ trig = ";r", snippetType = "autosnippet" }, {
    t("\\rho"),
  }),

  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }),

  s({ trig = ";L", snippetType = "autosnippet" }, {
    t("\\Lambda"),
  }),

  s({ trig = "ift", snippetType = "autosnippet" }, {
    t("\\infty"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "ept", snippetType = "autosnippet" }, {
    t("\\emptyset"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "fa", snippetType = "autosnippet" }, {
    t("\\forall"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "ex", snippetType = "autosnippet" }, {
    t("\\exist"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\in"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "sb", snippetType = "autosnippet" }, {
    t("\\subset"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "qed", snippetType = "autosnippet" }, {
    t("\\hfill$\\square$"),
  }),

  s({ trig = "lla", snippetType = "autosnippet" }, {
    t("\\Longleftarrow"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "lra", snippetType = "autosnippet" }, {
    t("\\Longrightarrow"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "llra", snippetType = "autosnippet" }, {
    t("\\Longleftrightarrow"),
  }, { condition = tex_utils.in_mathzone }),

  s({ trig = "rra", snippetType = "autosnippet" }, {
    t("\\rightrightarrows"),
  }, { condition = tex_utils.in_mathzone }),
}
