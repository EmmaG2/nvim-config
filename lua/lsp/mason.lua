-- Mason setup
require("mason").setup()

-- Mason LSP config
require("mason-lspconfig").setup {
    ensure_installed = { "clangd", "ts_ls", "lua_ls" }, -- 👈 nota que cambiamos tsserver -> ts_ls
}
