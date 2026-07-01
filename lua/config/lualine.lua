require("nvim-tree").setup({})

require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { width = 0.9 },
  }
})

require('lualine').setup({
  options = {
    theme = 'catppuccin-nvim',
    icons_enabled = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = {
      {
        function() return require("noice").api.statusline.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.statusline.mode.has() end,
        color = { fg = "#ff9e64" },
      },
      'diagnostics', 'encoding', 'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location', function() return os.date("%H:%M") end },
  },
})
