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
    -- {
    -- t("\\frac{"),
    -- i(1),
    -- t("}{"),
    -- i(2),
    -- t("}")
    -- the following code using fmta is equivalent to the above, but in a more human-reading friendly way.
    -- }
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
    fmta([[<>$ <> $]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    })
  ),

  s(
    { trig = "env", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1, "environment name"),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "eq", snippetType = "autosnippet", dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
        \begin{equation*}
           <>
        \end{equation*}
      ]],
      { i(1, "insert equation") }
    ),
    { condition = line_begin }
  ),

  -- Example: expanding a snippet on a new line only.
  s(
    { trig = "h1", dscr = "Top-level section" },
    fmta([[\section{<>}]], { i(1) }),
    { condition = line_begin } -- set condition in the `opts` table
  ),

  s({ trig = "h2", dscr = "second-level section" }, fmta([[\subsection{<>}]], { i(1) }), { condition = line_begin }),

  s(
    { trig = "itm", dscr = "begin itemize environment" },
    fmta(
      [[ 
         \begin{itemize}
           \item <>
         \end{itemize}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "align", dscr = "begin alginment envrionment" },
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

  s(
    { trig = "prop", dscr = "begin proposition envrionment" },
    fmta(
      [[
         \begin{proposition}
            <>
         \end{proposition}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "def", dscr = "begin definition envrionment" },
    fmta(
      [[
         \begin{definition}
            <>
         \end{definition}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "lma", dscr = "begin lemma envrionment" },
    fmta(
      [[
         \begin{lemma}
            <>
         \end{lemma}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "enu", dscr = "begin enumerating envrionment" },
    fmta(
      [[
         \begin{enumerate}
            \item <>
         \end{enumerate}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "thm", dscr = "begin theorem envrionment" },
    fmta(
      [[
         \begin{theorem}
            <>
         \end{theorem}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "cor", dscr = "begin corollary envrionment" },
    fmta(
      [[
         \begin{corollary}
            <>
         \end{corollary}
      ]],
      { i(1) }
    ),
    { condition = line_begin }
  ),

  s(
    { trig = "fig", dscr = "begin figure" },
    fmta(
      [[
         \begin{figure}[h]
           \centering
           \includegraphics[scale = <>](<>)
           \caption(<>)
         \end{figure}
      ]],
      { i(1), i(2), i(3, "name of the figure") }
    ),
    { condition = line_begin }
  ),
}
