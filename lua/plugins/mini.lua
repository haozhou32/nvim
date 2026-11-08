return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.surround").setup()

      -- In the normal mode, enter "gcc" to comment and uncomment a line,
      -- In the visual mode, enter "gc" to comment and uncomment a code block.
      require("mini.comment").setup()

      -- Simple and easy statusline.
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,

    keys = {
      -- Uncomment it if you want to use mini.files instead of neotree.
      -- {
      --   "<leader>b",
      --   function()
      --     require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      --   end,
      --   desc = "Open mini.files (Directory of Current [b]uffer)",
      -- },
      -- {
      --   "<leader>B",
      --   function()
      --     require("mini.files").open(vim.uv.cwd(), true)
      --   end,
      --   desc = "Open mini.files (Current working directory)",
      -- },
    },
  },
}
