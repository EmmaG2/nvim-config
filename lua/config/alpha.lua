local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[███╗   ██╗██╗███████╗██████╗     ███╗   ███╗ █████╗ ██╗███╗   ██╗██╗]],
  [[████╗  ██║██║██╔════╝██╔══██╗    ████╗ ████║██╔══██╗██║████╗  ██║██║]],
  [[██╔██╗ ██║██║█████╗  ██████╔╝    ██╔████╔██║███████║██║██╔██╗ ██║██║]],
  [[██║╚██╗██║██║██╔══╝  ██╔══██╗    ██║╚██╔╝██║██╔══██║██║██║╚██╗██║╚═╝]],
  [[██║ ╚████║██║███████╗██║  ██║    ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║██╗]],
  [[╚═╝  ╚═══╝╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝]],
  [[──────────────────────────────────────────────────────────────────]],
}

-- Gradiente Catppuccin Mocha (mauve -> rosewater) aplicado linea a linea
local gradient = { "#cba6f7", "#d3b2f2", "#dcbdec", "#e4c9e7", "#edd4e1", "#f5e0dc" }
for i, hex in ipairs(gradient) do
  vim.cmd(("hi AlphaHeader%d guifg=%s"):format(i, hex))
end
vim.cmd([[hi AlphaHeaderRule guifg=#6c7086]]) -- overlay0

dashboard.section.header.opts.hl = {}
for i in ipairs(gradient) do
  dashboard.section.header.opts.hl[i] = { { ("AlphaHeader%d"):format(i), 0, -1 } }
end
dashboard.section.header.opts.hl[#gradient + 1] = { { "AlphaHeaderRule", 0, -1 } }

dashboard.section.buttons.val = {
  dashboard.button("e", "  Nuevo archivo", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "󰈞  Buscar archivo", ":Telescope find_files<CR>"),
  dashboard.button("r", "󰄉  Archivos recientes", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "󰅚  Salir", ":qa<CR>"),
}

vim.cmd([[hi AlphaFooter guifg=#b4befe]]) -- lavender

-- Caja de ancho dinamico segun el texto de stats de lazy.nvim
local function boxed(text)
  return {
    "      · · ✦ · ·",
    "╭" .. string.rep("─", #text + 2) .. "╮",
    "│ " .. text .. " │",
    "╰" .. string.rep("─", #text + 2) .. "╯",
  }
end

dashboard.section.footer.val = boxed("cargando...")
dashboard.section.footer.opts.hl = "AlphaFooter"

-- Stats reales de lazy.nvim solo se conocen tras terminar de cargar,
-- por eso se recalcula el footer y se re-dibuja al disparar AlphaReady.
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  once = true,
  callback = function()
    local ok, lazy = pcall(require, "lazy")
    if not ok then return end
    local stats = lazy.stats()
    local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
    dashboard.section.footer.val = boxed(("⚡ %d/%d plugins · %gms"):format(stats.loaded, stats.count, ms))
    alpha.redraw()
  end,
})

alpha.setup(dashboard.config)
