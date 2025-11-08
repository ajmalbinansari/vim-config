-- Completion Plugins
-- nvim-cmp and sources

return {
  -- ============================================================================
  -- LSP Kind Icons
  -- ============================================================================

  {
    "onsails/lspkind.nvim",
    lazy = true,
  },

  -- ============================================================================
  -- Completion Engine
  -- ============================================================================

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-o>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    " .. (strings[2] or "")

            return kind
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },

  -- ============================================================================
  -- Completion Sources
  -- ============================================================================

  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },

  {
    "hrsh7th/cmp-buffer",
    lazy = true,
  },

  -- ============================================================================
  -- Snippet Engine
  -- ============================================================================

  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v1.*",
    build = "make install_jsregexp",
  },
}
