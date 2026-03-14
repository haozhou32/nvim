return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  -- Map a key to toggle Neo-tree
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
    { "<leader>o", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
  },

  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neovim if Neo-tree is the last window left
      popup_border_style = "rounded",

      window = {
        position = "left",
        width = 30,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        -- You can customize your keybindings inside the tree here
        mappings = {
          ["<space>"] = "none", -- disable space so it doesn't do anything["<cr>"] = "open",    -- Enter opens the file
          ["l"] = "open", -- Pressing 'l' opens file/folder
          ["h"] = "close_node", -- Pressing 'h' closes folder
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will automatically focus on the current file in the tree
        },
        filtered_items = {
          hide_dotfiles = false, -- Show hidden files (e.g., .gitignore)
          hide_gitignored = false,
        },
      },
    })
  end,
}
