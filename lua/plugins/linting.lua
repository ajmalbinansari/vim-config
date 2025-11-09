-- Linting Plugin
-- nvim-lint for asynchronous linting

return {
  -- ============================================================================
  -- nvim-lint - Asynchronous Linting
  -- ============================================================================

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")

      -- Configure linters by filetype
      lint.linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
        php = { "phpcs" },
      }

      -- Create autocommand for linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Lint on text changed with debounce
      vim.api.nvim_create_autocmd({ "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Debounce linting
          vim.defer_fn(function()
            lint.try_lint()
          end, 500)
        end,
      })
    end,
  },
}
