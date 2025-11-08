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
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
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
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
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
    find_files = {
      -- ... other options for the find_files picker
    },
  },
}

-- Load ui-select extension
require("telescope").load_extension("ui-select")
