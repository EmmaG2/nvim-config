-- 🏁 Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ⚙️ Config minimal — solo plugin manager, keymaps, tema, dashboard
require("plugins")
require("keymaps")
require("theme")
require("config.alpha")
