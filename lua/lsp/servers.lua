local lspconfig   = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Capacidades web (con soporte de snippets habilitado para HTML/CSS/emmet)
local web_caps = require("cmp_nvim_lsp").default_capabilities()

-- Capacidades C/C++ (snippets desactivados para evitar ruido)
local cpp_caps = require("cmp_nvim_lsp").default_capabilities()
cpp_caps.textDocument.completion.completionItem.snippetSupport = false

-- ─── C / C++ ────────────────────────────────────────────────────────────────

lspconfig.clangd.setup({
  capabilities = cpp_caps,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--fallback-style=Google",
  },
  root_dir = function()
    return vim.fn.getcwd()
  end,
})

-- ─── Lua ────────────────────────────────────────────────────────────────────

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- ─── TypeScript / JavaScript / React ────────────────────────────────────────

lspconfig.ts_ls.setup({
  capabilities = web_caps,
  -- ts_ls maneja JS, TS, JSX, TSX (NO .vue, eso lo maneja volar)
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints    = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints  = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints    = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints  = true,
      },
    },
  },
})

-- ─── ESLint ──────────────────────────────────────────────────────────────────

lspconfig.eslint.setup({
  capabilities = web_caps,
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
    "vue", "astro",
  },
  -- Aplica fixes de ESLint automáticamente al guardar
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer  = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- ─── Vue 3 (Volar) ──────────────────────────────────────────────────────────
-- hybridMode = false: Volar gestiona TODO el soporte TypeScript dentro de .vue
-- (no necesita ts_ls para archivos Vue)

-- Volar 3.x always runs in hybrid mode (takeover mode was removed in v3.0.0).
-- It delegates TypeScript to ts_ls automatically via the on_init handler
-- defined in nvim-lspconfig's vue_ls.lua.
lspconfig.vue_ls.setup({
  capabilities = web_caps,
  filetypes = { "vue" },
})

-- ─── Astro ──────────────────────────────────────────────────────────────────

lspconfig.astro.setup({
  capabilities = web_caps,
  -- Disable LSP formatting: astro-ls uses a bundled prettier without the
  -- astro plugin, causing repeated warnings. Conform handles formatting.
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

-- ─── HTML ────────────────────────────────────────────────────────────────────

lspconfig.html.setup({
  capabilities = web_caps,
  filetypes = { "html", "htmldjango", "templ" },
  init_options = {
    provideFormatter = false, -- dejamos formateo a Prettier
  },
})

-- ─── CSS / SCSS / LESS ───────────────────────────────────────────────────────

lspconfig.cssls.setup({
  capabilities = web_caps,
})

-- ─── Tailwind CSS ────────────────────────────────────────────────────────────

lspconfig.tailwindcss.setup({
  capabilities = web_caps,
  filetypes = {
    "html", "css", "scss",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "vue", "astro",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          -- Soporta cn(), clsx(), cva() y similares
          { "cn\\(([^)]*)\\)",    "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "clsx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cva\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

-- ─── Emmet ───────────────────────────────────────────────────────────────────

lspconfig.emmet_language_server.setup({
  capabilities = web_caps,
  filetypes = {
    "html", "css", "scss",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "vue", "astro",
  },
})
