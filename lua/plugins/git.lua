-- Git Integration Plugins
-- Fugitive and GitGutter

return {
  -- ============================================================================
  -- Git Commands (Fugitive)
  -- ============================================================================

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiff", "Gblame", "Glog" },
  },

  -- ============================================================================
  -- Git Diff Indicators (GitGutter)
  -- ============================================================================

  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },
}
