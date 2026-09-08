local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    cpp = { "clang_format" },
    c = { "clang_format" },
    lua = { "stylua" },
    python = { "isort", "black" },

    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    astro = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },

    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
  },

  format_on_save = function(bufnr)
    -- ESLint debe terminar antes de Prettier y de escribir el archivo.
    if #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" }) > 0 then
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd("LspEslintFixAll")
      end)
    end
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
})

-- Atajo manual: <leader>cf para formatear (evita conflicto con <leader>f de telescope)
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Formatear archivo" })
