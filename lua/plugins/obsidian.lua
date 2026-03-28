return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = false,
    ft = "markdown",
    config = function()
      require("obsidian").setup({
        workspaces = vim.tbl_filter(function(w)
          return vim.fn.isdirectory(vim.fn.expand(w.path)) == 1
        end, {
          { name = "technotes", path = "~/vaults/technotes" },
          { name = "personal", path = "~/vaults/personal" },
        }),

        new_notes_location = "current_dir",

        preferred_link_style = "wiki",

        open_notes_in = "vsplit",

        follow_url_func = function(url)
          if vim.fn.has("mac") == 1 then
            vim.fn.jobstart({ "open", url })
          elseif vim.fn.has("wsl") == 1 then
            vim.fn.jobstart({ "wsl-open", url })
          end
        end,

        ui = { enable = false },

        note_path_func = function(spec)
          -- Use the alias as the filename instead of the ID
          local title = spec.title or spec.id
          -- Convert to valid filename (replace spaces with dashes, remove special characters)
          local filename = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          return filename .. ".md"
        end,

        vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in [O]bsidian" }),
        vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "[N]ew note" }),
        vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "[F]ind note" }),
        vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show [B]acklinks" }),
        vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Show [L]inks" }),
        vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<cr>", { desc = "list files with [T]ag" }),
        vim.keymap.set("n", "<leader>op", "<cmd>:ObsidianPasteImg<cr>", { desc = "[P]aste images" }),
        vim.keymap.set("n", "<leader>os", "<cmd>:ObsidianWorkspace<cr>", { desc = "[S]witch workspaces" }),
      })
    end,
  },
}
