return {
  -- Markdown Review
  {
    "ellisonleao/glow.nvim",
    keys = {
      { "<leader>md", ":Glow<CR>", desc = "Markdown preview", silent = true, mode = { "n" } },
    },
    config = function()
      require("glow").setup({
        border = "rounded",
        pager = true,
      })
    end,
  },
}
