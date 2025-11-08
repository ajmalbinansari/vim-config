# Neovim Configuration Modernization Plan

**Date:** 2025-11-08
**Current Structure:** Legacy monolithic approach
**Target Structure:** Modern modular lazy.nvim best practices
**Estimated Time:** 30-45 minutes
**Risk Level:** Low (non-breaking, fully reversible)

---

## Executive Summary

This plan reorganizes your Neovim configuration from a monolithic structure into the community-recommended modular pattern used by LazyVim, AstroNvim, and modern Neovim distributions. All functionality remains identical - we're only improving organization and maintainability.

### Benefits
- **Easier Maintenance**: Find and modify settings in seconds
- **Better Scalability**: Add/remove plugins without touching other configs
- **Clearer Organization**: Each file has a single, clear purpose
- **Standard Pattern**: Aligns with community best practices
- **Better Debugging**: Issues are easier to isolate
- **Improved Collaboration**: Standard structure others recognize

---

## Current vs. Proposed Structure

### Current Structure (Problems Highlighted)
```
~/.config/nvim/
├── init.lua                      ⚠️ 300+ lines, mixed concerns
├── lazy-lock.json                ✅ Keep as-is
├── .stylua.toml                  ✅ Keep as-is
├── .gitignore                    ✅ Keep as-is
├── prettier-config               ✅ Keep as-is
└── lua/
    ├── plugins.lua               ⚠️ 400+ lines, all plugins in one file
    ├── lsp-config.lua            ⚠️ Mixed: setup + servers + keymaps
    ├── treesitter-config.lua     ⚠️ Config mixed with plugin spec
    ├── completions-config.lua    ⚠️ Config mixed with plugin spec
    ├── telescope-config.lua      ⚠️ Config mixed with plugin spec
    ├── conform-config.lua        ⚠️ Config mixed with plugin spec
    └── diagflow-config.lua       ⚠️ Config mixed with plugin spec
```

### Proposed Structure (Modern Best Practice)
```
~/.config/nvim/
├── init.lua                      ✨ Clean entry point (10 lines)
├── lazy-lock.json                ✅ No change
├── .stylua.toml                  ✅ No change
├── .gitignore                    ✅ No change
├── prettier-config               ✅ No change
│
└── lua/
    ├── config/                   ✨ Core configuration
    │   ├── lazy.lua              # Lazy.nvim bootstrap
    │   ├── options.lua           # All vim.opt settings
    │   ├── keymaps.lua           # General keymaps
    │   ├── autocmds.lua          # Autocommands
    │   └── lsp/                  # LSP-specific
    │       ├── init.lua          # Setup & on_attach
    │       ├── servers.lua       # Server configurations
    │       └── keymaps.lua       # LSP keymaps
    │
    └── plugins/                  ✨ One concern per file
        ├── ui.lua                # Colorscheme, statusline, icons
        ├── editor.lua            # Treesitter, colorizer, comments
        ├── lsp.lua               # Mason, lspconfig
        ├── completion.lua        # nvim-cmp, snippets
        ├── telescope.lua         # Fuzzy finder
        ├── git.lua               # Fugitive, gitgutter
        ├── files.lua             # NERDTree
        ├── formatting.lua        # Conform.nvim
        ├── diagnostics.lua       # Diagflow, code actions
        ├── ai.lua                # Copilot, Claude Code
        └── lang/                 # Language-specific
            ├── typescript.lua    # TS/JS/TSX/JSX
            ├── php.lua           # Laravel, Blade, Composer
            └── web.lua           # HTML, CSS
```

---

## Detailed File Mapping

### Phase 1: Core Configuration Files

#### `init.lua` (NEW VERSION)
**Current:** 300+ lines of mixed bootstrap, options, keymaps, and plugin configs
**New:** 10 lines - clean entry point only

```lua
-- Set leader keys first
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Bootstrap and load configuration modules
require('config.lazy')      -- Lazy.nvim setup
require('config.options')   -- Vim options
require('config.keymaps')   -- General keymaps
require('config.autocmds')  -- Autocommands
```

