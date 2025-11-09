-- AI Coding Assistants
-- Claude Code Integration

return {
  -- ============================================================================
  -- Claude Code Integration
  -- ============================================================================

  {
    "greggh/claude-code.nvim",
    cmd = "ClaudeCode",
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", silent = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup({
        split_ratio = 0.3,
        position = "botright",
        enter_insert = true,
        file_refresh = {
          enable = true,
          show_notifications = false,
        },
        hide_numbers = false,
        hide_signcolumn = false,
      })
    end,
  },
}
