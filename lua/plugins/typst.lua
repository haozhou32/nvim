return {
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- or ft = 'typst'
    version = "1.*",
    keys = {
      { "<leader>tp", ":TypstPreview<CR>", mode = "n", desc = "[T]ypst [P]review" },
      { "<leader>ts", ":TypstPreview slide<CR>", mode = "n", desc = "[T]ypst preview [S]lide" },
      {
        "<leader>tw",
        function()
          local current_file = vim.fn.expand("%")
          vim.fn.jobstart({ "typst", "watch", current_file }, {
            detach = true,
          })
          vim.notify("Typst watch started for " .. current_file)
        end,
        mode = "n",
        desc = "[T]ypst [W]atch",
      },
    },
    dependencies_bin = {
      ["tinymist"] = "tinymist",
    },
    opts = {
      pdf_viewer = "zathura",
    }, -- lazy.nvim will implicitly calls `setup {}`
  },
}
