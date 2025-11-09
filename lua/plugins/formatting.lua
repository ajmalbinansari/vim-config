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
          -- Use prettierd (daemon version, 10-20x faster)
          javascript = { "prettierd", "prettier" },
          javascriptreact = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          typescriptreact = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          jsonc = { "prettierd", "prettier" },
          yaml = { "prettierd", "prettier" },
          markdown = { "prettierd", "prettier" },
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
