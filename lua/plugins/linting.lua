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
          -- Only lint if in a project with proper linter setup
          -- This prevents errors in test files or files without node_modules
          local has_eslint = vim.fn.executable("eslint") == 1
            or vim.fn.filereadable(vim.fn.getcwd() .. "/node_modules/.bin/eslint") == 1
          local has_phpcs = vim.fn.executable("phpcs") == 1

          if has_eslint or has_phpcs then
            lint.try_lint()
          end
        end,
      })

      -- Lint on text changed with debounce
      vim.api.nvim_create_autocmd({ "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Debounce linting
          vim.defer_fn(function()
            local has_eslint = vim.fn.executable("eslint") == 1
              or vim.fn.filereadable(vim.fn.getcwd() .. "/node_modules/.bin/eslint") == 1
            local has_phpcs = vim.fn.executable("phpcs") == 1

            if has_eslint or has_phpcs then
              lint.try_lint()
            end
          end, 500)
        end,
      })
    end,
  },
}
