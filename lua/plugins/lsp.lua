-- LSP Related Plugins
-- Mason, lspconfig, and dependencies

return {
  -- ============================================================================
  -- Mason - LSP Package Manager
  -- ============================================================================

  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 900,
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- ============================================================================
  -- Mason LSP Config Bridge
  -- ============================================================================

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 850,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "phpactor" },
        automatic_installation = true,
      })
    end,
  },

  -- ============================================================================
  -- LSP Configuration
  -- ============================================================================

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 800,
    config = function()
      -- Load LSP configuration
      require('config.lsp')
    end,
  },
}
