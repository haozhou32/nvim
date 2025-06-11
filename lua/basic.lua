vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

--NOTE: [[ Setting options ]]

--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.o.showmatch = true
vim.o.matchtime = 3
vim.g.maplocalleader = "\\"
vim.opt.spelloptions = "camel"

--NOTE: [[ Basic Keymaps ]]

--  See `:help vim.keymap.set()`
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>oq", vim.diagnostic.setloclist, { desc = "[O]pen diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>cq", ":lclose<CR>", { desc = "[C]lose diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Navigate buffers
vim.keymap.set("n", "<C-n>", ":bnext<CR>", { desc = "Move focus to the [N]ext buffer" })
vim.keymap.set("n", "<C-p>", ":bprevious<CR>", { desc = "Move focus to the [P]revious buffer " })
vim.keymap.set("n", "<C-q>", ":bd<CR>", { desc = "Close current buffer" })

-- Toggle spell checking
vim.keymap.set("n", "zs", function()
  if vim.wo.spell then
    vim.wo.spell = false
    print("Spell checking disabled")
  else
    vim.wo.spell = true
    print("Spell checking enabled")
  end
end, { desc = "Toggle spell checking" })

--NOTE: [[ Basic Autocommands ]]

--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--NOTE: insert latex templates
function _G.select_template()
  local templates = {
    article = "~/.config/nvim/templates/article.tex",
    beamer = "~/.config/nvim/templates/beamer.tex",
    book = "~/.config/nvim/templates/book.tex",
    notes = "~/.config/nvim/templates/notes.tex",
  }
  local items = {}
  for k, _ in pairs(templates) do
    table.insert(items, k)
  end

  vim.ui.select(items, {
    prompt = "Select template:",
  }, function(choice)
    if choice then
      vim.cmd("0r " .. templates[choice])
    end
  end)
end

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  pattern = "*.tex",
  callback = select_template,
})

vim.api.nvim_create_user_command("TexTemplate", select_template, {}) -- Manually open a template.

--NOTE: Markdown table formatter
vim.keymap.set("n", "<leader>ta", function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()

  if line:match("|") then
    local start_line = cursor_pos[1]
    local end_line = cursor_pos[1]

    -- Find table boundaries
    while start_line > 1 do
      local prev_line = vim.api.nvim_buf_get_lines(0, start_line - 2, start_line - 1, false)[1]
      if not prev_line:match("|") then
        break
      end
      start_line = start_line - 1
    end

    while end_line < vim.api.nvim_buf_line_count(0) do
      local next_line = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1]
      if not next_line:match("|") then
        break
      end
      end_line = end_line + 1
    end

    -- Get table content
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    -- Find maximum widths for all columns
    local max_widths = {}
    for _, l in ipairs(lines) do
      local cols = vim.split(l, "|")
      for i, col in ipairs(cols) do
        if i > 1 and i < #cols then -- Skip first and last empty parts
          max_widths[i - 1] = math.max(max_widths[i - 1] or 0, #vim.trim(col))
        end
      end
    end

    -- Format delimiter line if it exists
    for i, l in ipairs(lines) do
      if l:match("^|%-") then
        local new_delimiter = "|"
        for j = 1, #max_widths do
          new_delimiter = new_delimiter .. string.rep("-", max_widths[j] + 2) .. "|"
        end
        lines[i] = new_delimiter
      end
    end

    -- Update buffer
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)

    -- Align the table
    vim.cmd(string.format("%d,%d!column -t -s '|' -o '|'", start_line, end_line))

    -- Restore cursor
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end
end, { desc = "Align markdown table" })
