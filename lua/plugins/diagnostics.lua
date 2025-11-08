-- Diagnostic Display Plugins
-- Diagflow and code action menu

return {
  -- ============================================================================
  -- Inline Diagnostic Display (Diagflow)
  -- ============================================================================

  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    config = function()
      require('diagflow').setup()
    end,
  },

  -- ============================================================================
  -- Code Action Menu
  -- ============================================================================

  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
}
