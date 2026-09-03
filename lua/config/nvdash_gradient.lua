-- NvDash pinta todas las líneas del header con un único highlight ("NvDashAscii"),
-- así que envolvemos open() y reasignamos un grupo del degradado por línea tras
-- cada render (inicial y redraw por resize).

local base46 = require("base46")
local nvdash = require("nvchad.nvdash")

local ART_LINES = 6

local function hex_to_rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

local function lerp(a, b, t)
  return math.floor(a + (b - a) * t + 0.5)
end

local function gradient(c1, c2, n)
  local r1, g1, b1 = hex_to_rgb(c1)
  local r2, g2, b2 = hex_to_rgb(c2)
  local out = {}
  for i = 0, n - 1 do
    local t = n == 1 and 0 or i / (n - 1)
    out[#out + 1] = string.format("#%02x%02x%02x", lerp(r1, r2, t), lerp(g1, g2, t), lerp(b1, b2, t))
  end
  return out
end

local function set_highlights()
  local c = base46.get_theme_tb("base_30")
  local shades = gradient(c.purple, c.pink, ART_LINES)
  for i, hex in ipairs(shades) do
    vim.api.nvim_set_hl(0, "NvDashGrad" .. i, { fg = hex })
  end
  vim.api.nvim_set_hl(0, "NvDashGradRule", { fg = c.light_grey })
end

local function recolor_header()
  local buf = vim.g.nvdash_buf
  if not buf or not vim.api.nvim_buf_is_valid(buf) then return end
  local ns = vim.api.nvim_get_namespaces()["nvdash"]
  if not ns then return end

  local headers = {}
  for _, m in ipairs(vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, { details = true })) do
    local vt = m[4].virt_text
    if vt and vt[1] and vt[1][2] == "NvDashAscii" then
      headers[#headers + 1] = m
    end
  end

  for i, m in ipairs(headers) do
    local id, row, col, det = m[1], m[2], m[3], m[4]
    local hl = i <= ART_LINES and ("NvDashGrad" .. i) or "NvDashGradRule"
    vim.api.nvim_buf_set_extmark(buf, ns, row, col, {
      id = id,
      virt_text = { { det.virt_text[1][1], hl } },
      virt_text_win_col = det.virt_text_win_col,
    })
  end
end

local orig_open = nvdash.open
nvdash.open = function(...)
  orig_open(...)
  recolor_header()
end

set_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    set_highlights()
    if vim.g.nvdash_displayed then recolor_header() end
  end,
})

assert(#gradient("#000000", "#ffffff", 3) == 3)
assert(gradient("#000000", "#ffffff", 3)[1] == "#000000")
assert(gradient("#000000", "#ffffff", 3)[3] == "#ffffff")
