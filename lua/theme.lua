vim.cmd.colorscheme "catppuccin"

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp", "c", "lua", "python", "java", "lua" }, -- Los lenguajes que trabajo
    highlight = {
        enable = true,                                                 -- activa el resaltado
    },
}

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = true,
    }
})
