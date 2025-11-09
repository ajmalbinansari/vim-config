-- Testing Plugins
-- Neotest framework with language-specific adapters

return {
  -- ============================================================================
  -- Neotest - Testing Framework
  -- ============================================================================

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Language-specific adapters
      "nvim-neotest/neotest-jest",
      "olimorris/neotest-phpunit",
    },
    keys = {
      { "<leader>tt", desc = "Run nearest test" },
      { "<leader>tf", desc = "Run file tests" },
      { "<leader>ts", desc = "Toggle test summary" },
      { "<leader>to", desc = "Toggle test output" },
      { "<leader>tS", desc = "Stop tests" },
      { "<leader>tw", desc = "Toggle watch mode" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- Jest adapter for JavaScript/TypeScript/React Native
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "jest.config.js",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end,
          }),

          -- PHPUnit adapter for PHP/Symfony
          require("neotest-phpunit")({
            phpunit_cmd = function()
              return "vendor/bin/phpunit"
            end,
            root_files = { "composer.json", "phpunit.xml" },
            filter_dirs = { "vendor" },
          }),
        },

        -- Diagnostic integration
        diagnostic = {
          enabled = true,
          severity = 1,
        },

        -- Floating window config
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
        },

        -- Icons
        icons = {
          passed = "",
          running = "",
          failed = "",
          skipped = "",
          unknown = "",
          watching = "",
        },

        -- Status signs
        status = {
          enabled = true,
          virtual_text = false,
          signs = true,
        },

        -- Summary window
        summary = {
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            output = "o",
            short = "O",
            attach = "a",
            jumpto = "i",
            stop = "u",
            run = "r",
            debug = "d",
            mark = "m",
            run_marked = "R",
            debug_marked = "D",
            clear_marked = "M",
            target = "t",
            clear_target = "T",
            next_failed = "J",
            prev_failed = "K",
            watch = "w",
          },
        },
      })

      -- Keymaps
      local neotest = require("neotest")

      vim.keymap.set("n", "<leader>tt", function()
        neotest.run.run()
      end, { desc = "Run nearest test" })

      vim.keymap.set("n", "<leader>tf", function()
        neotest.run.run(vim.fn.expand("%"))
      end, { desc = "Run file tests" })

      vim.keymap.set("n", "<leader>ts", function()
        neotest.summary.toggle()
      end, { desc = "Toggle test summary" })

      vim.keymap.set("n", "<leader>to", function()
        neotest.output.open({ enter = true })
      end, { desc = "Toggle test output" })

      vim.keymap.set("n", "<leader>tS", function()
        neotest.run.stop()
      end, { desc = "Stop tests" })

      vim.keymap.set("n", "<leader>tw", function()
        neotest.watch.toggle()
      end, { desc = "Toggle watch mode" })

      vim.keymap.set("n", "<leader>td", function()
        neotest.run.run({ strategy = "dap" })
      end, { desc = "Debug nearest test" })
    end,
  },
}