**Source:** Lines 1-128 from current `init.lua`
**Action:** Extract and reorganize into config modules

---

#### `lua/config/lazy.lua` (NEW)
**Purpose:** Bootstrap lazy.nvim plugin manager
**Lines:** ~25

**Content:**
- Lazy.nvim installation check and clone
- Path setup
- Plugin spec loading from `lua/plugins/`
- Performance optimizations

**Source:** Lines 1-38 from current `init.lua`
**Dependencies:** None

---

#### `lua/config/options.lua` (NEW)
**Purpose:** All vim.opt and vim.g settings
**Lines:** ~60

**Content Sections:**
1. Leader key settings
2. Display options (line numbers, colors, folds)
3. Search settings (ignorecase, smartcase)
4. Editor behavior (indentation, clipboard)
5. NERDTree global settings
6. Colorscheme application

**Source:**
- Lines 39-43 from `init.lua` (leader keys)
- Lines 102-128 from `init.lua` (options)
- Lines 82-99 from `init.lua` (NERDTree settings)

**Dependencies:** None

---

#### `lua/config/keymaps.lua` (NEW)
**Purpose:** General (non-LSP, non-plugin) keymaps
**Lines:** ~40

**Content Sections:**
1. Editor keymaps (`<leader>l` save, `<leader>f` format)
2. Telescope keymaps (`<leader>t`, `<leader>g`, `;`, etc.)
3. Git keymaps (`<leader>v` prefix)
4. NERDTree keymaps (`<leader>n`, `<leader>F`)
5. Comment keymaps (`<leader>c<space>`)

**Source:** Lines 44-80 from current `init.lua`
**Excludes:** LSP keymaps (moved to `lua/config/lsp/keymaps.lua`)

**Dependencies:** Plugins (telescope, NERDTree, fugitive)

---

#### `lua/config/autocmds.lua` (NEW)
**Purpose:** All autocommands and autocommand groups
**Lines:** ~25

**Content:**
1. NERDTree auto-close when last window
2. JSON to JSONC filetype mapping
3. PHPformat group (from lsp-config.lua)

**Source:**
- Lines 130-145 from `init.lua`
- Line 2 from `lua/lsp-config.lua` (PHPformat group)

**Dependencies:** NERDTree plugin

---

### Phase 2: LSP Configuration

#### `lua/config/lsp/init.lua` (NEW)
**Purpose:** LSP initialization, on_attach, and capabilities
**Lines:** ~60

**Content:**
1. Custom LSP kind icons
2. `enable_format_on_save()` function
3. `on_attach()` function with:
   - LSP keymaps setup (delegated to keymaps.lua)
   - Diagnostic float configuration
   - CursorHold autocmd for diagnostics
4. Capabilities setup for nvim-cmp

**Source:** Lines 1-82 from `lua/lsp-config.lua`
**Dependencies:**
- `lua/config/lsp/keymaps.lua`
- nvim-cmp (for capabilities)

---

#### `lua/config/lsp/servers.lua` (NEW)
**Purpose:** Individual LSP server configurations
**Lines:** ~90

**Content:**
1. `lua_ls` configuration (Lua language server)
2. `ts_ls` configuration (TypeScript/JavaScript)
3. `flow` configuration (Flow type checker)
4. `phpactor` configuration (PHP)

**Source:** Lines 85-164 from `lua/lsp-config.lua`
**Dependencies:** nvim-lspconfig

---

#### `lua/config/lsp/keymaps.lua` (NEW)
**Purpose:** LSP-specific keymaps applied in on_attach
**Lines:** ~30

**Content:**
- `gD` - Go to declaration
- `gd` - Go to definition
- `gi` - Go to implementation
- `K` - Hover documentation
- `gr` - References
- `<C-k>` - Signature help
- `1gD` - Type definition
- `[d` / `]d` - Diagnostic navigation
- `<leader>rn` - Rename
- `<leader>ac` - Code actions
- `<leader>dd` - Diagnostics list

**Source:** Lines 50-82 from `lua/lsp-config.lua`
**Usage:** Called from `on_attach()` function

---

### Phase 3: Plugin Specifications

