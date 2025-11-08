-- AI Coding Assistants
-- GitHub Copilot and Claude Code

return {
  -- ============================================================================
  -- GitHub Copilot
  -- ============================================================================

  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      -- Use latest Node v22.x from nvm
      local node_path = vim.fn.glob("~/.nvm/versions/node/v22*/bin/node")
      if node_path ~= "" then
        vim.g.copilot_node_command = vim.fn.expand(node_path)
      end
    end,
  },

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
