require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "ts_ls", "lua_ls" },
}