#### `lua/plugins/ui.lua` (NEW)
**Purpose:** Visual/UI plugins
**Lines:** ~60

**Plugins:**
1. `vim-deus` - Colorscheme
2. `vim-airline` - Status line
3. `vim-devicons` - File icons
4. `nvim-web-devicons` - Lua file icons
5. `nightfox.nvim` - Alternative colorscheme

**Source:** Lines from `lua/plugins.lua`
**Config:** Colorscheme setting from `init.lua:128`

---

#### `lua/plugins/editor.lua` (NEW)
**Purpose:** Editor enhancement plugins
**Lines:** ~70

**Plugins:**
1. `nvim-treesitter` - Syntax highlighting
   - Config from `lua/treesitter-config.lua`
   - Parsers: lua, typescript, javascript, php, html, css, json, vim
2. `nvim-colorizer.lua` - Color preview
3. `nerdcommenter` - Code commenting

**Source:**
- Plugin specs from `lua/plugins.lua`
- Config from `lua/treesitter-config.lua`

---

#### `lua/plugins/lsp.lua` (NEW)
**Purpose:** LSP-related plugins
**Lines:** ~40

**Plugins:**
1. `mason.nvim` - LSP package manager
2. `mason-lspconfig.nvim` - Mason-lspconfig bridge
3. `nvim-lspconfig` - LSP configuration

**Source:** Lines from `lua/plugins.lua`
**Config:** Server setup from `lua/config/lsp/servers.lua`

---

#### `lua/plugins/completion.lua` (NEW)
**Purpose:** Autocompletion system
**Lines:** ~80

**Plugins:**
1. `nvim-cmp` - Completion engine
2. `cmp-nvim-lsp` - LSP source
3. `cmp-buffer` - Buffer source
4. `LuaSnip` - Snippet engine

**Source:**
- Plugin specs from `lua/plugins.lua`
- Config from `lua/completions-config.lua`

**Config Includes:**
- Custom kind icons
- Keymaps (Ctrl+b/f scroll, CR confirm, etc.)
- Source priorities

---

#### `lua/plugins/telescope.lua` (NEW)
**Purpose:** Fuzzy finder and picker
**Lines:** ~90

**Plugins:**
1. `telescope.nvim` - Main plugin
2. `telescope-ui-select.nvim` - UI select extension

**Source:**
- Plugin specs from `lua/plugins.lua`
- Config from `lua/telescope-config.lua`

**Config Includes:**
- SQLite history database
- Layout configuration (horizontal, 75%)
- File sorter setup
- Buffer deletion keymap
- History navigation

**Keymaps:** Defined inline with plugin spec

---

#### `lua/plugins/git.lua` (NEW)
**Purpose:** Git integration
**Lines:** ~35

**Plugins:**
1. `vim-fugitive` - Git commands
2. `vim-gitgutter` - Git diff indicators

**Source:** Lines from `lua/plugins.lua`
**Keymaps:** Git shortcuts (`<leader>v` prefix) from `init.lua`

---

#### `lua/plugins/files.lua` (NEW)
**Purpose:** File management
**Lines:** ~50

**Plugins:**
1. `nerdtree` - File explorer
2. Related keymaps and settings

**Source:**
- Plugin spec from `lua/plugins.lua`
- Settings from `init.lua:82-99`
- Keymaps from `init.lua`

**Config Includes:**
- Show hidden files
- Line numbers
- Custom arrows
- Ignore patterns
- Window settings

---

#### `lua/plugins/formatting.lua` (NEW)
**Purpose:** Code formatting
**Lines:** ~35

**Plugins:**
1. `conform.nvim` - Formatter runner

**Source:**
- Plugin spec from `lua/plugins.lua`
- Config from `lua/conform-config.lua`

**Config Includes:**
- Prettier for: JS, TS, CSS, HTML, JSON, YAML, Markdown
- StyLua for Lua
- Format on save (500ms timeout)
- LSP fallback

---

#### `lua/plugins/diagnostics.lua` (NEW)
**Purpose:** Diagnostic display
**Lines:** ~25

