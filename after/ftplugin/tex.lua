-- Apply TeX customizations after the default filetype mappings and options.
local undo = { "setlocal conceallevel<" }

local function map(modes, lhs, rhs)
  vim.keymap.set(modes, lhs, rhs, { buffer = true, silent = true })
  for _, mode in ipairs(type(modes) == "table" and modes or { modes }) do
    table.insert(undo, "silent! execute " .. vim.fn.string(mode .. "unmap <buffer> " .. lhs))
  end
end

map("n", "dsm", "<plug>(vimtex-env-delete-math)")
map("n", "csm", "<plug>(vimtex-env-change-math)")
map("n", "tsm", "<plug>(vimtex-env-toggle-math)")
map({ "x", "o" }, "ai", "<plug>(vimtex-am)")
map({ "x", "o" }, "ii", "<plug>(vimtex-im)")
map({ "x", "o" }, "am", "<plug>(vimtex-a$)")
map({ "x", "o" }, "im", "<plug>(vimtex-i$)")
map("n", "<localleader>lw", "<Cmd>VimtexCountWords<CR>")

-- Set local values only, leaving other buffers' display defaults unchanged.
vim.opt_local.conceallevel = 2

-- Remove our customizations if this buffer changes filetype.
if vim.b.undo_ftplugin then
  -- Isolate existing :lua cleanup so it cannot consume our following commands.
  table.insert(undo, 1, "execute " .. vim.fn.string(vim.b.undo_ftplugin))
end
vim.b.undo_ftplugin = table.concat(undo, " | ")
