# Neovim Configuration

Neovim configuration for TypeScript/JavaScript, PHP (Laravel/Symfony), and web development.

## Plugins

### Language Server Protocol
- `mason.nvim` - LSP/DAP/linter package manager
- `mason-lspconfig.nvim` - Bridge between Mason and lspconfig
- `nvim-lspconfig` - LSP client configurations
- `schemastore.nvim` - 400+ JSON/YAML schemas

**Servers:** lua_ls, ts_ls, intelephense, phpactor, jsonls, yamlls

### Completion
- `nvim-cmp` - Completion engine
- `cmp-nvim-lsp` - LSP completion source
- `cmp-buffer` - Buffer word source
- `LuaSnip` - Snippet engine
- `lspkind.nvim` - VS Code-like pictograms

### Syntax & Editing
- `nvim-treesitter` - AST-based syntax parsing
- `nvim-treesitter-textobjects` - Syntax-aware text objects
- `nvim-treesitter-context` - Sticky function/class headers
- `nvim-ts-autotag` - Auto-close HTML/JSX tags
- `nvim-colorizer.lua` - Inline color preview
- `mini.surround` - Surround operations (quotes, brackets)
- `mini.comment` - Smart commenting
- `mini.pairs` - Auto-pair brackets
- `mini.ai` - Enhanced text objects

### Navigation & Search
- `telescope.nvim` - Fuzzy finder
- `telescope-ui-select.nvim` - Telescope UI for vim.ui.select
- `flash.nvim` - Label-based motion
- `harpoon` - Project-local file bookmarks
- `neo-tree.nvim` - File explorer
- `oil.nvim` - Edit directories as buffers

### Git
- `lazygit.nvim` - Terminal UI integration
- `gitsigns.nvim` - Git diff signs and hunk operations
- `diffview.nvim` - Advanced diff and merge tool
- `git-conflict.nvim` - Conflict resolution helper
- `gitlinker.nvim` - Generate GitHub/GitLab permalinks

### Debugging & Testing
- `nvim-dap` - Debug Adapter Protocol client
- `nvim-dap-ui` - Debug UI
- `nvim-dap-virtual-text` - Inline variable values
- `mason-nvim-dap.nvim` - DAP adapter installer
- `neotest` - Test runner framework
- `neotest-jest` - Jest adapter
- `neotest-phpunit` - PHPUnit adapter

### Formatting & Linting
- `conform.nvim` - Formatter runner (prettierd, stylua, php-cs-fixer)
- `nvim-lint` - Asynchronous linter (eslint, phpcs)

### UI
- `catppuccin` - Colorscheme
- `vim-airline` - Status line
- `nvim-web-devicons` - File icons
- `which-key.nvim` - Keybinding popup
- `diagflow.nvim` - Inline diagnostics

### AI
- `claude-code.nvim` - Claude Code integration

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version lock
│
└── lua/
    ├── config/
    │   ├── lazy.lua            # Lazy.nvim bootstrap
    │   ├── options.lua         # Vim options
    │   ├── keymaps.lua         # General keymaps
    │   └── lsp/
    │       ├── init.lua        # LSP setup, on_attach, capabilities
    │       ├── servers.lua     # Server-specific configurations
    │       └── keymaps.lua     # LSP keybindings
    │
    └── plugins/
        ├── ui.lua              # Colorscheme, statusline, icons
        ├── editor.lua          # Treesitter, colorizer, comments
        ├── lsp.lua             # Mason, lspconfig, schemastore
        ├── completion.lua      # nvim-cmp, sources, snippets
        ├── telescope.lua       # Fuzzy finder
        ├── git.lua             # Git workflow plugins
        ├── files.lua           # Neo-tree, oil.nvim
        ├── navigation.lua      # Harpoon, Flash
        ├── formatting.lua      # conform.nvim
        ├── linting.lua         # nvim-lint
        ├── debugging.lua       # nvim-dap setup
        ├── testing.lua         # neotest setup
        ├── which-key.lua       # Keybinding documentation
        ├── mini.lua            # mini.nvim plugins
        ├── diagnostics.lua     # diagflow, code-action-menu
        └── ai.lua              # Claude Code
```

## Key Features

- **Lazy Loading:** Event-based loading for optimal startup time
- **LSP:** Single LspAttach pattern for all servers
- **Schema Validation:** Automatic JSON/YAML schema detection
- **Format on Save:** prettierd (10-20x faster than prettier)
- **Inline Diagnostics:** Real-time error display
- **Project Navigation:** Harpoon for quick file bookmarks
- **Label Motion:** Flash for precise jumping
- **Test Integration:** Run tests inline with neotest
- **Debug Support:** Full DAP for TS/JS/PHP
- **Git Workflow:** LazyGit + Gitsigns + Diffview

## Requirements

- Neovim >= 0.11.0
- Node.js >= 18 (for LSP servers, prettierd)
- Git
- ripgrep (for telescope grep)
- fd (for telescope file search)
- lazygit (optional, for git UI)
