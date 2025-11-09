-- LSP Server Configurations
-- Individual language server settings

local M = {}

-- Get capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ============================================================================
-- Lua Language Server
-- ============================================================================

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git'
  },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
})

-- ============================================================================
-- TypeScript/JavaScript Language Server
-- ============================================================================

-- Note: Formatting is disabled - Prettier handles formatting via conform.nvim
-- ts_ls provides: type checking, intelligent refactoring, auto-imports
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities,
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "jsx"
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
})

-- Disable TS formatting via LspAttach (handled in init.lua for all servers)
-- This is done centrally to avoid duplication

-- ============================================================================
-- Flow Type Checker
-- ============================================================================

vim.lsp.config('flow', {
  cmd = { 'flow', 'lsp' },
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx' },
  root_markers = { '.flowconfig' },
  capabilities = capabilities,
})

-- ============================================================================
-- PHP Language Server (Intelephense - Primary)
-- ============================================================================

vim.lsp.config('intelephense', {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  capabilities = capabilities,
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000,
      },
    },
  },
})

-- ============================================================================
-- PHP Language Server (PHPActor - Refactoring Support)
-- ============================================================================

vim.lsp.config('phpactor', {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  capabilities = capabilities,
})

-- ============================================================================
-- JSON Language Server
-- ============================================================================

vim.lsp.config('jsonls', {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = { '.git' },
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
})

-- ============================================================================
-- YAML Language Server
-- ============================================================================

vim.lsp.config('yamlls', {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose' },
  root_markers = { '.git' },
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})

-- ============================================================================
-- ESLint Language Server
-- ============================================================================
-- Provides: code actions, auto-fix (EslintFixAll), diagnostics
-- Note: nvim-lint ALSO provides ESLint diagnostics via eslint_d (complementary)
-- Formatting is disabled - Prettier handles formatting via conform.nvim
-- EslintFixAll command comes from nvim-lspconfig's eslint.lua

vim.lsp.config('eslint', {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  capabilities = capabilities,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.json',
    '.eslintrc.cjs',
    'eslint.config.js',
    'package.json',
  },
  settings = {
    format = false,
    validate = 'on',
    run = 'onType',
    workingDirectory = { mode = 'auto' },
  },
})

-- ESLint-specific on_attach logic is in init.lua LspAttach autocmd

-- ============================================================================
-- Enable All Servers
-- ============================================================================

function M.setup()
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('flow')
  vim.lsp.enable('intelephense')
  vim.lsp.enable('phpactor')
  vim.lsp.enable('jsonls')
  vim.lsp.enable('yamlls')
  vim.lsp.enable('eslint')
end

return M
