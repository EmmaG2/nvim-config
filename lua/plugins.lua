-- Bootstrap: clona lazy.nvim si no existe
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  ---------------------------------------------------------------------
  -- 🌈 Temas y Apariencia
  ---------------------------------------------------------------------
  { "catppuccin/nvim",                     name = "catppuccin", priority = 999 },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",        opts = {} },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        names    = false, -- no pintar palabras tipo 'red', solo códigos
        css      = true,  -- rgb, hsl, etc.
        tailwind = true,
        mode     = "background",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      -- El provider 'treesitter' usa nvim-treesitter.locals, módulo del
      -- branch master archivado que rompe en nvim 0.12. Se omite y se usa
      -- LSP (document highlight) con fallback a regex.
      require("illuminate").configure({
        providers = { "lsp", "regex" },
      })
    end,
  },
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
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

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
    branch = "master",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "cpp", "c", "lua", "python", "java",
          "javascript", "typescript", "tsx",
          "html", "css",
          "vue", "astro",
          "json", "yaml", "toml",
        },
        highlight = { enable = true },
        indent   = { enable = true },
        textobjects = {
          select = {
            enable    = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable              = true,
            goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          },
        },
      })
    end,
  },

  ---------------------------------------------------------------------
  -- ⚙️ LSP y Autocompletado
  ---------------------------------------------------------------------
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim",          config = true },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },


  -- Autocompletado
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- firma de funciones en el menú
  { "onsails/lspkind.nvim" },                -- íconos VSCode en el menú de completado

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
  { "numToStr/Comment.nvim",        config = true },
  { "kylechui/nvim-surround",       config = true },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s",     function() require("flash").jump() end,            mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",     function() require("flash").treesitter() end,      mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "<c-s>", function() require("flash").toggle() end,          mode = { "c" },            desc = "Flash toggle" },
    },
  },
  { "windwp/nvim-autopairs",       config = true },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close         = true,
          enable_rename        = true,
          enable_close_on_slash = true,
        },
      })
    end,
  },

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
  -- 💾 Sesiones y Utilidad
  ---------------------------------------------------------------------
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { dir = vim.fn.stdpath("state") .. "/sessions/" },
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restaurar sesión (cwd)" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restaurar última sesión" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "No guardar sesión al salir" },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },

  ---------------------------------------------------------------------
  -- 🔧 Control de versiones
  ---------------------------------------------------------------------
  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-fugitive" },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>",            desc = "LazyGit (repo)" },
      { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit (archivo)" },
      { "<leader>gl", "<cmd>LazyGitFilter<cr>",      desc = "LazyGit log (commits)" },
    },
  },
  {
    "folke/which-key.nvim",
    config = true,
  }


})

require("telescope").load_extension("fzf")
