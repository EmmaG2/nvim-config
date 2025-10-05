local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = false

local lspconfig = require("lspconfig")
lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy"
    },
}

-- TypeScript / React
lspconfig.ts_ls.setup {}

-- lua
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT", -- Neovim usa LuaJIT
            },
            diagnostics = {
                globals = { "vim" }, -- para que no marque "vim" como variable indefinida
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- evita warnings molestos
            },
            telemetry = { enable = false },
        },
    },
}
