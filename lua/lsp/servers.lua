local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Capacidades web (con soporte de snippets habilitado para HTML/CSS/emmet)
local web_caps = require("cmp_nvim_lsp").default_capabilities()

-- Capacidades C/C++ (snippets desactivados para evitar ruido)
local cpp_caps = require("cmp_nvim_lsp").default_capabilities()
cpp_caps.textDocument.completion.completionItem.snippetSupport = false

-- ─── C / C++ ────────────────────────────────────────────────────────────────

vim.lsp.config('clangd', {
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

vim.lsp.config('lua_ls', {
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

local vue_plugin_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin"

vim.lsp.config('ts_ls', {
  capabilities = web_caps,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_plugin_path,
        languages = { "vue" },
      },
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints             = "all",
        includeInlayPropertyDeclarationTypeHints   = true,
        includeInlayFunctionLikeReturnTypeHints    = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints             = "all",
        includeInlayPropertyDeclarationTypeHints   = true,
        includeInlayFunctionLikeReturnTypeHints    = true,
      },
    },
  },
})

-- ─── ESLint ──────────────────────────────────────────────────────────────────

vim.lsp.config('eslint', {
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

vim.lsp.config('vue_ls', {
  capabilities = web_caps,
  filetypes = { "vue" },
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
})

-- ─── Astro ──────────────────────────────────────────────────────────────────

vim.lsp.config('astro', {
  capabilities = web_caps,
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
})

-- ─── HTML ────────────────────────────────────────────────────────────────────

vim.lsp.config('html', {
  capabilities = web_caps,
  filetypes = { "html", "htmldjango", "templ" },
  init_options = {
    provideFormatter = false,
  },
})

-- ─── CSS / SCSS / LESS ───────────────────────────────────────────────────────

vim.lsp.config('cssls', {
  capabilities = web_caps,
})

-- ─── Tailwind CSS ────────────────────────────────────────────────────────────

vim.lsp.config('tailwindcss', {
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
          { "cn\\(([^)]*)\\)",    "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "clsx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cva\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

-- ─── Emmet ───────────────────────────────────────────────────────────────────

vim.lsp.config('emmet_language_server', {
  capabilities = web_caps,
  filetypes = {
    "html", "css", "scss",
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "vue", "astro",
  },
})

-- ─── Habilitar todos los servidores ─────────────────────────────────────────

vim.lsp.enable({
  'clangd', 'lua_ls', 'ts_ls', 'eslint', 'vue_ls',
  'astro', 'html', 'cssls', 'tailwindcss', 'emmet_language_server',
})
