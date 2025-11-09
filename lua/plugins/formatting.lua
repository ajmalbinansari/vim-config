-- Code Formatting
-- Conform.nvim with Prettierd (faster) and StyLua

return {
  -- ============================================================================
  -- Conform.nvim - Universal Formatter
  -- ============================================================================

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          -- Use prettierd (daemon version, 10-20x faster) with fallback
          -- stop_after_first tries prettierd first, falls back to prettier
          javascript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          jsonc = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          -- Lua formatting
          lua = { "stylua" },
          -- PHP formatting
          php = { "php_cs_fixer" },
        },
        -- Format on save with optimized timeout
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
        -- Formatters configuration
        formatters = {
          php_cs_fixer = {
            command = "php-cs-fixer",
            args = {
              "fix",
              "$FILENAME",
              "--rules=@PSR12",
            },
            stdin = false,
          },
        },
      })
    end,
  },
}
