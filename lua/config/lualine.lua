require("nvim-tree").setup({})

require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { width = 0.9 },
  }
})

require('lualine').setup({
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'diagnostics', 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location', 'os.date("%H:%M")' },
  },
})

require("catppuccin").setup({ integrations = { lualine = true } })
