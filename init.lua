-- 🏁 Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ⚙️ Configuración base
require("basic")    -- Opciones generales
require("keymaps")  -- Atajos
require("autocmds") -- Autocomandos
require("plugins")  -- Plugins (Lazy, etc.)

-- 💡 Configuración avanzada
require("cmp_settings") -- Autocompletado nvim-cmp
require("theme")        -- Tema y colores

-- 🧠 LSP (Lenguajes)
require("lsp") -- Carga mason + servidores

-- 🎨 Interfaz
require("config.lualine") -- Barra de estado
require("config.alpha")   -- Pantalla de inicio (Alpha)
