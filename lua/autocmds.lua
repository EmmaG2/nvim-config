vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  command = "0r ~/.config/nvim/templates/cp_template.cpp"
})
