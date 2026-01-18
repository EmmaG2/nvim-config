local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[███╗   ██╗██╗███████╗██████╗     ███╗   ███╗ █████╗ ██╗███╗   ██╗██╗]],
  [[████╗  ██║██║██╔════╝██╔══██╗    ████╗ ████║██╔══██╗██║████╗  ██║██║]],
  [[██╔██╗ ██║██║█████╗  ██████╔╝    ██╔████╔██║███████║██║██╔██╗ ██║██║]],
  [[██║╚██╗██║██║██╔══╝  ██╔══██╗    ██║╚██╔╝██║██╔══██║██║██║╚██╗██║╚═╝]],
  [[██║ ╚████║██║███████╗██║  ██║    ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║██╗]],
  [[╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝]],
  [[                    💫 NieR Automata — 2B 💫                    ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "  Nuevo archivo", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰈞  Buscar archivo", ":Telescope find_files<CR>"),
  dashboard.button("r", "󰄉  Archivos recientes", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "󰅚  Salir", ":qa<CR>"),
}

dashboard.section.footer.val = {
  [[⠄⠄⠄⠄⢠⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣯⢻⣿⣿⣿⣿⣆⠄⠄⠄]],
  [[⠄⠄⣼⢀⣿⣿⣿⣿⣏⡏⠄⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢻⣿⣿⣿⣿⡆⠄⠄]],
  [[⠄⠄⡟⣼⣿⣿⣿⣿⣿⠄⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⣿⣇⢻⣿⣿⣿⣿⠄⠄]],
  [[⠄⢰⠃⣿⣿⠿⣿⣿⣿⠄⠄⠄⠄⠄⠄⠙⠿⣿⣿⣿⣿⣿⠄⢿⣿⣿⣿⡄⠄]],
  [[⠄⢸⢠⣿⣿⣧⡙⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠈⠛⢿⣿⣿⡇⠸⣿⡿⣸⡇⠄]],
  [[⠄⠈⡆⣿⣿⣿⣿⣦⡙⠳⠄⠄⠄⠄⠄⠄⢀⣠⣤⣀⣈⠙⠃⠄⠿⢇⣿⡇⠄]],
  [[⠄⠄⡇⢿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⣠⣶⣿⣿⣿⣿⣿⣿⣷⣆⡀⣼⣿⡇⠄]],
  [[⠄⠄⢹⡘⣿⣿⣿⢿⣷⡀⠄⢀⣴⣾⣟⠉⠉⠉⠉⣽⣿⣿⣿⣿⠇⢹⣿⠃⠄]],
  [[⠄⠄⠄⢷⡘⢿⣿⣎⢻⣷⠰⣿⣿⣿⣿⣦⣀⣀⣴⣿⣿⣿⠟⢫⡾⢸⡟⠄⠄]],
  [[⠄⠄⠄⠄⠻⣦⡙⠿⣧⠙⢷⠙⠻⠿⢿⡿⠿⠿⠛⠋⠉⠄⠂⠘⠁⠞⠄⠄⠄]],
  [[⠄⠄⠄⠄⠄⠈⠙⠑⣠⣤⣴⡖⠄⠿⣋⣉⣉⡁⠄⢾⣦⠄⠄⠄⠄⠄⠄⠄⠄]],
}

vim.cmd([[hi AlphaHeader guifg=#c6a0f6]])
vim.cmd([[hi AlphaFooter guifg=#f5c2e7]])

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.config)
