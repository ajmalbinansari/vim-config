-- AI Coding Assistants
-- Claude Code Integration with MCP Protocol

return {
  -- ============================================================================
  -- Claude Code Integration - MCP Protocol
  -- ============================================================================
  -- Provides preview-before-accept workflow:
  --   - Gutter indicators for proposed changes (not yet written to files)
  --   - Native Neovim diff view for reviewing suggestions
  --   - Edit suggestions before accepting
  --   - :w to accept, :q to reject
  --   - Seamless integration via WebSocket MCP protocol

  {
    "coder/claudecode.nvim",
    cmd = "ClaudeCode",
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", silent = true },
      { ",cc", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
      { ",cs", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Send selection to Claude" },
      { ",ca", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept diff" },
      { ",cr", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Reject diff" },
    },
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function()
      require("claudecode").setup({
        -- ======================================================================
        -- Terminal Configuration
        -- ======================================================================
        terminal = {
          split_side = "right",        -- "left", "right", "top", "bottom"
          split_width_percentage = 0.30,
          provider = "auto",           -- "auto", "snacks", "native", "external"
        },

        -- ======================================================================
        -- Diff Configuration (Preview-Before-Accept)
        -- ======================================================================
        diff_opts = {
          auto_close_on_accept = true,  -- Close diff window after accepting
          vertical_split = true,        -- Side-by-side diff
          keep_terminal_focus = false,  -- Focus diff after opening
        },

        -- ======================================================================
        -- Server Configuration (MCP Protocol WebSocket)
        -- ======================================================================
        server = {
          auto_start = true,           -- Start WebSocket server automatically
          -- port: auto-assigned, lock file at ~/.claude/ide/[port].lock
        },
      })
    end,
  },

  -- ============================================================================
  -- Snacks.nvim - Required dependency for terminal management
  -- ============================================================================

  {
    "folke/snacks.nvim",
    lazy = true,
    opts = {
      terminal = {
        win = {
          position = "right",
          width = 0.3,
        },
      },
    },
  },
}
