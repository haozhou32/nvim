return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      luasnip.config.set_config({
        enable_autosnippets = true,
        store_selection_keys = "`",
      })

      require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/" } })
    end,
    keys = function()
      return {
        {
          "<c-j>",
          "<Plug>luasnip-next-choice",
          mode = { "i", "s" },
        },

        {
          "<c-k>",
          "<Plug>luasnip-prev-choice",
          mode = { "i", "s" },
        },
      }
    end,
  },
}
