return {
  {
    "lervag/vimtex",
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- vim.g.vimtex_view_method = "zathura"
      if vim.uv.os_uname().sysname == "Darwin" then
        vim.g.vimtex_view_method = "sioyek" -- or "skim"
        vim.g.vimtex_view_skim_sync = 1
      elseif vim.uv.os_uname().sysname == "Linux" then
        vim.g.vimtex_view_method = "zathura"
      end

      vim.g.vimtex_imaps_enabled = 0
      vim.g.vimtex_toc_config = {
        split_width = 30,
        show_help = 0,
      }

      -- Configure VimTeX compiler
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "",
        callback = 1,
        continuous = 1,
        executable = "latexmk",
        hooks = {},
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-pdf",
          "-pvc",
          "-pvctimeout-",
          "-view=none",
        },
      }

      -- Some quickfix configuration
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull \\hbox",
        "Overfull \\hbox",
      }

      -- Buffer-local mappings and display options live in after/ftplugin/tex.lua.

      -- This part is to set the conceal function.
      vim.g.tex_conceal = "abdmg"
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.cmd([[ 
      let g:vimtex_syntax_custom_cmds_with_concealed_delims = [ 
         \ {'name':'overline', 'mathmode':1, 'cchar_open':'⌈', 'cchar_close': '⌉'},
         \ {'name':'underline', 'mathmode':1, 'cchar_open':'⌊', 'cchar_close': '⌋'},
         \]
      ]])
      -- Syntax rules stay with the TeX buffer and only conceal commands in math mode.
      vim.g.vimtex_syntax_custom_cmds = {
        { name = "limits", mathmode = true, conceal = true, opt = false, arg = false },
        { name = "Longrightarrow", mathmode = true, concealchar = "⟹" },
        { name = "Longleftarrow", mathmode = true, concealchar = "⟸" },
        { name = "iff", mathmode = true, concealchar = "⇔" },
      }

      --This part is used for delete auxiliary files of latex.
      local clean_aux_files = function()
        local aux_extensions = {
          "aux",
          "bbl",
          "blg",
          "log",
          "out",
          "toc",
          "bcf",
          "run.xml",
          "fls",
          "fdb_latexmk",
          "snm",
          "nav",
          "vrb",
          "synctex.gz",
          "xdv",
        }

        local current_dir = vim.fn.expand("%:p:h")
        local base_name = vim.fn.expand("%:t:r")

        for _, ext in ipairs(aux_extensions) do
          local file = current_dir .. "/" .. base_name .. "." .. ext
          if vim.fn.filereadable(file) == 1 then
            os.remove(file)
            print("Removed:" .. file)
          end
        end
      end

      --[[      
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventCompileSuccess",
        callback = function()
          clean_aux_files()
        end,
      })
--]]
      vim.api.nvim_create_user_command("VimtexCleanAux", clean_aux_files, {})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.keymap.set("n", "<localleader>lx", ":VimtexCleanAux<CR>", {
            buffer = true,
            silent = true,
            noremap = true,
            desc = "Clean LaTeX auxiliary files (custom)",
          })
        end,
      })
    end,
  },
}
