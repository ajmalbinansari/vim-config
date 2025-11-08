-- Telescope Fuzzy Finder
-- Main plugin, extensions, and configuration

return {
  -- ============================================================================
  -- Telescope Core
  -- ============================================================================

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>t", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>g", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>o", "<cmd>Telescope current_buffer<CR>", desc = "Current buffer" },
      { ";", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      -- Ensure telescope history directory exists
      vim.fn.mkdir(vim.fn.expand('~/.local/share/nvim/databases'), 'p')

      telescope.setup{
        defaults = {
          history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 100,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            },
          },
          sorting_strategy = "ascending",
          file_sorter = require'telescope.sorters'.get_fuzzy_file,
          generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
          winblend = 0,
          layout_strategy = 'horizontal',
          layout_config = {
            preview_width = 0.65,
            width = 0.75,
            height = 0.75,
            prompt_position = 'bottom',
            preview_cutoff = 120,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
          frecency = {
            show_scores = false,
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            workspaces = {
              ["conf"] = vim.fn.expand("~/.config"),
              ["data"] = vim.fn.expand("~/.local/share"),
            }
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              }
            }
          },
          find_files = {},
        },
      }

      -- Load ui-select extension
      telescope.load_extension("ui-select")
    end,
  },

  -- ============================================================================
  -- Telescope Extensions
  -- ============================================================================

  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },

  -- ============================================================================
  -- Dependencies
  -- ============================================================================

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
}
