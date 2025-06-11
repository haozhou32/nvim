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
        -- -- Sioyek-specific refresh fix for macOS. Uncomment the following lines if Sioyek does not refresh automatically.
        -- -- Function to notify Sioyek
        -- local function notify_sioyek()
        --   -- Get the current buffer's vimtex table
        --   local vimtex = vim.b.vimtex
        --   if vimtex and vimtex.out then
        --     local pdf_file = vimtex.out()
        --     -- Check if PDF file exists
        --     if vim.fn.filereadable(pdf_file) == 1 then
        --       -- Touch the PDF file to trigger Sioyek's file watcher
        --       vim.defer_fn(function()
        --         vim.fn.system("touch " .. vim.fn.shellescape(pdf_file))
        --       end, 200) -- 200ms delay
        --     end
        --   end
        -- end
        -- -- Create autocommand for VimtexEventCompileSuccess
        -- vim.api.nvim_create_augroup("vimtex_sioyek", { clear = true })
        -- vim.api.nvim_create_autocmd("User", {
        --   group = "vimtex_sioyek",
        --   pattern = "VimtexEventCompileSuccess",
        --   callback = notify_sioyek,
        -- })
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

      -- Change some key mappings. For default key mappings, check :help vimtex-default-mappings.
      vim.keymap.set("n", "dsm", "<plug>(vimtex-env-delete-math)", { silent = true })
      vim.keymap.set("n", "csm", "<plug>(vimtex-env-change-math)", { silent = true })
      vim.keymap.set("n", "tsm", "<plug>(vimtex-env-toggle-math)", { silent = true })
      vim.keymap.set({ "x", "o" }, "ai", "<plug>(vimtex-am)", { silent = true })
      vim.keymap.set({ "x", "o" }, "ii", "<plug>(vimtex-im)", { silent = true })
      vim.keymap.set({ "x", "o" }, "am", "<plug>(vimtex-a$)", { silent = true })
      vim.keymap.set({ "x", "o" }, "im", "<plug>(vimtex-i$)", { silent = true })
      vim.keymap.set("n", "<localleader>lw", "<Cmd>VimtexCountWords<CR>", { silent = true })

      -- This part is to set the conceal function.
      vim.g.tex_conceal = "abdmg"
      vim.opt.conceallevel = 2
      vim.g.vimtex_syntax_conceal_disable = 0
      vim.cmd([[ 
      let g:vimtex_syntax_custom_cmds_with_concealed_delims = [ 
         \ {'name':'overline', 'mathmode':1, 'cchar_open':'⌈', 'cchar_close': '⌉'},
         \ {'name':'underline', 'mathmode':1, 'cchar_open':'⌊', 'cchar_close': '⌋'},
         \]
      ]])
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          local conceal_rules = {
            { "\\\\limits", " " },
            { "\\\\Longrightarrow", "⟹ " },
            { "\\\\Longleftarrow", "⟸ " },
            { "\\\\iff", "⇔" },
          }
          for _, rule in ipairs(conceal_rules) do
            vim.fn.matchadd("Conceal", rule[1], 10, -1, { conceal = rule[2] })
          end
        end,
      })

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
