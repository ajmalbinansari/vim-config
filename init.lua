-- Load plugins.vim
vim.cmd("source ~/.config/nvim/plugins.vim")

-- Load mason and tsserver LSP
require("mason").setup()
require("lsp-config")
require("null-ls-config")
-- require("prettier-config")
require("completions-config")


-- Remap leader key to ","
vim.g.mapleader = ","

-- Set line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- LSP key mappings
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ac", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>lua vim.lsp.buf.format()<CR>:w<CR>", { silent = true })

-- Telescope key mappings
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>Telescope find_files<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>j", ":execute 'Telescope find_files default_text=' . expand('<cword>')<CR>",
	{ silent = true })
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Telescope live_grep<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>Telescope current_buffer<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":execute 'Telescope live_grep default_text=' . expand('<cword>')<CR>",
	{ silent = true })
vim.api.nvim_set_keymap("n", ";", "<cmd>Telescope buffers<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua vim.diagnostic.setloclist()<CR>", { silent = true })

-- NERDTree settings
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeShowLineNumbers = 1
vim.opt_local.relativenumber = true
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeDirArrowExpandable = '⬏'
vim.g.NERDTreeDirArrowCollapsible = '⬎'
vim.g.NERDTreeIgnore = { '^\\.DS_Store$', '^tags$', '\\.git$[[dir]]', '\\.idea$[[dir]]', '\\.sass-cache$' }
vim.g.NERDTreeWinPos = "left"
vim.g.NERDTreeWinSize = 60
vim.g.NERDSpaceDelims = 1
vim.g.NERDCompactSexyComs = 1
vim.g.NERDDefaultAlign = 'left'
vim.g.NERDAltDelims_java = 1
-- vim.g.NERDCustomDelimiters = { 'c': { 'left': '/**', 'right': '*/' } }
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1
vim.g.NERDTreeHighlightCursorline = 0
vim.cmd("hi NERDTreeCWD guifg=#99c794")
-- vim.g.NERDTreeNodeDelimiter = "\u00a0"

-- Key mappings
vim.api.nvim_set_keymap("n", "<leader>n", ":NERDTreeToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>F", ":NERDTreeFind<CR>", { silent = true })

-- Set termguicolors
vim.opt.termguicolors = true

-- Configure nvim-colorizer.lua
require 'colorizer'.setup()

-- Set search options
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Automatic closing of NERDTree
vim.cmd([[
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * NERDTree | wincmd p
]])

-- Consider all json files as jsonc
vim.cmd([[
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END
]])

-- Set color scheme
vim.cmd("colorscheme deus")

-- Run PhpCsFixer on save for PHP files
vim.cmd("autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()")

-- Enable auto formatting
vim.opt.viminfo = "'1000,h"

-- Folding settings
vim.opt.foldmethod = "syntax"
vim.opt.foldcolumn = "1"
vim.opt.foldlevelstart = 99
