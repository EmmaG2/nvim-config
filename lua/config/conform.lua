local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    cpp = { "clang-format" },
    c = { "clang-format" },
    lua = { "stylua" },
    python = { "black" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Atajo manual: <leader>f para formatear
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

