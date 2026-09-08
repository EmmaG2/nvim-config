-- === MOVIMIENTO DE LÍNEA ===
vim.keymap.set('n', '<C-h>', '^', { silent = true, desc = "Inicio de línea" })
vim.keymap.set('n', '<C-l>', '$', { silent = true, desc = "Fin de línea" })

-- === MOVIMIENTO DE BLOQUES/PÁRRAFOS ===
vim.keymap.set('n', '<C-j>', '}', { silent = true, desc = "Siguiente párrafo" })
vim.keymap.set('n', '<C-k>', '{', { silent = true, desc = "Párrafo anterior" })

-- === INDENTACIÓN EN VISUAL MODE ===
vim.keymap.set('v', '<Tab>', '>gv', { silent = true, desc = "Aumentar indentación" })
vim.keymap.set('v', '<S-Tab>', '<gv', { silent = true, desc = "Reducir indentación" })

-- === BUFFERS ===
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { silent = true, desc = "Siguiente buffer" })
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<CR>', { silent = true, desc = "Buffer anterior" })

-- === GUARDAR / CERRAR ===
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { silent = true, desc = "Guardar archivo" })
vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { silent = true, desc = "Cerrar ventana" })

-- === VENTANAS (splits) ===
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<CR>', { silent = true, desc = "Dividir verticalmente" })
vim.keymap.set('n', '<leader>s', '<cmd>split<CR>', { silent = true, desc = "Dividir horizontalmente" })
vim.keymap.set('n', '<M-h>', '<C-w>h', { silent = true, desc = "Ventana izquierda" })
vim.keymap.set('n', '<M-l>', '<C-w>l', { silent = true, desc = "Ventana derecha" })
vim.keymap.set('n', '<M-j>', '<C-w>j', { silent = true, desc = "Ventana inferior" })
vim.keymap.set('n', '<M-k>', '<C-w>k', { silent = true, desc = "Ventana superior" })

-- === UTILIDAD ===
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { silent = true, desc = "Explorador de archivos" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { silent = true, desc = "Ver diagnóstico" })
vim.keymap.set("n", "<leader>n", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { noremap = true, silent = true, desc = "Siguiente error" })

vim.keymap.set("n", "<leader>p", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { noremap = true, silent = true, desc = "Error anterior" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { silent = true, desc = "Renombrar símbolo" })

-- === EXTRA ===
vim.keymap.set('i', 'jk', '<Esc>', { silent = true, desc = "Salir de inserción" })

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
