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
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>",  { desc = "Buscar archivo" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",   { desc = "Buscar en texto" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>",     { desc = "Buscar buffer" })
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",    { desc = "Archivos recientes" })
