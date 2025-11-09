-- Treesitter Configuration
-- Syntax highlighting, indentation, and code understanding

return {
  -- ============================================================================
  -- Treesitter - Better Syntax Highlighting & Indentation
  -- ============================================================================

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for these languages
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "jsonc",
          "yaml",
          "html",
          "css",
          "php",
          "markdown",
          "markdown_inline",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- Enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable smart indentation
        indent = {
          enable = true,
        },

        -- Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<S-CR>",
            node_decremental = "<BS>",
          },
        },

        -- Enable matchup integration for bracket highlighting
        matchup = {
          enable = true,
        },
      })
    end,
  },

  -- ============================================================================
  -- vim-matchup - Better % motion and bracket highlighting
  -- ============================================================================

  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Enable offscreen closing match in statusline
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      -- Highlight matching brackets
      vim.g.matchup_matchparen_deferred = 1
    end,
  },
}
