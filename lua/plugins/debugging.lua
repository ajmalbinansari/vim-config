-- Debugging Plugins
-- nvim-dap and language-specific debug adapters

return {
  -- ============================================================================
  -- nvim-dap - Debug Adapter Protocol
  -- ============================================================================

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", desc = "Toggle breakpoint" },
      { "<leader>dc", desc = "Continue" },
      { "<leader>ds", desc = "Step over" },
      { "<leader>di", desc = "Step into" },
      { "<leader>do", desc = "Step out" },
      { "<leader>dr", desc = "Repl" },
      { "<leader>du", desc = "Toggle UI" },
      { "<leader>dt", desc = "Terminate" },
    },
    config = function()
      local dap = require("dap")

      -- Helper function to get Mason package path safely
      local function get_mason_path(package_name)
        local ok, mason_registry = pcall(require, "mason-registry")
        if not ok then
          return nil
        end

        if not mason_registry.is_installed(package_name) then
          return nil
        end

        local pkg = mason_registry.get_package(package_name)
        return pkg:get_install_path()
      end

      -- ============================================================================
      -- JavaScript/TypeScript Debug Adapter (vscode-js-debug)
      -- ============================================================================

      local js_debug_path = get_mason_path("js-debug-adapter")
      if js_debug_path then
        dap.adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              js_debug_path .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }

        -- Node.js debugging configuration
        dap.configurations.javascript = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }

        dap.configurations.typescript = dap.configurations.javascript
        dap.configurations.typescriptreact = dap.configurations.javascript
        dap.configurations.javascriptreact = dap.configurations.javascript
      end

      -- ============================================================================
      -- PHP Debug Adapter (vscode-php-debug)
      -- ============================================================================

      local php_debug_path = get_mason_path("php-debug-adapter")
      if php_debug_path then
        dap.adapters.php = {
          type = "executable",
          command = "node",
          args = {
            php_debug_path .. "/extension/out/phpDebug.js",
          },
        }

        dap.configurations.php = {
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
            pathMappings = {
              ["/var/www/html"] = "${workspaceFolder}",
            },
          },
        }
      end

      -- ============================================================================
      -- Keymaps
      -- ============================================================================

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
    end,
  },

  -- ============================================================================
  -- nvim-dap-ui - Debugging Interface
  -- ============================================================================

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })

      -- Automatically open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Toggle UI keymap
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
  },

  -- ============================================================================
  -- nvim-dap-virtual-text - Inline Variable Values
  -- ============================================================================

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        filter_references_pattern = "<module",
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })
    end,
  },

  -- ============================================================================
  -- mason-nvim-dap - Auto-install Debug Adapters
  -- ============================================================================

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    cmd = { "DapInstall", "DapUninstall" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "js-debug-adapter",
          "php-debug-adapter",
        },
        automatic_installation = true,
      })
    end,
  },
}
