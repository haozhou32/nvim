local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

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

--
-- snippets
--

return {
  s(
    { trig = "tbf", snippetType = "autosnippet", dscr = "Expands 'tbf' into '\textbf{}'" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "tit", snippetType = "autosnippet", dscr = "Expands 'tit' into '\textit{}'" },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "ovl", snippetType = "autosnippet", dscr = "Expands 'ovl' into '\\overline{}'" },
    fmta("\\overline{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "udl", snippetType = "autosnippet", dscr = "Expands 'udl' into '\\underline{}'" },
    fmta("\\underline{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "tld", snippetType = "autosnippet", dscr = "Expands 'tld' into '\\tilde{}'" },
    fmta("\\tilde{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "hat", snippetType = "autosnippet", dscr = "Expands 'hat' into '\\hat{}'" },
    fmta("\\hat{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "blue", dscr = "Expands 'blue' into '{\\color{blue} <>}'" },
    fmta("{\\color{blue} <>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "red", dscr = "Expands 'red' into '{\\color{red} <>}'" },
    fmta("{\\color{red} <>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "mc", snippetType = "autosnippet" },
    fmta("\\mathcal{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "mb", snippetType = "autosnippet" },
    fmta("\\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = tex_utils.in_mathzone }
  ),
}
