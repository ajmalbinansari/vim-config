-- ============================================================================
-- Git Integration Plugins - Complete Workflow Suite
-- ============================================================================
--
-- This file configures a comprehensive Git workflow with:
--   - LazyGit: Terminal UI for Git operations
--   - Gitsigns: Visual diff indicators, hunk operations, inline blame
--   - Diffview: Advanced diff viewing and merge conflict resolution
--
-- Keymap Organization (all under <leader>v prefix):
--   ,vg  - Open LazyGit (primary Git UI)
--   ,vs  - Git status (LazyGit)
--   ,vb  - Git blame (toggle inline blame)
--   ,vd  - Open diff view
--   ,vh  - File history view
--   ,vc  - Close diff view
--   ,vr  - Refresh diff view
--
-- Hunk Operations (under <leader>h prefix):
--   ,hs  - Stage hunk
--   ,hr  - Reset hunk
--   ,hS  - Stage buffer
--   ,hR  - Reset buffer
--   ,hu  - Undo stage hunk
--   ,hp  - Preview hunk
--   ,hb  - Blame line
--   ]c   - Next hunk
--   [c   - Previous hunk
--
-- ============================================================================

return {
  -- ============================================================================
  -- LazyGit - Terminal UI for Git
  -- ============================================================================
  -- Beautiful terminal interface for Git operations
  -- Handles commits, branches, merges, rebases, and more

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { ",vg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      { ",vs", "<cmd>LazyGit<CR>", desc = "Git status (LazyGit)" },
      { ",vf", "<cmd>LazyGitCurrentFile<CR>", desc = "LazyGit current file" },
    },
  },

  -- ============================================================================
  -- Gitsigns - Visual Git Indicators & Hunk Operations
  -- ============================================================================
  -- Provides:
  --   - Sign column indicators for added/changed/deleted lines
  --   - Inline blame virtual text
  --   - Hunk preview and navigation
  --   - Stage/unstage hunks directly in buffer

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- ========================================================================
      -- Visual Sign Column Configuration
      -- ========================================================================
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },

      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

      -- ========================================================================
      -- Inline Blame Configuration
      -- ========================================================================
      current_line_blame = true, -- Show blame info at end of line
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

      -- ========================================================================
      -- Performance & Behavior
      -- ========================================================================
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable for files longer than this
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },

      -- ========================================================================
      -- Keymaps Configuration
      -- ========================================================================
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation - Next/Previous hunk
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Next hunk"})

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, desc = "Previous hunk"})

        -- Hunk Operations
        map('n', ',hs', gs.stage_hunk, { desc = "Stage hunk" })
        map('n', ',hr', gs.reset_hunk, { desc = "Reset hunk" })
        map('v', ',hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
        map('v', ',hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
        map('n', ',hS', gs.stage_buffer, { desc = "Stage buffer" })
        map('n', ',hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map('n', ',hR', gs.reset_buffer, { desc = "Reset buffer" })
        map('n', ',hp', gs.preview_hunk, { desc = "Preview hunk" })

        -- Blame Operations
        map('n', ',hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
        map('n', ',vb', gs.toggle_current_line_blame, { desc = "Toggle inline blame" })

        -- Diff Operations
        map('n', ',hd', gs.diffthis, { desc = "Diff this" })
        map('n', ',hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })

        -- Text object for hunks
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
      end
    },
  },

  -- ============================================================================
  -- Diffview - Advanced Diff Viewing & Merge Conflict Resolution
  -- ============================================================================
  -- Provides:
  --   - Side-by-side diff viewing
  --   - File history browser
  --   - 3-way merge conflict resolution
  --   - Comprehensive diff layouts

  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { ",vd", "<cmd>DiffviewOpen<CR>", desc = "Open diff view" },
      { ",vc", "<cmd>DiffviewClose<CR>", desc = "Close diff view" },
      { ",vh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
      { ",vH", "<cmd>DiffviewFileHistory<CR>", desc = "File history (all)" },
      { ",vr", "<cmd>DiffviewRefresh<CR>", desc = "Refresh diff view" },
      { ",vt", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle diff files panel" },
    },
    config = function()
      local actions = require("diffview.actions")

      require("diffview").setup({
        -- ======================================================================
        -- Diff View Configuration
        -- ======================================================================
        diff_binaries = false,    -- Show diffs for binaries
        enhanced_diff_hl = true,  -- Use enhanced diff highlighting
        git_cmd = { "git" },      -- Git command
        use_icons = true,         -- Use icons (requires Nerd Font)
        show_help_hints = true,   -- Show help hints
        watch_index = true,       -- Update views on index changes

        -- ======================================================================
        -- Icon Configuration (Nerd Font required)
        -- ======================================================================
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },

        -- ======================================================================
        -- Layout Configuration
        -- ======================================================================
        view = {
          -- Configure the layout and behavior of different types of views and panels
          default = {
            -- Config for changed files, and staged files in diff views
            layout = "diff2_horizontal",
            winbar_info = false,
          },
          merge_tool = {
            -- Config for conflicted files in diff views during merge/rebase
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = false,
          },
        },

        -- ======================================================================
        -- File Panel Configuration
        -- ======================================================================
        file_panel = {
          listing_style = "tree",             -- 'list' or 'tree'
          tree_options = {
            flatten_dirs = true,              -- Flatten single-child directories
            folder_statuses = "only_folded",  -- 'never', 'only_folded', 'always'
          },
          win_config = {
            position = "left",                -- 'left', 'right', 'top', 'bottom'
            width = 35,
            win_opts = {}
          },
        },

        -- ======================================================================
        -- File History Panel Configuration
        -- ======================================================================
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            height = 16,
            win_opts = {}
          },
        },

        -- ======================================================================
        -- Commit Log Panel Configuration
        -- ======================================================================
        commit_log_panel = {
          win_config = {
            win_opts = {},
          }
        },

        -- ======================================================================
        -- Keymaps Configuration
        -- ======================================================================
        keymaps = {
          disable_defaults = false,
          view = {
            -- Standard navigation
            { "n", "<tab>",      actions.select_next_entry,         { desc = "Next entry" } },
            { "n", "<s-tab>",    actions.select_prev_entry,         { desc = "Previous entry" } },
            { "n", "gf",         actions.goto_file,                 { desc = "Go to file" } },
            { "n", "<C-w><C-f>", actions.goto_file_split,           { desc = "Go to file in split" } },
            { "n", "<C-w>gf",    actions.goto_file_tab,             { desc = "Go to file in tab" } },

            -- Focus and toggle
            { "n", "<leader>e",  actions.focus_files,               { desc = "Focus files panel" } },
            { "n", "<leader>b",  actions.toggle_files,              { desc = "Toggle files panel" } },

            -- Refresh and listing
            { "n", "g<C-x>",     actions.cycle_layout,              { desc = "Cycle layout" } },
            { "n", "[x",         actions.prev_conflict,             { desc = "Previous conflict" } },
            { "n", "]x",         actions.next_conflict,             { desc = "Next conflict" } },

            -- Conflict resolution
            { "n", "<leader>co", actions.conflict_choose("ours"),   { desc = "Choose ours" } },
            { "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
            { "n", "<leader>cb", actions.conflict_choose("base"),   { desc = "Choose base" } },
            { "n", "<leader>ca", actions.conflict_choose("all"),    { desc = "Choose all" } },
            { "n", "dx",         actions.conflict_choose("none"),   { desc = "Delete conflict" } },
          },

          file_panel = {
            { "n", "j",              actions.next_entry,           { desc = "Next entry" } },
            { "n", "<down>",         actions.next_entry,           { desc = "Next entry" } },
            { "n", "k",              actions.prev_entry,           { desc = "Previous entry" } },
            { "n", "<up>",           actions.prev_entry,           { desc = "Previous entry" } },
            { "n", "<cr>",           actions.select_entry,         { desc = "Select entry" } },
            { "n", "o",              actions.select_entry,         { desc = "Select entry" } },
            { "n", "<2-LeftMouse>",  actions.select_entry,         { desc = "Select entry" } },
            { "n", "-",              actions.toggle_stage_entry,   { desc = "Stage/unstage" } },
            { "n", "S",              actions.stage_all,            { desc = "Stage all" } },
            { "n", "U",              actions.unstage_all,          { desc = "Unstage all" } },
            { "n", "X",              actions.restore_entry,        { desc = "Restore entry" } },
            { "n", "L",              actions.open_commit_log,      { desc = "Open commit log" } },
            { "n", "zo",             actions.open_fold,            { desc = "Expand fold" } },
            { "n", "h",              actions.close_fold,           { desc = "Close fold" } },
            { "n", "zc",             actions.close_fold,           { desc = "Close fold" } },
            { "n", "za",             actions.toggle_fold,          { desc = "Toggle fold" } },
            { "n", "zR",             actions.open_all_folds,       { desc = "Open all folds" } },
            { "n", "zM",             actions.close_all_folds,      { desc = "Close all folds" } },
            { "n", "<c-b>",          actions.scroll_view(-0.25),   { desc = "Scroll up" } },
            { "n", "<c-f>",          actions.scroll_view(0.25),    { desc = "Scroll down" } },
            { "n", "<tab>",          actions.select_next_entry,    { desc = "Next entry" } },
            { "n", "<s-tab>",        actions.select_prev_entry,    { desc = "Previous entry" } },
            { "n", "gf",             actions.goto_file,            { desc = "Go to file" } },
            { "n", "<C-w><C-f>",     actions.goto_file_split,      { desc = "Go to file in split" } },
            { "n", "<C-w>gf",        actions.goto_file_tab,        { desc = "Go to file in tab" } },
            { "n", "i",              actions.listing_style,        { desc = "Toggle listing style" } },
            { "n", "f",              actions.toggle_flatten_dirs,  { desc = "Toggle flatten dirs" } },
            { "n", "R",              actions.refresh_files,        { desc = "Refresh files" } },
            { "n", "<leader>e",      actions.focus_files,          { desc = "Focus files" } },
            { "n", "<leader>b",      actions.toggle_files,         { desc = "Toggle files panel" } },
            { "n", "g<C-x>",         actions.cycle_layout,         { desc = "Cycle layout" } },
            { "n", "[x",             actions.prev_conflict,        { desc = "Previous conflict" } },
            { "n", "]x",             actions.next_conflict,        { desc = "Next conflict" } },
          },

          file_history_panel = {
            { "n", "g!",            actions.options,              { desc = "Options" } },
            { "n", "<C-A-d>",       actions.open_in_diffview,     { desc = "Open in diffview" } },
            { "n", "y",             actions.copy_hash,            { desc = "Copy commit hash" } },
            { "n", "L",             actions.open_commit_log,      { desc = "Open commit log" } },
            { "n", "zR",            actions.open_all_folds,       { desc = "Open all folds" } },
            { "n", "zM",            actions.close_all_folds,      { desc = "Close all folds" } },
            { "n", "j",             actions.next_entry,           { desc = "Next entry" } },
            { "n", "<down>",        actions.next_entry,           { desc = "Next entry" } },
            { "n", "k",             actions.prev_entry,           { desc = "Previous entry" } },
            { "n", "<up>",          actions.prev_entry,           { desc = "Previous entry" } },
            { "n", "<cr>",          actions.select_entry,         { desc = "Select entry" } },
            { "n", "o",             actions.select_entry,         { desc = "Select entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry,         { desc = "Select entry" } },
            { "n", "<c-b>",         actions.scroll_view(-0.25),   { desc = "Scroll up" } },
            { "n", "<c-f>",         actions.scroll_view(0.25),    { desc = "Scroll down" } },
            { "n", "<tab>",         actions.select_next_entry,    { desc = "Next entry" } },
            { "n", "<s-tab>",       actions.select_prev_entry,    { desc = "Previous entry" } },
            { "n", "gf",            actions.goto_file,            { desc = "Go to file" } },
            { "n", "<C-w><C-f>",    actions.goto_file_split,      { desc = "Go to file in split" } },
            { "n", "<C-w>gf",       actions.goto_file_tab,        { desc = "Go to file in tab" } },
            { "n", "<leader>e",     actions.focus_files,          { desc = "Focus files" } },
            { "n", "<leader>b",     actions.toggle_files,         { desc = "Toggle files panel" } },
            { "n", "g<C-x>",        actions.cycle_layout,         { desc = "Cycle layout" } },
          },

          option_panel = {
            { "n", "<tab>", actions.select_entry,         { desc = "Select entry" } },
            { "n", "q",     actions.close,                { desc = "Close" } },
          },
        },
      })
    end,
  },

  -- ============================================================================
  -- git-conflict.nvim - Simple Conflict Resolution
  -- ============================================================================

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = "copen",
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText",
        },
      })

      -- Keymaps (default mappings)
      -- co - Choose ours
      -- ct - Choose theirs
      -- cb - Choose both
      -- c0 - Choose none
      -- ]x - Next conflict
      -- [x - Previous conflict
    end,
  },

  -- ============================================================================
  -- gitlinker.nvim - Generate GitHub/GitLab Permalinks
  -- ============================================================================

  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gy", mode = { "n", "v" }, desc = "Copy git permalink" },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          remote = nil,
          add_current_line_on_normal_mode = true,
          action_callback = require("gitlinker.actions").copy_to_clipboard,
          print_url = true,
        },
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        },
        mappings = "<leader>gy",
      })
    end,
  },
}
