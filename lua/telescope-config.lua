local telescope = require('telescope')
local actions = require('telescope.actions')

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
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    frecency = {
      show_scores = false,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      workspaces = {
        ["conf"] = "/home/johndoe/.config",
        ["data"] = "/home/johndoe/.local/share",
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    find_files = {
      -- ... other options for the find_files picker
    },
    -- ... other pickers
  },
}


-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
