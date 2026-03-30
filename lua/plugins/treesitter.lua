return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
    config = function()
      local parsers = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "latex",
        "python",
      }
      require("nvim-treesitter").install(parsers)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match

          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- check if parser exists, auto-install if missing
          if not vim.treesitter.language.add(language) then
            local available = require("nvim-treesitter").get_available()
            if vim.list_contains(available, language) then
              require("nvim-treesitter").install(language)
            end
            return
          end
          -- enables syntax highlighting and other treesitter features
          vim.treesitter.start(buf, language)

          -- Some languages depend on vim's regex highlighting system alongside tree-sitter
          -- (e.g. VimTeX needs regex syntax for math zone detection)
          local additional_vim_regex_highlighting = { "tex", "ruby" }
          if vim.tbl_contains(additional_vim_regex_highlighting, filetype) then
            vim.bo[buf].syntax = "on"
          end

          -- enables treesitter based folds
          -- for more info on folds see `:help folds`
          -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- vim.wo.foldmethod = 'expr'

          -- enables treesitter based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
