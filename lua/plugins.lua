-- Bootstrap: clona lazy.nvim si no existe
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
  -- NvChad UI: statusline, tabufline y NvDash. base46 = motor de tema (catppuccin)
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvchad/ui",
    lazy = false,
    config = function()
      require("nvchad")
    end,
  },
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    opts = {},
  },
  { "nvchad/volt",                         lazy = true },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
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
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup()
    end,
  },

  ---------------------------------------------------------------------
  -- 🗂️ Navegación y Exploración
  ---------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      filters = { dotfiles = false, git_ignored = false },
      disable_netrw = true,
      hijack_cursor = true,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        width = 30,
        preserve_window_proportions = true,
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = true },
        icons = {
          show = {
            folder = true,
            folder_arrow = true,
            file = true,
            git = true,
          },
          glyphs = {
            default = "󰈚",
            folder = {
              default = "",
              empty = "",
              empty_open = "",
              open = "",
              symlink = "",
            },
            git = { unmerged = "" },
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
          preview_width = 0.55,
          width = 0.87,
          height = 0.80,
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- Carpetas que como dev nunca tocamos a mano: se ocultan aunque
        -- no_ignore muestre gitignored (para poder buscar .env, etc.)
        file_ignore_patterns = {
          "node_modules/",
          "pb_data/",
          "%.git/",
          "dist/",
          "build/",
          "%.next/",
          "target/",
          "vendor/",
          "%.venv/",
          "__pycache__/",
          "%.cache/",
          "%.lock$",
        },
      },
      pickers = {
        find_files = { hidden = true, no_ignore = true },
      },
    },
  },

  ---------------------------------------------------------------------
  -- 🧠 Sintaxis y Análisis de Código
  ---------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local parsers = {
        "cpp", "c", "lua", "python", "java",
        "javascript", "typescript", "tsx",
        "html", "css", "vue", "astro",
        "json", "yaml", "toml", "terraform", "hcl",
        "markdown", "markdown_inline", "http", "asm", "nasm",
      }

      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "cpp", "c", "lua", "python", "java",
          "javascript", "javascriptreact", "typescript", "typescriptreact",
          "html", "css", "vue", "astro", "json", "jsonc", "yaml", "toml",
          "terraform", "hcl", "markdown", "http", "asm", "nasm",
        },
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = { lookahead = true },
      move = { set_jumps = true },
    },
    keys = {
      { "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, mode = { "x", "o" } },
      { "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, mode = { "x", "o" } },
      { "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, mode = { "x", "o" } },
      { "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, mode = { "x", "o" } },
      { "aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end, mode = { "x", "o" } },
      { "ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end, mode = { "x", "o" } },
      { "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
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
  { "hrsh7th/cmp-nvim-lua" },                -- fuente "nvim_lua" usada en cmp_settings.lua
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
  { "numToStr/Comment.nvim",       config = true },
  { "kylechui/nvim-surround",      config = true },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s",     function() require("flash").jump() end,       mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S",     function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "<c-s>", function() require("flash").toggle() end,     mode = { "c" },           desc = "Flash toggle" },
    },
  },
  { "windwp/nvim-autopairs",   config = true },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close          = true,
          enable_rename         = true,
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
  {
    "Maxteabag/sqlit.nvim",
    opts = {},
    keys = {
      { "<leader>D", function() require("sqlit").open() end, desc = "Database (sqlit)" },
    },
  },

  ---------------------------------------------------------------------
  -- 🖼️ Imágenes. Nota: requiere abrir nvim desde Kitty (protocolo
  -- kitty graphics) y tener imagemagick instalado (brew install imagemagick).
  -- SVG requiere el delegate librsvg (brew install librsvg) para que
  -- magick_cli pueda rasterizarlo.
  ---------------------------------------------------------------------
  {
    "3rd/image.nvim",
    build = false, -- evita build de luarocks, magick_cli solo necesita el binario de imagemagick
    opts = {
      backend = "kitty",
      processor = "magick_cli",
      integrations = {
        markdown = { enabled = true },
        neorg    = { enabled = false },
      },
      max_width_window_percentage = 80,
      max_height_window_percentage = 50,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif", "*.svg" },
    },
  },
  {
    -- version fija: el rockspec de `main` pide tree-sitter-http 0.0.35, que no existe en luarocks
    "rest-nvim/rest.nvim",
    version = "v3.13.0",
    ft = "http",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "<leader>hr", "<cmd>Rest run<cr>",        desc = "HTTP: ejecutar request bajo el cursor" },
      { "<leader>hl", "<cmd>Rest last<cr>",       desc = "HTTP: repetir última request" },
      { "<leader>ho", "<cmd>Rest open<cr>",       desc = "HTTP: abrir panel de resultado" },
      { "<leader>he", "<cmd>Rest env select<cr>", desc = "HTTP: seleccionar env" },
      { "<leader>hc", "<cmd>Rest cookies<cr>",    desc = "HTTP: ver cookie jar" },
      { "<leader>hL", "<cmd>Rest logs<cr>",       desc = "HTTP: ver logs" },
    },
    -- rest.nvim formatea el body con 'formatprg' del filetype de la respuesta
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        callback = function()
          vim.bo.formatprg = "jq ."
        end,
      })
    end,
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

-- pcall: fzf-native aún no compilado (falta `make`) en instalación limpia
pcall(function() require("telescope").load_extension("fzf") end)
