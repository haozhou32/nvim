return {
  {
    "echasnovski/mini.comment",
    -- In the normal mode, enter "gcc" to comment and uncomment a line,
    -- In the visual mode, enter "gc" to comment and uncomment a code block.
    config = true,
  },

  -- Swtich to the default input method (English) when entering insertmode.
  {
    "keaising/im-select.nvim",
    config = function()
      require("im_select").setup({})
    end,
  },

  -- Make j/k faster.
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      require("accelerated-jk").setup({
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_motions = {},
        acceleration_limit = 150,
        acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        -- When holding j/k, it will jump faster when it hits these thresholds
      })

      -- Map j and k to the plugin's internal mappings
      vim.keymap.set("n", "j", "<Plug>(accelerated_jk_gj)")
      vim.keymap.set("n", "k", "<Plug>(accelerated_jk_gk)")
    end,
  },
}
