return {
  {
    "echasnovski/mini.comment",
    -- In the normal mode, enter "gcc" to comment and uncomment a line,
    -- In the visual mode, enter "gc" to comment and uncomment a code block.
    config = true,
  },
  {
    "kamykn/spelunker.vim",
    -- enter "ZL"/"Zl" to open a list of suggestions,
    -- enter "ZC"/"Zc" to insert a correction,
    -- enter "Zg"/"Zug" to add the word to the spell list.
    config = function()
      vim.g.spelunker_check_type = 2
      vim.g.spelunker_disable_uri_checking = 1
      vim.g.spelunker_disable_email_checking = 1
      vim.g.spelunker_disable_account_name_checking = 1
      vim.g.spelunker_disable_acronym_checking = 1
      vim.g.spelunker_disable_backquoted_checking = 1
      vim.g.spelunker_disable_auto_group = 1

      -- Disable Spelunker globally, and enable it only for tex/typst/markdown files.
      vim.g.enable_spelunker_vim = 0

      vim.api.nvim_create_augroup("SpelunkerGroup", { clear = true })

      local function enable_spelunker()
        vim.b.enable_spelunker_vim = 1
        vim.cmd("silent! SpelunkerCheck")
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = "SpelunkerGroup",
        pattern = { "tex", "latex", "typst", "markdown", "md" },
        callback = enable_spelunker,
      })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
        group = "SpelunkerGroup",
        pattern = { "*.tex", "*.latex", "*.typ", "*.md", "*.markdown" },
        callback = function()
          local allowed_filetypes = { tex = true, latex = true, typst = true, markdown = true, md = true }
          if allowed_filetypes[vim.bo.filetype] then
            enable_spelunker()
          end
        end,
      })
      -- The misspelled words is set to be red and will be underlined.
      vim.cmd([[ 
                highlight spelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#ff0000
            ]])
      -- The white list for spelunker
      vim.g.spelunker_white_list_for_user = {
        "usepackage",
        "maketitle",
        "parskip",
        "documentclass",
        "graphicx",
        "epsfig",
        "amsfonts",
        "latexsym",
        "amssymb",
        "amsmath",
        "dsfont",
        "apacite",
        "headheight",
        "headsep",
        "footskip",
        "oddsidemargin",
        "abovedisplayskip",
        "belowdisplayskip",
        "natbibapa",
      }
    end,
  },
}