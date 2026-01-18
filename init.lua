vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("basic")
require("keymaps")
require("autocmds")
require("plugins")

require("cmp_settings")
require("theme")

require("lsp")

require("config.lualine")
require("config.alpha")
