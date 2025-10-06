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
vim.keymap.set('n', '<C-q>', '<C-w>h', { noremap = true, silent = true })          -- mover ventana izq
vim.keymap.set('n', '<C-w>', '<C-w>l', { noremap = true, silent = true })          -- mover ventana der
vim.keymap.set('n', '<C-e>', '<C-w>j', { noremap = true, silent = true })          -- mover ventana abajo
vim.keymap.set('n', '<C-r>', '<C-w>k', { noremap = true, silent = true })          -- mover ventana arriba

-- === UTILIDAD ===
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })       -- explorador
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { noremap = true, silent = true }) -- buscar archivo
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>', { noremap = true, silent = true })  -- buscar en texto
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { noremap = true, silent = true })   -- ver errores
-- Siguiente error
vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Siguiente error" })

-- Error anterior
vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Error anterior" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { noremap = true, silent = true }) -- renombrar símbolo

-- === EXTRA ===
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true }) -- escape rápido

-- === FUZZY FINDER ===
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
