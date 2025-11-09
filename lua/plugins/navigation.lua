-- Navigation Enhancement Plugins
-- Harpoon for quick file marking, Flash for motion

return {
  -- ============================================================================
  -- Harpoon - Quick File Navigation
  -- ============================================================================

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", desc = "Harpoon: Add file" },
      { "<C-h>", desc = "Harpoon: Navigate to file 1" },
      { "<C-j>", desc = "Harpoon: Navigate to file 2" },
      { "<C-k>", desc = "Harpoon: Navigate to file 3" },
      { "<C-l>", desc = "Harpoon: Navigate to file 4" },
      { "<leader>hm", desc = "Harpoon: Toggle menu" },
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      -- Keymaps
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })

      -- Navigate to files
      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

      -- Navigate with leader numbers
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })
    end,
  },

  -- ============================================================================
  -- Flash - Enhanced Motion Plugin
  -- ============================================================================

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        multi_window = true,
        forward = true,
        wrap = true,
      },
      jump = {
        jumplist = true,
        pos = "start",
        history = false,
        register = false,
      },
      label = {
        uppercase = false,
        rainbow = {
          enabled = false,
        },
      },
      modes = {
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
