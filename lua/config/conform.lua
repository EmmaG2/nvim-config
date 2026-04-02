local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    -- Sistemas
    cpp    = { "clang_format" },
    c      = { "clang_format" },
    lua    = { "stylua" },
    python = { "black" },

    -- Web (Prettier maneja todo)
    javascript      = { "prettier" },
    javascriptreact = { "prettier" },
    typescript      = { "prettier" },
    typescriptreact = { "prettier" },
    vue             = { "prettier" },
    astro           = { "prettier" },
    html            = { "prettier" },
    css             = { "prettier" },
    scss            = { "prettier" },
    less            = { "prettier" },
    json            = { "prettier" },
    jsonc           = { "prettier" },
    yaml            = { "prettier" },
    markdown        = { "prettier" },
  },

  format_on_save = {
    timeout_ms   = 1000,
    lsp_fallback = true,
  },

  -- Opciones de prettier (puedes sobreescribir con .prettierrc en el proyecto)
  formatters = {
    prettier = {
      prepend_args = {
        "--single-quote",
        "--semi",
        "--tab-width", "2",
        "--print-width", "100",
        "--trailing-comma", "es5",
      },
    },
  },
})

-- Atajo manual: <leader>cf para formatear (evita conflicto con <leader>f de telescope)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })
