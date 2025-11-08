require('nvim-treesitter.configs').setup {
  -- Install parsers for these languages
  ensure_installed = { "lua", "typescript", "javascript", "php", "html", "css", "json", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- Enable syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- Enable indentation
  indent = {
    enable = true,
  },
}
