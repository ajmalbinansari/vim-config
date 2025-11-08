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
-- PHP Language Server (PHPActor)
-- ============================================================================

vim.lsp.config('phpactor', {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
  capabilities = capabilities,
})

-- ============================================================================
-- Enable All Servers
-- ============================================================================

function M.setup()
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('flow')
  vim.lsp.enable('phpactor')
end

return M
