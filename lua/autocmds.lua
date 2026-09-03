vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  command = "0r ~/.config/nvim/templates/cp_template.cpp"
})

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
