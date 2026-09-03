-- 🏁 Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- ⚙️ Configuración base
require("basic")    -- Opciones generales
require("keymaps")  -- Atajos
require("autocmds") -- Autocomandos
require("plugins")  -- Plugins (Lazy, etc.)

-- En una instalación limpia, el build de base46 genera este caché después.
if vim.fn.isdirectory(vim.g.base46_cache) == 1 then
  for _, file in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. file)
  end
end

require("config.nvdash_gradient")

-- 💡 Configuración avanzada
require("cmp_settings") -- Autocompletado nvim-cmp

-- 🧠 LSP (Lenguajes)
require("lsp") -- Carga mason + servidores
