return {
  {
    "akinsho/bufferline.nvim",
    config = true,
  },

  {
    "tpope/vim-sleuth",
  },

  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup({
        char = "│",
        exclude = {
          "help",
          "dashboard",
          "lazy",
          "markdown",
          "text",
        },
        -- only_current = true,
      })
    end,
  },

  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,

    --NOTE: uncomment to change it to dashboard themes

    --require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
  },

  {
    "RRethy/vim-illuminate",
    config = function()
      require("illuminate").configure()
    end,
  },
}
