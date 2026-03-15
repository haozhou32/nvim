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

local md_utils = {}

-- Treesitter-based math zone detection
local function ts_in_mathzone()
  local node = vim.treesitter.get_node()
  while node do
    local node_type = node:type()
    if node_type == "latex_block" or node_type == "latex_inline" or node_type == "latex_span" then
      return true
    end
    node = node:parent()
  end
  return false
end

-- Text-scanning fallback: count unmatched $ delimiters up to cursor
local function text_in_mathzone()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]
  local col = cursor[2]

  -- Gather all text up to and including the cursor position
  local lines = vim.api.nvim_buf_get_lines(0, 0, row - 1, false)
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  table.insert(lines, current_line:sub(1, col))
  local text = table.concat(lines, "\n")

  -- Strip escaped dollars
  text = text:gsub("\\%$", "  ")

  -- Count $$ (display math) first, then replace to avoid double-counting
  local display_count = 0
  text = text:gsub("%$%$", function()
    display_count = display_count + 1
    return "  "
  end)

  -- Count remaining single $
  local inline_count = 0
  text:gsub("%$", function()
    inline_count = inline_count + 1
  end)

  return (display_count % 2 == 1) or (inline_count % 2 == 1)
end

md_utils.in_mathzone = function()
  local ok, result = pcall(ts_in_mathzone)
  if ok and result then
    return true
  end
  return text_in_mathzone()
end

md_utils.in_text = function()
  return not md_utils.in_mathzone()
end

return {

  s(
    { trig = "intt", snippetType = "autosnippet", dscr = "integral" },
    fmta(
      [[
        \int_{<>}^{<>} <> \mathrm{d}<>
      ]],
      {
        i(1, "from"),
        i(2, "to"),
        i(3, "f(x)"),
        i(4, "x"),
      }
    ),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "mtx", snippetType = "autosnippet", dscr = "bmatrix" },
    fmta(
      [[
	\begin{bmatrix}
		<> & <> \\
		<> & <>
	\end{bmatrix}
      ]],
      {
        i(1, "a"),
        i(2, "b"),
        i(3, "c"),
        i(4, "d"),
      }
    ),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "arr", snippetType = "autosnippet", dscr = "array" },
    fmta(
      [[
        <> = \left\{\begin{array}{lll} <> &\text{if } <> \\ <> &\text{<>} <> \end{array}\right.
      ]],
      {
        i(1, "f(x)"),
        i(2, "1"),
        i(3, "1"),
        i(4, "0"),
        i(5, "otherwise"),
        i(6),
      }
    ),
    { condition = md_utils.in_mathzone }
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
    { condition = md_utils.in_mathzone }
  ),

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
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "([%a%)%]%}])uu", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "([%a%)%]%}])ll", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>_{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "sum", snippetType = "autosnippet" },
    c(1, {
      sn(nil, { t("\\sum\\limits_{"), i(1), t("} ") }),
      sn(nil, { t("\\sum\\limits_{"), i(1), t("}^{"), i(2), t("} ") }),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "prod", snippetType = "autosnippet" },
    c(1, {
      sn(nil, { t("\\prod\\limits_{"), i(1), t("} ") }),
      sn(nil, { t("\\prod\\limits_{"), i(1), t("}^{"), i(2), t("} ") }),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "lim", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\lim_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "max", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\max\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "min", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\min\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "sup", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\sup\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "inf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\inf\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "lsp", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\limsup\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "lif", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("\\liminf\\limits_{<>}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "bcap", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("\\bigcap\\limits_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "scup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("\\bigsqcup\\limits_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "bcup", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("\\bigcup\\limits_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = ";{", snippetType = "autosnippet" },
    fmta("\\{ <> \\}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "b;{", snippetType = "autosnippet", priority = 100 },
    fmta("\\left\\{ <> \\right\\}", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = ";(", snippetType = "autosnippet" },
    fmta("( <> )", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "b;(", snippetType = "autosnippet" },
    fmta("\\left( <> \\right)", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = ";[", snippetType = "autosnippet" },
    fmta("[ <> ]", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "b;[", snippetType = "autosnippet" },
    fmta("\\left[ <> \\right]", {
      i(1),
    }),
    { condition = md_utils.in_mathzone }
  ),
}
