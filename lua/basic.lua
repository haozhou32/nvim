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
vim.keymap.set("n", "<C-x>", ":bd<CR>", { desc = "Close current buffer" })

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
require("tex_templates").setup()
