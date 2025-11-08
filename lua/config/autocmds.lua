-- Autocommands Configuration
-- All autocommands and autocommand groups

-- ============================================================================
-- NERDTree Auto-close
-- ============================================================================

-- Automatically close NERDTree when it's the last window
vim.cmd([[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
]])

-- ============================================================================
-- Filetype Mappings
-- ============================================================================

-- Treat all JSON files as JSONC (to support comments)
vim.cmd([[
  augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
  augroup END
]])
