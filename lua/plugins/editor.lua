-- Editor Enhancement Plugins
-- Treesitter, colorizer, commenting

return {
  -- ============================================================================
  -- Treesitter - Syntax Highlighting
  -- ============================================================================

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Install parsers for these languages
        ensure_installed = {
          "lua",
          "typescript",
          "javascript",
          "php",
          "html",
          "css",
          "json",
          "vim"
        },

        -- Install parsers synchronously
        sync_install = false,

        -- Automatically install missing parsers
        auto_install = true,

        -- Enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation
        indent = {
          enable = true,
        },
      }
    end,
  },

  -- ============================================================================
  -- Color Preview
  -- ============================================================================

  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- ============================================================================
  -- Commenting
  -- ============================================================================

  {
    "preservim/nerdcommenter",
    keys = {
      { "<leader>c<space>", mode = { "n", "v" }, desc = "Toggle comment" },
    },
  },
}
