-- Which-Key Plugin
-- Keybinding discoverability and documentation

return {
  -- ============================================================================
  -- which-key - Keybinding Helper
  -- ============================================================================

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")

      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
        },
      })

      -- Register key groups with descriptions
      wk.add({
        -- Find operations (Telescope)
        { "<leader>f", group = "Find" },
        { "<leader>ff", desc = "Find files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>fr", desc = "Recent files" },
        { "<leader>fc", desc = "Commands" },
        { "<leader>fk", desc = "Keymaps" },
        { "<leader>fs", desc = "Git status" },

        -- Git operations
        { "<leader>v", group = "Git" },
        { "<leader>vg", desc = "LazyGit" },
        { "<leader>vs", desc = "Git status" },
        { "<leader>vf", desc = "LazyGit (current file)" },
        { "<leader>vd", desc = "Diff view" },
        { "<leader>vc", desc = "Close diff view" },
        { "<leader>vh", desc = "File history (current)" },
        { "<leader>vH", desc = "File history (all)" },
        { "<leader>vr", desc = "Refresh diff view" },
        { "<leader>vt", desc = "Toggle diff files panel" },
        { "<leader>vb", desc = "Toggle inline blame" },
        { "<leader>gy", desc = "Copy git permalink" },

        -- Hunk operations (Gitsigns)
        { "<leader>h", group = "Git Hunks" },
        { "<leader>hs", desc = "Stage hunk" },
        { "<leader>hr", desc = "Reset hunk" },
        { "<leader>hS", desc = "Stage buffer" },
        { "<leader>hR", desc = "Reset buffer" },
        { "<leader>hu", desc = "Undo stage hunk" },
        { "<leader>hp", desc = "Preview hunk" },
        { "<leader>hb", desc = "Blame line" },
        { "<leader>ha", desc = "Harpoon: Add file" },
        { "<leader>hm", desc = "Harpoon menu" },

        -- LSP operations
        { "<leader>l", group = "LSP" },
        { "<leader>rn", desc = "Rename" },
        { "<leader>ac", desc = "Code actions" },
        { "<leader>dd", desc = "Diagnostics list" },

        -- File operations
        { "<leader>e", desc = "Toggle file explorer" },

        -- Commenting
        { "<leader>c", group = "Comment" },

        -- Debugging
        { "<leader>d", group = "Debug" },
        { "<leader>db", desc = "Toggle breakpoint" },
        { "<leader>dc", desc = "Continue" },
        { "<leader>ds", desc = "Step over" },
        { "<leader>di", desc = "Step into" },
        { "<leader>do", desc = "Step out" },
        { "<leader>dr", desc = "Open REPL" },
        { "<leader>du", desc = "Toggle UI" },
        { "<leader>dt", desc = "Terminate" },

        -- Testing
        { "<leader>t", group = "Test" },
        { "<leader>tt", desc = "Run nearest test" },
        { "<leader>tf", desc = "Run file tests" },
        { "<leader>ts", desc = "Toggle test summary" },
        { "<leader>to", desc = "Toggle test output" },
        { "<leader>tS", desc = "Stop tests" },
        { "<leader>tw", desc = "Toggle watch mode" },
        { "<leader>td", desc = "Debug nearest test" },

        -- Numbers (Harpoon files)
        { "<leader>1", desc = "Harpoon file 1" },
        { "<leader>2", desc = "Harpoon file 2" },
        { "<leader>3", desc = "Harpoon file 3" },
        { "<leader>4", desc = "Harpoon file 4" },

        -- File navigation
        { "-", desc = "Open parent directory (Oil)" },

        -- Surround operations (mini.surround)
        { "sa", desc = "Add surrounding" },
        { "sd", desc = "Delete surrounding" },
        { "sr", desc = "Replace surrounding" },
        { "sf", desc = "Find surrounding (right)" },
        { "sF", desc = "Find surrounding (left)" },
        { "sh", desc = "Highlight surrounding" },

        -- Comment operations (mini.comment)
        { "gc", desc = "Toggle comment" },
        { "gcc", desc = "Toggle comment line" },

        -- Navigation
        { "gd", desc = "Go to definition" },
        { "gD", desc = "Go to declaration" },
        { "gi", desc = "Go to implementation" },
        { "gr", desc = "Show references" },
        { "1gD", desc = "Type definition" },
        { "K", desc = "Hover documentation" },
        { "[d", desc = "Previous diagnostic" },
        { "]d", desc = "Next diagnostic" },
        { "[c", desc = "Previous git hunk" },
        { "]c", desc = "Next git hunk" },

        -- Treesitter navigation
        { "]f", desc = "Next function start" },
        { "[f", desc = "Previous function start" },
        { "]F", desc = "Next function end" },
        { "[F", desc = "Previous function end" },
        { "]c", desc = "Next class start" },
        { "[c", desc = "Previous class start" },
        { "]C", desc = "Next class end" },
        { "[C", desc = "Previous class end" },
      })
    end,
  },
}
