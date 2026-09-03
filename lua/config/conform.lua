local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    cpp                = { "clang_format" },
    c                  = { "clang_format" },
    lua                = { "stylua" },
    python             = { "isort", "black" },

    javascript         = { "prettier" },
    javascriptreact    = { "prettier" },
    typescript         = { "prettier" },
    typescriptreact    = { "prettier" },
    vue                = { "prettier" },
    astro              = { "prettier" },
    html               = { "prettier" },
    css                = { "prettier" },
    scss               = { "prettier" },
    less               = { "prettier" },
    json               = { "prettier" },
    jsonc              = { "prettier" },
    yaml               = { "prettier" },
    markdown           = { "prettier" },

    terraform          = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})

-- Atajo manual: <leader>cf para formatear (evita conflicto con <leader>f de telescope)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format file" })
