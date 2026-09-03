-- === MOVIMIENTO DE LÍNEA ===
vim.keymap.set('n', '<C-h>', '^', { noremap = true, silent = true }) -- inicio de línea
vim.keymap.set('n', '<C-l>', '$', { noremap = true, silent = true }) -- fin de línea

-- === MOVIMIENTO DE BLOQUES/PÁRRAFOS ===
vim.keymap.set('n', '<C-j>', '}', { noremap = true, silent = true }) -- siguiente bloque/párrafo
vim.keymap.set('n', '<C-k>', '{', { noremap = true, silent = true }) -- bloque/párrafo anterior

-- === INDENTACIÓN EN VISUAL MODE ===
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true, expr = false })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true, expr = false })

-- === BUFFERS ===
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true }) -- siguiente buffer
vim.keymap.set('n', '<leader>bp', ':bprev<CR>', { noremap = true, silent = true }) -- buffer anterior

-- === GUARDAR / CERRAR ===
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true }) -- guardar
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true }) -- salir

-- === VENTANAS (splits) ===
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true }) -- split vertical
vim.keymap.set('n', '<leader>s', ':split<CR>', { noremap = true, silent = true })  -- split horizontal
vim.keymap.set('n', '<M-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<M-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<M-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<M-k>', '<C-w>k', { noremap = true, silent = true })

-- === UTILIDAD ===
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })
-- Siguiente error
vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { noremap = true, silent = true, desc = "Siguiente error" })

-- Error anterior
vim.keymap.set("n", "<leader>p", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { noremap = true, silent = true, desc = "Error anterior" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { noremap = true, silent = true }) -- renombrar símbolo

-- === EXTRA ===
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true }) -- escape rápido

-- === FUZZY FINDER ===
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivo" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Buscar en texto" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buscar buffer" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Archivos recientes" })

-- === ASM ===
local dosbox = "/Applications/DOSBox-X.app/Contents/MacOS/dosbox-x"
local tasm_dir = vim.fn.expand("~/assembly/tasm")

local function tasm(run)
  local source = vim.api.nvim_buf_get_name(0)
  local filename = vim.fs.basename(source)
  local basename = vim.fn.fnamemodify(filename, ":r")

  if vim.bo.filetype ~= "asm" or source == "" then
    vim.notify("Abre un archivo .asm antes de usar TASM", vim.log.levels.ERROR)
    return
  end

  if #basename > 8 or not basename:match("^[%w_%-]+$") then
    vim.notify("TASM requiere un nombre DOS válido de hasta 8 caracteres", vim.log.levels.ERROR)
    return
  end

  if vim.fn.executable(dosbox) ~= 1 then
    vim.notify("No se encontró DOSBox-X en /Applications", vim.log.levels.ERROR)
    return
  end

  vim.cmd("write")

  local command = {
    dosbox,
    "-fastlaunch",
    "-c", 'mount c "' .. tasm_dir .. '"',
    "-c", 'mount d "' .. vim.fs.dirname(source) .. '"',
    "-c", "d:",
    "-c", "c:\\tasm " .. filename,
    "-c", "c:\\tlink " .. basename .. ".obj",
  }

  if run then
    vim.list_extend(command, { "-c", basename .. ".exe" })
  end

  if vim.fn.jobstart(command, { detach = true }) <= 0 then
    vim.notify("No se pudo iniciar DOSBox-X", vim.log.levels.ERROR)
    return
  end

  vim.notify((run and "Ejecutando " or "Compilando ") .. filename)
end

vim.api.nvim_create_user_command("TasmBuild", function()
  tasm(false)
end, {
  desc = "Compilar ensamblador con TASM"
})

vim.api.nvim_create_user_command("TasmRun", function()
  tasm(true)
end, {
  desc = "Compilar y ejecutar ensamblador con TASM"
})

vim.keymap.set("n", "<leader>ab", "<cmd>TasmBuild<cr>", {
  desc = "Compilar con TASM"
})

vim.keymap.set("n", "<leader>ar", "<cmd>TasmRun<cr>", {
  desc = "Compilar y ejecutar con TASM"
})
