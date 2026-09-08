local root = vim.fn.getcwd()
for _, path in ipairs(vim.fn.glob(root .. "/lua/**/*.lua", false, true)) do
  assert(loadfile(path))
end
assert(loadfile(root .. "/init.lua"))

local plugins = vim.fn.stdpath("data") .. "/lazy/"
for _, name in ipairs({ "nvim-lspconfig", "cmp-nvim-lsp", "conform.nvim" }) do
  vim.opt.rtp:append(plugins .. name)
end

local enable = vim.lsp.enable
vim.lsp.enable = function() end
dofile(root .. "/lua/lsp/servers.lua")
vim.lsp.enable = enable
assert(vim.lsp.config.clangd.root_dir == nil)
assert(vim.tbl_contains(vim.lsp.config.clangd.root_markers, "compile_commands.json"))

dofile(root .. "/lua/autocmds.lua")
vim.cmd.enew()
vim.bo.filetype = "cpp"
vim.api.nvim_exec_autocmds("BufNewFile", { pattern = "main.cpp" })
assert(vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "")
vim.cmd.CPTemplate()
local template = vim.fn.readfile(vim.fn.stdpath("config") .. "/templates/cp_template.cpp")
assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), template))
local notify = vim.notify
vim.notify = function() end
vim.cmd.CPTemplate()
assert(vim.deep_equal(vim.api.nvim_buf_get_lines(0, 0, -1, false), template))
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "" })
vim.bo.filetype = "lua"
vim.cmd.CPTemplate()
assert(vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "")
vim.notify = notify

local conform = require("conform")
dofile(root .. "/lua/config/conform.lua")
local path = vim.fn.tempname() .. ".js"
vim.api.nvim_buf_set_name(0, path)
local bufnr = vim.api.nvim_get_current_buf()
local events = {}
local client = {
  request_sync = function(_, method, params, _, target)
    assert(method == "workspace/executeCommand")
    assert(params.command == "eslint.applyAllFixes")
    assert(params.arguments[1].uri == vim.uri_from_bufnr(bufnr))
    assert(target == bufnr)
    events[#events + 1] = "eslint"
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "fixed" })
    return { result = vim.NIL }
  end,
}
vim.lsp.config.eslint.on_attach(client, bufnr)
local get_clients = vim.lsp.get_clients
vim.lsp.get_clients = function(filter)
  assert(filter.bufnr == bufnr and filter.name == "eslint")
  return { client }
end
local format = conform.format
conform.format = function(opts)
  assert(opts.buf == bufnr and opts.async == false)
  assert(vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == "fixed")
  events[#events + 1] = "format"
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "formatted" })
end
vim.cmd.write()
assert(vim.deep_equal(events, { "eslint", "format" }))
assert(vim.fn.readfile(path)[1] == "formatted")
assert(not vim.bo.modified)

-- La orden local puede sobrevivir a un detach; no debe invocar al cliente viejo.
vim.lsp.get_clients = function()
  return {}
end
conform.format = function(opts)
  assert(opts.async == false)
  events[#events + 1] = "format"
end
vim.cmd.write()
assert(vim.deep_equal(events, { "eslint", "format", "format" }))
vim.lsp.get_clients = get_clients
conform.format = format
assert(vim.fn.delete(path) == 0)
print("OK: sintaxis, raíz clangd, plantilla y guardado ESLint → formato → disco")
