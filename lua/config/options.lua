-- Neovim Options Configuration
-- All vim.opt and vim.g settings

-- ============================================================================
-- Display Options
-- ============================================================================

-- Line numbers
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = 'yes' -- Always show sign column (prevents text shifting)
vim.opt.numberwidth = 4 -- Width of number column

-- Colors
vim.opt.termguicolors = true -- Enable true color support

-- Folding
vim.opt.foldcolumn = '1' -- Show fold column
vim.opt.foldlevelstart = 99 -- Start with all folds open

-- ============================================================================
-- Search Options
-- ============================================================================

vim.opt.ignorecase = true -- Case-insensitive search
vim.opt.smartcase = true -- Smart case handling

-- ============================================================================
-- Editor Behavior
-- ============================================================================

vim.opt.viminfo = "'1000,h" -- Remember marks for 1000 files

-- ============================================================================
-- Indentation Options
-- ============================================================================

vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- Number of spaces for each indent
vim.opt.softtabstop = 2 -- Number of spaces a tab counts for while editing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.autoindent = true -- Copy indent from current line when starting new line
vim.opt.smartindent = true -- Smart autoindenting for C-like languages
vim.opt.breakindent = true -- Wrapped lines continue with same indent

-- ============================================================================
-- NERDCommenter Configuration
-- ============================================================================

vim.g.NERDSpaceDelims = 1 -- Add space after comment delimiters
vim.g.NERDCompactSexyComs = 1 -- Use compact syntax for multiline
vim.g.NERDDefaultAlign = 'left' -- Align left
vim.g.NERDAltDelims_java = 1 -- Use alt delimiters for Java
vim.g.NERDCommentEmptyLines = 1 -- Comment empty lines
vim.g.NERDTrimTrailingWhitespace = 1 -- Trim whitespace when uncommenting
vim.g.NERDToggleCheckAllLines = 1 -- Check all lines when toggling

-- ============================================================================
-- Performance Optimization
-- ============================================================================

-- Disable unused built-in plugins for faster startup
vim.g.loaded_netrw = 1 -- Disable netrw (using Neo-tree)
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin
vim.g.loaded_gzip = 1 -- Disable gzip
vim.g.loaded_tar = 1 -- Disable tar
vim.g.loaded_tarPlugin = 1 -- Disable tar plugin
vim.g.loaded_zip = 1 -- Disable zip
vim.g.loaded_zipPlugin = 1 -- Disable zip plugin
vim.g.loaded_2html_plugin = 1 -- Disable 2html
vim.g.loaded_vimball = 1 -- Disable vimball
vim.g.loaded_vimballPlugin = 1 -- Disable vimball plugin
vim.g.loaded_matchit = 1 -- Disable matchit (using Treesitter)
vim.g.loaded_matchparen = 1 -- Disable matchparen (using Treesitter)
vim.g.loaded_logiPat = 1 -- Disable LogiPat
vim.g.loaded_rrhelper = 1 -- Disable rrhelper
vim.g.loaded_getscript = 1 -- Disable getscript
vim.g.loaded_getscriptPlugin = 1 -- Disable getscript plugin

-- ============================================================================
-- Colorscheme
-- ============================================================================

vim.cmd('colorscheme catppuccin-mocha')
