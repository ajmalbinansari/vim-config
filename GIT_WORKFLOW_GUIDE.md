# Git Workflow Guide - Neovim Configuration

This guide covers your complete Git workflow setup with LazyGit, Gitsigns, and Diffview.

## 📦 Installed Plugins

| Plugin | Purpose | Load Strategy |
|--------|---------|---------------|
| **lazygit.nvim** | Terminal UI for Git operations | Lazy loaded on command/keymap |
| **gitsigns.nvim** | Visual diff indicators & hunk operations | Loaded on buffer open |
| **diffview.nvim** | Advanced diff viewing & merge conflicts | Lazy loaded on command/keymap |

## ⌨️ Complete Keymap Reference

> **Note:** Your leader key is `,` (comma)

### 🎯 Primary Git Operations (`<leader>v` prefix)

| Keymap | Command | Description |
|--------|---------|-------------|
| `,vg` | LazyGit | Open LazyGit (primary Git UI) |
| `,vs` | LazyGit | Git status (same as ,vg) |
| `,vf` | LazyGitCurrentFile | Open LazyGit for current file |
| `,vb` | Toggle blame | Toggle inline Git blame |
| `,vd` | DiffviewOpen | Open diff view |
| `,vc` | DiffviewClose | Close diff view |
| `,vh` | DiffviewFileHistory % | File history (current file) |
| `,vH` | DiffviewFileHistory | File history (all files) |
| `,vr` | DiffviewRefresh | Refresh diff view |
| `,vt` | DiffviewToggleFiles | Toggle diff files panel |

### 🔧 Hunk Operations (`<leader>h` prefix)

| Keymap | Mode | Command | Description |
|--------|------|---------|-------------|
| `,hs` | Normal | Stage hunk | Stage the current hunk under cursor |
| `,hs` | Visual | Stage hunk | Stage selected lines |
| `,hr` | Normal | Reset hunk | Discard changes in current hunk |
| `,hr` | Visual | Reset hunk | Discard changes in selected lines |
| `,hS` | Normal | Stage buffer | Stage all changes in current file |
| `,hR` | Normal | Reset buffer | Discard all changes in current file |
| `,hu` | Normal | Undo stage | Undo last hunk staging |
| `,hp` | Normal | Preview hunk | Show hunk diff in floating window |
| `,hb` | Normal | Blame line | Show full blame for current line |
| `,hd` | Normal | Diff this | Open diff for current file |
| `,hD` | Normal | Diff this ~ | Open diff against HEAD~ |

### 🧭 Navigation

| Keymap | Command | Description |
|--------|---------|-------------|
| `]c` | Next hunk | Jump to next Git hunk |
| `[c` | Previous hunk | Jump to previous Git hunk |
| `ih` | Text object | Select current hunk (use with operators) |

### 📊 Visual Indicators

#### Sign Column Icons
- `│` - Added line
- `│` - Changed line
- `_` - Deleted line
- `~` - Changed and deleted
- `┆` - Untracked file

#### Inline Blame
Shows at the end of the current line after 1 second:
```
Author Name, 2025-01-08 - Commit message summary
```

## 🚀 Common Workflows

### 1. Quick Status Check & Commit
```
,vg          → Open LazyGit
[Use LazyGit UI to stage, commit, push]
q            → Close LazyGit
```

### 2. Review Changes Before Staging
```
]c           → Jump to next change
,hp          → Preview hunk in floating window
,hs          → Stage the hunk
,vd          → Open full diff view
,vc          → Close diff view
```

### 3. Stage Specific Lines
```
V            → Enter visual mode
[Select lines]
,hs          → Stage selected lines
```

### 4. View File History
```
,vh          → View current file history
[In history view]
<CR>         → View selected commit
j/k          → Navigate commits
q            → Close history
```

### 5. Review Changes in Diff View
```
,vd          → Open diff view
<Tab>        → Next file
<S-Tab>      → Previous file
-            → Stage/unstage file
gf           → Go to file in buffer
,vc          → Close diff view
```

