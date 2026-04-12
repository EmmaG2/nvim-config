-- Mason setup
require("mason").setup({
  ui = {
    icons = {
      package_installed   = "✓",
      package_pending     = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- Mason LSP config
require("mason-lspconfig").setup({
  ensure_installed = {
    -- C / C++ / Lua
    -- clangd: instalar con `sudo dnf install clang-tools-extra`
    -- (Mason no tiene binario precompilado para aarch64)
    "lua_ls",

    -- Python
    "pyright",
    "ruff",

    -- JavaScript / TypeScript / React
    "ts_ls",
    "eslint",

    -- Vue
    "vue_ls",

    -- Astro
    "astro",

    -- Web general
    "html",
    "cssls",
    "tailwindcss",
    "emmet_language_server",
  },
})
