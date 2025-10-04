# 💤 Mi Configuración Personal de Neovim

> 🚀 Configuración modular, limpia y optimizada para desarrollo moderno con **Neovim 0.10+**  
> Incluye soporte para **C++**, **Lua**, **TypeScript**, snippets inteligentes, y una interfaz hermosa basada en mi 2B de NieR Automata 💎  

---

## ✨ Características principales

- 🧩 **Arquitectura modular** (`lua/`) — todo dividido por propósito: LSP, plugins, UI, etc.  
- ⚙️ **Gestión de plugins con [`lazy.nvim`](https://github.com/folke/lazy.nvim)**  
- 🎨 **Tema Catppuccin (Mocha)** totalmente integrado con Lualine, Telescope y Alpha  
- 🔮 **Inicio personalizado** con [Alpha.nvim](https://github.com/goolord/alpha-nvim) y arte ASCII de *NieR Automata — 2B*  
- 🧠 **LSP configurado** (C++, Lua, TypeScript) vía `mason.nvim` + `lspconfig`  
- 💬 **Autocompletado inteligente** con `nvim-cmp` + `LuaSnip` + `friendly-snippets`  
- 🪶 **Snippets personalizados para C++** tipo VSCode (for loops, ifs, clases, etc.)  
- 🌳 **Treesitter** para resaltado avanzado, plegado y movimientos contextuales  
- 🔍 **Telescope** para búsqueda rápida, archivos recientes, etc.  
- 🧱 **Lualine** con integración visual y separadores estilizados  
- 💡 **Atajos personalizados** (líder = espacio) para máxima productividad  

---

## 🧩 Estructura del proyecto

```bash
~/.config/nvim
├── init.lua
├── lua/
│   ├── basic.lua              # Opciones básicas de Neovim
│   ├── keymaps.lua            # Atajos personalizados
│   ├── autocmds.lua           # Autocomandos
│   ├── cmp_settings.lua       # Configuración de nvim-cmp + LuaSnip
│   ├── theme.lua              # Catppuccin + Treesitter
│   ├── plugins.lua            # Definición de plugins (Lazy)
│   ├── lsp/
│   │   ├── init.lua           # Configuración global LSP
│   │   └── servers.lua        # Configuración por servidor
│   └── config/
│       ├── alpha.lua          # Dashboard personalizado
│       └── lualine.lua        # Barra de estado
├── templates/
│   └── init.lua               # (Opcional) plantillas
└── README.md
```

## 🚀 Instalación

```bash
git clone https://github.com/EmmaG2/nvim-config ~/.config/nvim
nvim
```
