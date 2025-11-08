-- File Management Plugins
-- NERDTree file explorer

return {
  -- ============================================================================
  -- File Explorer (NERDTree)
  -- ============================================================================

  {
    "preservim/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<leader>n", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree", silent = true },
      { "<leader>F", ":NERDTreeFind<CR>", desc = "Find in NERDTree", silent = true },
    },
  },
}
