-- 🏁 Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 🩹 ftplugin por defecto de Nvim llaman treesitter.start() sin pcall;
-- sin parsers compilados (config minimal) esto crashea al abrir cualquier
-- archivo. Degrada a syntax regex en vez de tronar.
local ts_start = vim.treesitter.start
vim.treesitter.start = function(...)
  return (pcall(ts_start, ...))
end

-- ⚙️ Config minimal — solo plugin manager, keymaps, tema, dashboard
require("plugins")
require("keymaps")
require("theme")
require("config.alpha")
