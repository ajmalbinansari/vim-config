-- General Keymaps Configuration
-- Non-plugin and non-LSP keymaps
-- LSP keymaps are in lua/config/lsp/keymaps.lua
-- Plugin-specific keymaps are in their respective plugin files

-- ============================================================================
-- Editor Shortcuts
-- ============================================================================

-- Save file
vim.api.nvim_set_keymap('n', '<leader>l', ':w<CR>', { silent = true })

-- Format code with conform.nvim
vim.api.nvim_set_keymap(
  'n',
  '<leader>f',
  '<cmd>lua require("conform").format({ lsp_fallback = true })<CR>',
  { noremap = true, silent = true }
)

-- ============================================================================
-- LSP Navigation (Additional - core LSP keymaps in lsp/keymaps.lua)
-- ============================================================================

vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { silent = true })

-- ============================================================================
-- Telescope Shortcuts (search word under cursor)
-- ============================================================================

-- Find files with word under cursor
vim.api.nvim_set_keymap(
  'n',
  '<leader>j',
  ":execute 'Telescope find_files default_text=' . expand('<cword>')<CR>",
  { silent = true }
)

-- Live grep with word under cursor
vim.api.nvim_set_keymap(
  'n',
  '<leader>k',
  ":execute 'Telescope live_grep default_text=' . expand('<cword>')<CR>",
  { silent = true }
)

-- Note: Main telescope keymaps (<leader>t, <leader>g, etc.) are defined in lua/plugins/telescope.lua

-- ============================================================================
-- Git Shortcuts (vim-fugitive)
-- ============================================================================

vim.api.nvim_set_keymap('n', '<leader>vs', ':Git<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vc', ':Git commit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vp', ':Git push<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vl', ':Git pull<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vb', ':Git blame<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>vd', ':Gdiffsplit<CR>', { noremap = true, silent = true })

-- Note: NERDTree and Claude Code keymaps are in their respective plugin files
