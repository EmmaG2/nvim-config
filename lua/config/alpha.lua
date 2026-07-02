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

vim.cmd([[hi AlphaHeader guifg=#c6a0f6]]) -- violeta Catppuccin
vim.cmd([[hi AlphaFooter guifg=#f5c2e7]]) -- rosado Catppuccin

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- 🚀 CARGA FINAL
alpha.setup(dashboard.config)
