local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),

    -- Enter confirma como VSCode: acepta la selección actual o el primer ítem
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),

    -- Tab navega el menú o salta snippets (igual que VSCode)
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp",               priority = 1000 },
    { name = "nvim_lsp_signature_help", priority = 900 },
    { name = "luasnip",                priority = 800 },
    { name = "nvim_lua",               priority = 700 },
    { name = "buffer",                 priority = 500, keyword_length = 3 },
    { name = "path",                   priority = 400 },
  }),

  -- Formato VSCode: ícono + tipo + nombre + fuente
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 50,
      ellipsis_char = "…",
      show_labelDetails = true,
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp               = " [LSP]",
          nvim_lsp_signature_help = " [Sig]",
          luasnip                = " [Snip]",
          buffer                 = " [Buf]",
          nvim_lua               = " [Lua]",
          path                   = " [Path]",
        })[entry.source.name] or entry.source.name
        return vim_item
      end,
    }),
  },

  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
      scrollbar = false,
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
      scrollbar = false,
    }),
  },

  experimental = {
    ghost_text = {
      hl_group = "CmpGhostText",
    },
  },
})

-- Colores sutiles para ghost text (como VSCode)
vim.api.nvim_set_hl(0, "CmpGhostText",  { link = "Comment", default = true })
vim.api.nvim_set_hl(0, "CmpNormal",     { link = "NormalFloat", default = true })
vim.api.nvim_set_hl(0, "CmpBorder",     { link = "FloatBorder", default = true })
vim.api.nvim_set_hl(0, "CmpDocNormal",  { link = "NormalFloat", default = true })
vim.api.nvim_set_hl(0, "CmpDocBorder",  { link = "FloatBorder", default = true })
vim.api.nvim_set_hl(0, "CmpSel",        { link = "PmenuSel", default = true })

-- Completado en la línea de comandos
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
  ),
})
