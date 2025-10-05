vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({

  ---------------------------------------------------------------------
  -- 🌈 Temas y Apariencia
  ---------------------------------------------------------------------
  { "catppuccin/nvim",                     name = "catppuccin", priority = 999 },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",        opts = {} },
  { "RRethy/vim-illuminate" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup()
    end,
  },
  { "goolord/alpha-nvim",               dependencies = { "nvim-tree/nvim-web-devicons" } },

  ---------------------------------------------------------------------
  -- 🗂️ Navegación y Exploración
  ---------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  ---------------------------------------------------------------------
  -- 🧠 Sintaxis y Análisis de Código
  ---------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  ---------------------------------------------------------------------
  -- ⚙️ LSP y Autocompletado
  ---------------------------------------------------------------------
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim",          config = true },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletado
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({
        paths = "~/.config/nvim/LuaSnip/snippets",
      })
    end,
  },
  { "rafamadriz/friendly-snippets" },
  { "windwp/nvim-autopairs",       config = true },

  ---------------------------------------------------------------------
  -- 🧹 Formateo y Limpieza. Nota: La configuración está en
  -- /config/confom.lua
  ---------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    config = function()
      require("config.conform")
    end,
  },

  ---------------------------------------------------------------------
  -- 🔧 Control de Versiones
  ---------------------------------------------------------------------
  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-fugitive" },

})
