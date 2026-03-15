return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- the following function defines mathzone in latex, which requires that vimtex is installed.
      local function in_mathzone()
        return vim.fn["vimtex#syntax#in_mathzone"]() == 1
      end

      -- Markdown math zone detection (treesitter + text-scanning fallback)
      local function in_md_mathzone()
        -- Treesitter: walk up looking for latex_block / latex_inline / latex_span
        local ok, ts_result = pcall(function()
          local node = vim.treesitter.get_node()
          while node do
            local ntype = node:type()
            if ntype == "latex_block" or ntype == "latex_inline" or ntype == "latex_span" then
              return true
            end
            node = node:parent()
          end
          return false
        end)
        if ok and ts_result then
          return true
        end

        -- Fallback: count unmatched $ delimiters up to cursor
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row, col = cursor[1], cursor[2]
        local lines = vim.api.nvim_buf_get_lines(0, 0, row - 1, false)
        local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
        table.insert(lines, current_line:sub(1, col))
        local text = table.concat(lines, "\n")

        text = text:gsub("\\%$", "  ")

        local display_count = 0
        text = text:gsub("%$%$", function()
          display_count = display_count + 1
          return "  "
        end)

        local inline_count = 0
        text:gsub("%$", function()
          inline_count = inline_count + 1
        end)

        return (display_count % 2 == 1) or (inline_count % 2 == 1)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = "menu,menuone,noinsert" },

        enabled = function()
          local filetype = vim.bo.filetype
          -- Disable in math zones in LaTeX files
          if filetype == "tex" or filetype == "latex" then
            return not in_mathzone()
          end
          -- Disable in math zones in Markdown files
          if filetype == "markdown" then
            return not in_md_mathzone()
          end
          return true
        end,

        mapping = cmp.mapping.preset.insert({
          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- ["<C-Space>"] = cmp.mapping.complete({}),

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end, { "i", "s" }), -- To let this logic applies to command mode, add "c" into { }

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete() -- manually trigger the completion process
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<Esc>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
          { name = "render-markdown" },
        },
      })

      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        },
      })
    end,
  },
}