### 6. Merge Conflict Resolution
```
,vd          → Open diff view (auto-detects conflicts)
[x           → Jump to previous conflict
]x           → Jump to next conflict
,co          → Choose our changes
,ct          → Choose their changes
,cb          → Choose base
,ca          → Choose all (keep both)
dx           → Delete conflict markers
,vc          → Close when done
```

### 7. Blame Investigation
```
,vb          → Toggle inline blame
,hb          → Show full blame for line
,vh          → View file history
```

### 8. Undo Staging Mistakes
```
,hu          → Undo last hunk stage
,hR          → Reset entire buffer (unstage all)
```

## 🎨 Visual Features Enabled

### ✅ What You'll See
- **Sign column indicators** for all Git changes
- **Inline blame** showing author, date, and message
- **Floating windows** for hunk previews
- **Icons** in diff view (requires Nerd Font)
- **Syntax highlighting** in diffs
- **3-way merge** layout for conflicts

### ⚙️ Customization Options

#### Toggle Features with Commands
```vim
:Gitsigns toggle_signs           " Toggle sign column
:Gitsigns toggle_current_line_blame " Toggle inline blame
:Gitsigns toggle_word_diff      " Toggle word-level diff
```

#### Adjust Blame Delay
Edit `lua/plugins/git.lua` line 95:
```lua
delay = 1000,  -- Change to desired milliseconds
```

## 📝 LazyGit Tips

Inside LazyGit (opened with `,vg`):
- `Space` - Stage/unstage files
- `c` - Commit
- `P` - Push
- `p` - Pull
- `?` - Show help
- `x` - View menu options
- `/` - Search
- `q` - Quit

## 🔍 Diffview Tips

### Diff View Keybindings
- `<Tab>` / `<S-Tab>` - Navigate files
- `-` - Stage/unstage file
- `S` - Stage all
- `U` - Unstage all
- `R` - Refresh
- `i` - Toggle list/tree view
- `f` - Flatten directories
- `gf` - Go to file
- `g<C-x>` - Cycle layout (horizontal/vertical)

### File History Keybindings
- `<CR>` - Open commit
- `y` - Copy commit hash
- `L` - Open commit log
- `j/k` - Navigate
- `zR/zM` - Expand/collapse all folds

## 🛠️ Troubleshooting

### Inline Blame Not Showing
1. Ensure you're in a Git repository
2. Wait 1 second (default delay)
3. Check if blame is enabled: `:Gitsigns toggle_current_line_blame`

### Gitsigns Not Loading
- Open any Git-tracked file (loaded on `BufReadPost`)
- Check `:Lazy` to see if plugin loaded

### LazyGit Not Opening
1. Ensure LazyGit is installed: `brew install lazygit`
2. Check if it's in PATH: `which lazygit`

### Icons Not Showing
- Install a Nerd Font (e.g., `brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font`)
- Set terminal to use the Nerd Font

## 📚 Additional Resources

- [LazyGit Documentation](https://github.com/jesseduffield/lazygit)
- [Gitsigns Documentation](https://github.com/lewis6991/gitsigns.nvim)
- [Diffview Documentation](https://github.com/sindrets/diffview.nvim)

## ⚡ Performance Notes

- **LazyGit**: Lazy loaded (only when you use it)
- **Gitsigns**: Loaded on buffer open (minimal overhead)
- **Diffview**: Lazy loaded (only when you use it)
- **Max file length**: Gitsigns disabled for files >40,000 lines

## 🎯 Quick Reference Card

```
Essential Commands:
  ,vg  → Git UI (LazyGit)
  ,vd  → Diff view
  ,hp  → Preview hunk
  ,hs  → Stage hunk
  ]c   → Next change
  [c   → Previous change

File History:
  ,vh  → Current file
  ,vH  → All files

Conflict Resolution:
  ,vd  → Open (auto-detects)
  [x   → Prev conflict
  ]x   → Next conflict
  ,co  → Choose ours
  ,ct  → Choose theirs
```

---

**Configuration Location**: `~/.config/nvim/lua/plugins/git.lua`
**Leader Key**: `,` (comma)
**Last Updated**: 2025-01-08
