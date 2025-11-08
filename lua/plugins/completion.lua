-- Completion Plugins
-- nvim-cmp and sources

return {
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
    },
    config = function()
      local cmp = require("cmp")

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
