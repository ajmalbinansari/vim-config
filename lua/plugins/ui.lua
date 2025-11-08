-- UI and Visual Plugins
-- Colorschemes, statuslines, and icons

return {
  -- ============================================================================
  -- Colorscheme (Primary)
  -- ============================================================================

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = false,
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          telescope = {
            enabled = true,
          },
          gitsigns = true,
          nvimtree = true,
        },
      })
    end,
  },

  -- ============================================================================
  -- Colorscheme (Backup)
  -- ============================================================================

  {
    "ajmwagar/vim-deus",
    lazy = true,
  },

  -- ============================================================================
  -- Colorscheme (Alternative)
  -- ============================================================================

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },

  -- ============================================================================
  -- Status Line
  -- ============================================================================

  {
    "vim-airline/vim-airline",
    lazy = false,
  },

  -- ============================================================================
  -- Icons
  -- ============================================================================

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
