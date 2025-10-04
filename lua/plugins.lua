vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -- PLUGINS --
  { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
  { "catppuccin/nvim",                  name = "catppuccin",                             priority = 1000 },
  { "nvim-tree/nvim-tree.lua",          dependencies = "nvim-tree/nvim-web-devicons",    config = true },
  { "goolord/alpha-nvim",               dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- Autocompletado
  { "hrsh7th/nvim-cmp" },     -- motor de completado
  { "hrsh7th/cmp-nvim-lsp" }, -- LSP completions
  { "hrsh7th/cmp-buffer" },   -- sugerencias del buffer
  { "hrsh7th/cmp-path" },     -- rutas de archivos
  { "hrsh7th/cmp-cmdline" },  -- comandos
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim",          config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "windwp/nvim-autopairs",            config = true },
  { "nvim-telescope/telescope.nvim",    dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim",        dependencies = { "nvim-tree/nvim-web-devicons" } },
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")

      -- Carga los snippets en formato VSCode
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Opcional: recarga cuando edites tus propios snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/LuaSnip/snippets" })
    end,
  },
  { "saadparwaiz1/cmp_luasnip" },     -- integración
  { "rafamadriz/friendly-snippets" }, -- snippets ya hechos (React, C++, etc.)
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup()
    end,
  }
})
