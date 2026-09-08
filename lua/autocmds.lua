vim.api.nvim_create_user_command("CPTemplate", function()
  if
    vim.bo.filetype ~= "cpp"
    or vim.api.nvim_buf_line_count(0) ~= 1
    or vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] ~= ""
  then
    vim.notify("CPTemplate requiere un buffer C++ vacío", vim.log.levels.WARN)
    return
  end
  local lines = vim.fn.readfile(vim.fn.stdpath("config") .. "/templates/cp_template.cpp")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end, { desc = "Insertar plantilla de programación competitiva" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.asm", "*.ASM", "*.inc", "*.INC" },
  callback = function()
    vim.bo.filetype = "asm"
    vim.bo.commentstring = "; %s"
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
})

-- .tf detecta filetype por contenido (choca con TinyFugue "tf");
-- archivos nuevos vacíos caen a "tf" en vez de "terraform".
-- Forzamos extensión .tf siempre a terraform.
vim.filetype.add({
  extension = {
    tf = "terraform",
  },
})
