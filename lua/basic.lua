-- Desactiva netrw antes de cargar plugins (requisito de nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true         -- números de línea
vim.opt.relativenumber = true -- números relativos (rápido moverse)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus" -- copiar/pegar con el sistema
vim.opt.termguicolors = true
vim.opt.colorcolumn = { "80", "100" }
-- Persiste historial de undo entre sesiones (undotree funciona cross-session)
vim.opt.undofile = true
