return {
  {
    "Kicamon/running.nvim",
    lazy = true,
    cmd = "Run",
    config = function()
      require("running").setup()
    end,
  },
}