**Plugins:**
1. `diagflow.nvim` - Inline diagnostics
2. `nvim-code-action-menu` - Code action UI

**Source:**
- Plugin specs from `lua/plugins.lua`
- Config from `lua/diagflow-config.lua`

---

#### `lua/plugins/ai.lua` (NEW)
**Purpose:** AI coding assistants
**Lines:** ~40

**Plugins:**
1. `copilot.vim` - GitHub Copilot
   - Node.js v22 path configuration
2. `claude-code.nvim` - Claude integration
   - Toggle keymap: `<C-,>`

**Source:** Lines from `lua/plugins.lua`

---

#### `lua/plugins/lang/typescript.lua` (NEW)
**Purpose:** TypeScript/JavaScript support
**Lines:** ~20

**Plugins:**
1. `yats.vim` - TypeScript syntax
2. `vim-jsx-pretty` - JSX/TSX syntax

**Source:** Lines from `lua/plugins.lua`

---

#### `lua/plugins/lang/php.lua` (NEW)
**Purpose:** PHP/Laravel development
**Lines:** ~35

**Plugins:**
1. `vim-blade` - Blade templates
2. `vim-laravel` - Laravel support
3. `vim-projectionist` - Project navigation
4. `vim-composer` - Composer integration
5. `vim-dispatch` - Async commands

**Source:** Lines from `lua/plugins.lua`

---

#### `lua/plugins/lang/web.lua` (NEW)
**Purpose:** HTML/CSS support
**Lines:** ~15

**Content:** Reserved for future HTML/CSS specific plugins
**Note:** Currently handled by Treesitter, but separated for future additions

---

## Migration Steps

### Pre-Migration Checklist
- [ ] Commit all current changes: `git add -A && git commit -m "Pre-migration snapshot"`
- [ ] Create backup branch: `git checkout -b pre-migration-backup`
- [ ] Return to main: `git checkout claude-code`
- [ ] Verify Neovim works: `nvim --version`
- [ ] Close all Neovim instances

### Step 1: Create Directory Structure
```bash
cd ~/.config/nvim
mkdir -p lua/config/lsp
mkdir -p lua/plugins/lang
```

### Step 2: Create Core Config Files (Order Matters)
1. `lua/config/lazy.lua` - Bootstrap first
2. `lua/config/options.lua` - Options second
3. `lua/config/keymaps.lua` - Keymaps third
4. `lua/config/autocmds.lua` - Autocommands fourth

### Step 3: Create LSP Config Files
1. `lua/config/lsp/keymaps.lua` - LSP keymaps
2. `lua/config/lsp/servers.lua` - Server configs
3. `lua/config/lsp/init.lua` - LSP setup (requires keymaps.lua)

### Step 4: Create Plugin Files (Order Doesn't Matter)
1. `lua/plugins/ui.lua`
2. `lua/plugins/editor.lua`
3. `lua/plugins/lsp.lua`
4. `lua/plugins/completion.lua`
5. `lua/plugins/telescope.lua`
6. `lua/plugins/git.lua`
7. `lua/plugins/files.lua`
8. `lua/plugins/formatting.lua`
9. `lua/plugins/diagnostics.lua`
10. `lua/plugins/ai.lua`
11. `lua/plugins/lang/typescript.lua`
12. `lua/plugins/lang/php.lua`
13. `lua/plugins/lang/web.lua`

### Step 5: Update Entry Point
1. Replace `init.lua` with new minimal version

### Step 6: Archive Old Files
```bash
mkdir -p .archive
mv lua/plugins.lua .archive/
mv lua/lsp-config.lua .archive/
mv lua/treesitter-config.lua .archive/
mv lua/completions-config.lua .archive/
mv lua/telescope-config.lua .archive/
mv lua/conform-config.lua .archive/
mv lua/diagflow-config.lua .archive/
```

### Step 7: Test Migration
1. Open Neovim: `nvim`
2. Check for errors: `:checkhealth lazy`
3. Verify plugins loaded: `:Lazy`
4. Test LSP: Open a code file, check `gd`, `K`, etc.
5. Test Telescope: `<leader>t`
6. Test formatting: `<leader>f`
7. Test Git: `<leader>vs`

