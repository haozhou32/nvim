return {
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },
}

--examples:
--TODO:
--FIX:
--HACK:
--WARNING:
--NOTE:
--PERF:
