return {
  {
    "folke/tokyonight.nvim",
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    init = function()
      -- Create autocmd for LaTeX files
      vim.cmd.hi("Comment gui=none")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "latex" },
        callback = function()
          vim.cmd("colorscheme gruvbox")
          vim.defer_fn(function()
            vim.api.nvim_set_hl(0, "Conceal", { fg = "#fe8019", force = true })
          end, 100)
        end,
      })
    end,
  },

  -- {
  --   "luisiacc/gruvbox-baby",
  --   -- priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme("gruvbox-baby")
  --     local function set_latex_highlights()
  --       local highlights = {
  --         texMathDelim = { fg = "#7dcfff" },
  --         texCmdEnv = { fg = "#00FF00" },
  --         Conceal = { fg = "#fabd2f", bold = true },
  --       }
  --
  --       for group, colors in pairs(highlights) do
  --         vim.api.nvim_set_hl(0, group, colors)
  --       end
  --     end
  --     vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter" }, {
  --       pattern = "*.tex",
  --       callback = function()
  --         set_latex_highlights()
  --       end,
  --     })
  --
  --     vim.cmd.highlight("IndentLine guifg = #665c54")
  --   end,
  -- },
}