### Step 8: Verify Feature Parity
- [ ] All plugins load without errors
- [ ] LSP servers attach (check with `:LspInfo`)
- [ ] Completion works in insert mode
- [ ] Telescope fuzzy finder works
- [ ] Git commands work
- [ ] NERDTree opens and navigates
- [ ] Formatting on save works
- [ ] Treesitter highlights code
- [ ] Copilot suggestions appear
- [ ] All keymaps respond correctly

### Step 9: Commit Migration
```bash
git add -A
git commit -m "Refactor: Modernize config to modular lazy.nvim structure

- Split monolithic files into focused modules
- Organize plugins by category (ui, editor, lsp, etc.)
- Separate LSP config into dedicated directory
- Follow community best practices (LazyVim pattern)
- Improve maintainability and scalability

All functionality preserved, zero breaking changes."
```

---

## Rollback Plan

If anything goes wrong during migration:

### Quick Rollback (Restore from .archive)
```bash
cd ~/.config/nvim
rm -rf lua/config lua/plugins
mv .archive/plugins.lua lua/
mv .archive/lsp-config.lua lua/
mv .archive/treesitter-config.lua lua/
mv .archive/completions-config.lua lua/
mv .archive/telescope-config.lua lua/
mv .archive/conform-config.lua lua/
mv .archive/diagflow-config.lua lua/
git checkout init.lua
```

### Full Rollback (Git)
```bash
git reset --hard HEAD~1  # If you committed
# OR
git checkout pre-migration-backup  # Use backup branch
```

---

## File Size Comparison

### Before Migration
```
init.lua                 : 300 lines (mixed concerns)
lua/plugins.lua          : 400 lines (all plugins)
lua/lsp-config.lua       : 164 lines (LSP setup + servers)
lua/treesitter-config.lua: 25 lines
lua/completions-config.lua: 50 lines
lua/telescope-config.lua : 80 lines
lua/conform-config.lua   : 30 lines
lua/diagflow-config.lua  : 10 lines
────────────────────────────────────
TOTAL: 1,059 lines in 8 files
```

### After Migration
```
init.lua                          : 10 lines (entry point)
lua/config/lazy.lua               : 25 lines
lua/config/options.lua            : 60 lines
lua/config/keymaps.lua            : 40 lines
lua/config/autocmds.lua           : 25 lines
lua/config/lsp/init.lua           : 60 lines
lua/config/lsp/servers.lua        : 90 lines
lua/config/lsp/keymaps.lua        : 30 lines
lua/plugins/ui.lua                : 60 lines
lua/plugins/editor.lua            : 70 lines
lua/plugins/lsp.lua               : 40 lines
lua/plugins/completion.lua        : 80 lines
lua/plugins/telescope.lua         : 90 lines
lua/plugins/git.lua               : 35 lines
lua/plugins/files.lua             : 50 lines
lua/plugins/formatting.lua        : 35 lines
lua/plugins/diagnostics.lua       : 25 lines
lua/plugins/ai.lua                : 40 lines
lua/plugins/lang/typescript.lua   : 20 lines
lua/plugins/lang/php.lua          : 35 lines
lua/plugins/lang/web.lua          : 15 lines
────────────────────────────────────
TOTAL: 935 lines in 21 files
```

**Line Count:** -124 lines (11.7% reduction through deduplication)
**File Count:** +13 files (better organization)
**Average File Size:** 45 lines (vs 132 lines before)

---

## Expected Outcomes

### Immediate Benefits
1. **Faster Navigation**: Know exactly where any setting lives
2. **Easier Plugin Management**: Add/remove plugins by editing one file
3. **Better Git Diffs**: Changes are isolated to relevant files
4. **Clearer Purpose**: Each file has one responsibility

### Long-term Benefits
1. **Scalability**: Add 100 more plugins without file bloat
2. **Collaboration**: Others can understand your config instantly
3. **Debugging**: Issues isolated to specific modules
4. **Updates**: Modify plugin configs without touching others
5. **Portability**: Share specific configs (e.g., just LSP setup)

