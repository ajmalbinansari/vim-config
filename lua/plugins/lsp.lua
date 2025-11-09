-- LSP Related Plugins
-- Mason, lspconfig, and dependencies

return {
  -- ============================================================================
  -- Mason - LSP Package Manager
  -- ============================================================================

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
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
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "eslint",
          "phpactor",
          "intelephense",
          "jsonls",
          "yamlls"
        },
        automatic_installation = true,
      })
    end,
  },

  -- ============================================================================
  -- Mason Tool Installer
  -- ============================================================================

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettierd",
          "prettier",
          "eslint_d",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },

  -- ============================================================================
  -- SchemaStore - JSON/YAML Schema Support
  -- ============================================================================

  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- ============================================================================
  -- LSP Configuration
  -- ============================================================================

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "b0o/schemastore.nvim" },
    config = function()
      -- Load LSP configuration
      require('config.lsp')
    end,
  },
}
