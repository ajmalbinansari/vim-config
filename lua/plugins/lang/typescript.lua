-- TypeScript/JavaScript Language Plugins
-- Enhanced syntax highlighting for TS/JS/TSX/JSX

return {
  -- ============================================================================
  -- TypeScript Syntax
  -- ============================================================================

  {
    "HerringtonDarkholme/yats.vim",
    ft = { "typescript", "typescriptreact" },
  },

  -- ============================================================================
  -- JSX/JavaScript Syntax
  -- ============================================================================

  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "jsx" },
  },
}