### No Breaking Changes
- All keymaps stay identical
- All plugins stay identical
- All LSP servers stay identical
- All settings stay identical
- Only organization changes

---

## Troubleshooting Guide

### Issue: Neovim won't start after migration
**Solution:**
```lua
-- Check init.lua for syntax errors
nvim --headless +checkhealth +qall

-- Check lazy.nvim loaded
nvim --headless +"lua print(vim.inspect(require('lazy')))" +qall
```

### Issue: Plugins don't load
**Cause:** Lazy.nvim not finding plugin specs
**Solution:** Verify `lua/plugins/` directory exists and contains .lua files

### Issue: LSP servers don't attach
**Cause:** Server config not loaded
**Solution:** Check `:LspInfo` and verify `lua/config/lsp/servers.lua` is sourced

### Issue: Keymaps don't work
**Cause:** Keymap file not loaded or plugin not loaded yet
**Solution:** Ensure plugins load before keymaps are set

### Issue: Options not applied
**Cause:** Options file not sourced
**Solution:** Verify `require('config.options')` in init.lua

---

## Post-Migration Tasks

### Recommended Next Steps
1. Add more granular plugin files (e.g., split `lang/web.lua` further)
2. Document custom keymaps in each plugin file
3. Add per-project `.nvim.lua` for project-specific settings
4. Set up plugin auto-update workflow
5. Create custom snippets in dedicated directory

### Optional Enhancements
1. Add `lua/config/performance.lua` for startup optimizations
2. Create `lua/plugins/dap.lua` for debugging setup
3. Add `lua/plugins/testing.lua` for test runners
4. Split LSP servers into individual files in `lua/config/lsp/servers/`

---

## Migration Metrics

### Time Estimate
- Manual migration: 2-3 hours
- Automated migration: 30-45 minutes
- Testing & verification: 15 minutes

### Risk Assessment
- **Data Loss Risk:** None (everything is in git)
- **Breaking Change Risk:** None (all functionality preserved)
- **Rollback Complexity:** Low (simple git reset or .archive restore)

### Success Criteria
- [ ] Neovim starts without errors
- [ ] All plugins load (`:Lazy` shows all plugins)
- [ ] LSP works (`:LspInfo` shows attached servers)
- [ ] Keymaps work (test common ones)
- [ ] Completion works (test in insert mode)
- [ ] Formatting works (`<leader>f`)
- [ ] No regression in functionality

---

## Conclusion

This migration transforms your Neovim config from a functional but monolithic structure into a modern, maintainable, and scalable architecture. The modular approach aligns with community standards, making future updates and additions significantly easier.

**Total Migration Time:** ~45 minutes
**Benefit Duration:** Lifetime of config
**Risk Level:** Low
**Reversibility:** High

**Recommendation:** Proceed with migration. The long-term benefits far outweigh the short-term investment.

---

## Quick Reference: New File Locations

| What You Want | Old Location | New Location |
|---------------|--------------|--------------|
| Vim options | `init.lua:102-128` | `lua/config/options.lua` |
| General keymaps | `init.lua:44-80` | `lua/config/keymaps.lua` |
| LSP keymaps | `lsp-config.lua:50-82` | `lua/config/lsp/keymaps.lua` |
| LSP servers | `lsp-config.lua:85-164` | `lua/config/lsp/servers.lua` |
| Plugin list | `lua/plugins.lua` | `lua/plugins/*.lua` |
| Telescope config | `lua/telescope-config.lua` | `lua/plugins/telescope.lua` |
| Completion config | `lua/completions-config.lua` | `lua/plugins/completion.lua` |
| Treesitter config | `lua/treesitter-config.lua` | `lua/plugins/editor.lua` |
| Formatting config | `lua/conform-config.lua` | `lua/plugins/formatting.lua` |
| Autocommands | `init.lua:130-145` | `lua/config/autocmds.lua` |
| Lazy.nvim setup | `init.lua:1-38` | `lua/config/lazy.lua` |

---

**Next Step:** Execute migration or request specific file previews.
