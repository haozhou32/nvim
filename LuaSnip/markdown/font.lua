local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local md_utils = {}

-- Treesitter-based math zone detection
local function ts_in_mathzone()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "latex_block" then
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

  local start = math.max(0, row - 1 - 200)
  local lines = vim.api.nvim_buf_get_lines(0, start, row - 1, false)
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  table.insert(lines, current_line:sub(1, col))
  local text = table.concat(lines, "\n")

  text = text:gsub("\\%$", "  ")

  -- Strip inline code spans to avoid counting $ inside backticks
  text = text:gsub("`[^`\n]*`", function(m) return string.rep(" ", #m) end)

  local display_count = 0
  text = text:gsub("%$%$", function()
    display_count = display_count + 1
    return "  "
  end)

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
    { trig = "ovl", snippetType = "autosnippet", dscr = "Expands 'ovl' into '\\overline{}'" },
    fmta("\\overline{<>}", {
      d(1, get_visual),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "udl", snippetType = "autosnippet", dscr = "Expands 'udl' into '\\underline{}'" },
    fmta("\\underline{<>}", {
      d(1, get_visual),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "tld", snippetType = "autosnippet", dscr = "Expands 'tld' into '\\tilde{}'" },
    fmta("\\tilde{<>}", {
      d(1, get_visual),
    }),
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "hat", snippetType = "autosnippet", dscr = "Expands 'hat' into '\\hat{}'" },
    fmta("\\hat{<>}", {
      d(1, get_visual),
    }),
    { condition = md_utils.in_mathzone }
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
    { condition = md_utils.in_mathzone }
  ),

  s(
    { trig = "mb", snippetType = "autosnippet" },
    fmta("\\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = md_utils.in_mathzone }
  ),
}
