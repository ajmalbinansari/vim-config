-- Neovim Options Configuration
-- All vim.opt and vim.g settings

-- ============================================================================
-- Display Options
-- ============================================================================

-- Line numbers
vim.opt.number = true              -- Show absolute line numbers
vim.opt.relativenumber = true      -- Show relative line numbers

-- Colors
vim.opt.termguicolors = true       -- Enable true color support

-- Folding
vim.opt.foldcolumn = '1'           -- Show fold column
vim.opt.foldlevelstart = 99        -- Start with all folds open

-- ============================================================================
-- Search Options
-- ============================================================================

vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Smart case handling

-- ============================================================================
-- Editor Behavior
-- ============================================================================

vim.opt.viminfo = "'1000,h"        -- Remember marks for 1000 files

-- ============================================================================
-- NERDTree Configuration
-- ============================================================================

vim.g.NERDTreeShowHidden = 1                      -- Show hidden files
vim.g.NERDTreeShowLineNumbers = 1                 -- Show line numbers
vim.opt_local.relativenumber = true               -- Relative numbers in NERDTree
vim.g.NERDTreeMinimalUI = 1                       -- Minimal UI
vim.g.NERDTreeDirArrowExpandable = '⬏'            -- Expand arrow
vim.g.NERDTreeDirArrowCollapsible = '⬎'           -- Collapse arrow
vim.g.NERDTreeIgnore = {                          -- Ignore patterns
  '^\\.DS_Store$',
  '^tags$',
  '\\.git$[[dir]]',
  '\\.idea$[[dir]]',
  '\\.sass-cache$'
}
vim.g.NERDTreeWinPos = 'left'                     -- Window position
vim.g.NERDTreeWinSize = 60                        -- Window size
vim.g.NERDTreeHighlightCursorline = 0             -- No cursor highlight

-- ============================================================================
-- NERDCommenter Configuration
-- ============================================================================

vim.g.NERDSpaceDelims = 1                         -- Add space after comment delimiters
vim.g.NERDCompactSexyComs = 1                     -- Use compact syntax for multiline
vim.g.NERDDefaultAlign = 'left'                   -- Align left
vim.g.NERDAltDelims_java = 1                      -- Use alt delimiters for Java
vim.g.NERDCommentEmptyLines = 1                   -- Comment empty lines
vim.g.NERDTrimTrailingWhitespace = 1              -- Trim whitespace when uncommenting
vim.g.NERDToggleCheckAllLines = 1                 -- Check all lines when toggling

-- ============================================================================
-- Colorscheme
-- ============================================================================

vim.cmd('colorscheme deus')
