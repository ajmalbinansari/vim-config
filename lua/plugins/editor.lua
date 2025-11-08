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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
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

        -- Text objects - select code by structure
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Jump forward to next match
            keymaps = {
              -- Functions
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- Classes
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              -- Conditionals
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              -- Loops
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              -- Parameters/arguments
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- Add to jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },

        -- Incremental selection - expand selection smartly
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",    -- Start selection
            node_incremental = "grn",  -- Expand to next node
            scope_incremental = "grc", -- Expand to scope
            node_decremental = "grm",  -- Shrink selection
          },
        },
      }
    end,
  },

  -- Tree-sitter text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
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
