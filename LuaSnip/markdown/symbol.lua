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

  -- Gather all text up to and including the cursor position
  local start = math.max(0, row - 1 - 200)
  local lines = vim.api.nvim_buf_get_lines(0, start, row - 1, false)
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
  table.insert(lines, current_line:sub(1, col))
  local text = table.concat(lines, "\n")

  -- Strip escaped dollars
  text = text:gsub("\\%$", "  ")

  -- Strip inline code spans to avoid counting $ inside backticks
  text = text:gsub("`[^`\n]*`", function(m) return string.rep(" ", #m) end)

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

  s({ trig = ";f", snippetType = "autosnippet" }, {
    t("\\phi"),
  }),

  s({ trig = ";F", snippetType = "autosnippet" }, {
    t("\\Phi"),
  }),

  s({ trig = ";i", snippetType = "autosnippet" }, {
    t("\\psi"),
  }),

  s({ trig = ";I", snippetType = "autosnippet" }, {
    t("\\Psi"),
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

  s({ trig = ";z", snippetType = "autosnippet" }, {
    t("\\zeta"),
  }),

  s({ trig = ";x", snippetType = "autosnippet" }, {
    t("\\xi"),
  }),

  s({ trig = ";u", snippetType = "autosnippet" }, {
    t("\\nu"),
  }),

  s({ trig = ";l", snippetType = "autosnippet" }, {
    t("\\lambda"),
  }),

  s({ trig = ";L", snippetType = "autosnippet" }, {
    t("\\Lambda"),
  }),

  s({ trig = "ift", snippetType = "autosnippet" }, {
    t("\\infty"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "ept", snippetType = "autosnippet" }, {
    t("\\emptyset"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "fa", snippetType = "autosnippet" }, {
    t("\\forall"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "ex", snippetType = "autosnippet" }, {
    t("\\exist"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "ii", snippetType = "autosnippet" }, {
    t("\\in"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "sb", snippetType = "autosnippet" }, {
    t("\\subset"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "qed", snippetType = "autosnippet" }, {
    t("\\hfill$\\square$"),
  }),

  s({ trig = "lla", snippetType = "autosnippet" }, {
    t("\\Longleftarrow"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "lra", snippetType = "autosnippet" }, {
    t("\\Longrightarrow"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "llra", snippetType = "autosnippet" }, {
    t("\\Longleftrightarrow"),
  }, { condition = md_utils.in_mathzone }),

  s({ trig = "rra", snippetType = "autosnippet" }, {
    t("\\rightrightarrows"),
  }, { condition = md_utils.in_mathzone }),
}
