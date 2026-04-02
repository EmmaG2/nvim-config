vim.cmd.colorscheme "catppuccin"

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
