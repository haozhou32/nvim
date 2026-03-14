return {
  -- {
  --   "folke/tokyonight.nvim",
  --   -- priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme("tokyonight-night")
  --   end,
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      -- custom_highlights = function(colors)
      --   return {
      --     ["@property"] = { fg = colors.teal },
      --     ["@punctuation.bracket"] = { fg = colors.subtext0 },
      --     ["@punctuation.delimiter"] = { fg = colors.sky },
      --   }
      -- end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
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
}
