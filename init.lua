-- Remap leader key to "," (MUST be set before lazy.nvim)
vim.g.mapleader = ','

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Load LSP config
require('lsp-config')

-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Additional LSP key mappings (basic navigation is in lsp-config.lua)
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { silent = true })
-- Use [d and ]d for diagnostics (standard vim convention)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':w<CR>', { silent = true })

-- Telescope key mappings (note: some are handled by lazy.nvim, these are extras)
vim.api.nvim_set_keymap(
  'n',
  '<leader>j',
  ":execute 'Telescope find_files default_text=' . expand('<cword>')<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '<leader>k',
  ":execute 'Telescope live_grep default_text=' . expand('<cword>')<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>lua vim.diagnostic.setloclist()<CR>', { silent = true })
vim.api.nvim_set_keymap(
  'n',
  '<leader>f',
  '<cmd>lua require("conform").format({ lsp_fallback = true })<CR>',
  { noremap = true, silent = true }
)

-- NERDTree settings
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.opt_local.relativenumber = true
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrowExpandable = '⬏'
vim.g.NERDTreeDirArrowCollapsible = '⬎'
vim.g.NERDTreeIgnore = { '^\\.DS_Store$', '^tags$', '\\.git$[[dir]]', '\\.idea$[[dir]]', '\\.sass-cache$' }
vim.g.NERDTreeWinPos = 'left'
vim.g.NERDTreeWinSize = 60
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDAltDelims_java = 1
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1
vim.g.NERDTreeHighlightCursorline = 0

-- Set termguicolors
vim.opt.termguicolors = true

-- Set search options
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Automatic closing of NERDTree when it's the last window
vim.cmd([[
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
]])

-- Consider all json files as jsonc
vim.cmd([[
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END
]])

-- Set color scheme
vim.cmd('colorscheme deus')

-- Enable auto formatting
vim.opt.viminfo = "'1000,h"

-- Folding settings
vim.opt.foldcolumn = '1'
vim.opt.foldlevelstart = 99
