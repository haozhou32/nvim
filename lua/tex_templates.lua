local M = {}

local function can_edit(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].modifiable
end

local function is_empty(bufnr)
  return vim.api.nvim_buf_line_count(bufnr) == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == ""
end

function M.select(bufnr)
  -- Keep the original buffer even if the user switches buffers while choosing.
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not can_edit(bufnr) then
    vim.notify("Cannot insert a LaTeX template into this buffer.", vim.log.levels.WARN)
    return
  end

  local template_dir = vim.fn.stdpath("config") .. "/templates"
  local templates = vim.tbl_filter(function(path)
    return vim.fn.filereadable(path) == 1
  end, vim.fn.globpath(template_dir, "*.tex", false, true))
  table.sort(templates)

  if #templates == 0 then
    vim.notify("No LaTeX templates found in " .. template_dir, vim.log.levels.WARN)
    return
  end

  vim.ui.select(templates, {
    prompt = "LaTeX Templates",
    format_item = function(path)
      return vim.fn.fnamemodify(path, ":t:r")
    end,
  }, function(template)
    if not template then
      return
    end
    if not can_edit(bufnr) then
      vim.notify("The LaTeX template's target buffer is no longer editable.", vim.log.levels.WARN)
      return
    end

    local ok, lines = pcall(vim.fn.readfile, template)
    if not ok then
      vim.notify("Could not read LaTeX template: " .. tostring(lines), vim.log.levels.ERROR)
      return
    end

    -- Replace the initial empty line, otherwise prepend without deleting content.
    vim.api.nvim_buf_set_lines(bufnr, 0, is_empty(bufnr) and 1 or 0, false, lines)
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("tex-templates", { clear = true }),
    pattern = "*.tex",
    callback = function(event)
      -- Wait for the UI/plugins, but retain the buffer that triggered the event.
      vim.schedule(function()
        if can_edit(event.buf) and is_empty(event.buf) then
          M.select(event.buf)
        end
      end)
    end,
  })

  vim.api.nvim_create_user_command("TexTemplate", function()
    M.select()
  end, { desc = "Insert a LaTeX template" })
end

return M
