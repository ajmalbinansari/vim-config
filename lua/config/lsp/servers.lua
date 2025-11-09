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

vim.lsp.config('ts_ls', {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
    "jsx"
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  capabilities = capabilities,
})

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
end

return M
