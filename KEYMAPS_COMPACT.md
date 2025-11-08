# Neovim Keymaps Quick Reference

**Leader Key:** `,` (comma) | **Updated:** 2025-11-08 | **Config:** `~/.config/nvim`

---

## Essential Commands

| Category | Keymap | Action | Category | Keymap | Action |
|----------|--------|--------|----------|--------|--------|
| **Editor** | `,l` | Save file | **LSP Nav** | `gd` | Go to definition |
| | `,f` | Format code | | `gD` | Go to declaration |
| **File Tree** | `,n` | Toggle Neo-tree | | `gi` | Go to implementation |
| | `,F` | Reveal file | | `gr` | Find references |
| | `,e` | Focus tree | | `K` | Hover docs |
| **Telescope** | `,t` | Find files | | `<C-k>` | Signature help |
| | `,g` | Live grep | | `1gD` | Type definition |
| | `,o` | Search buffer | **LSP Edit** | `,rn` | Rename symbol |
| | `;` | Buffers | | `,ac` | Code actions |
| | `,j` | Find (word) | **Diagnostics** | `[d` | Previous diagnostic |
| | `,k` | Grep (word) | | `]d` | Next diagnostic |
| **Git** | `,vs` | Status | | `,dd` | Diagnostic list |
| | `,vc` | Commit | **AI** | `<C-,>` | Claude Code |
| | `,vp` | Push | | `Tab` | Copilot (insert) |
| | `,vl` | Pull | **Comment** | `,c<space>` | Toggle comment |
| | `,vb` | Blame |
| | `,vd` | Diff split |

---

## Neo-tree Commands (when focused)

| Navigation | | File Ops | | Window | | Search/Git | |
|------------|---|----------|---|--------|---|------------|---|
| `<CR>` | Open file | `a` | Add file | `s` | V-split | `/` | Fuzzy find |
| `<Space>` | Toggle node | `A` | Add dir | `S` | H-split | `H` | Toggle hidden |
| `<BS>` | Parent dir | `d` | Delete | `t` | New tab | `[g` | Prev git change |
| `.` | Set root | `r` | Rename | `P` | Preview | `]g` | Next git change |
| `R` | Refresh | `y` | Copy | `q` | Close | `</>` | Switch source |
| `?` | Help | `p` | Paste | `z/Z` | Close/Expand all |

---

## Tree-sitter Text Objects

**Usage:** `<operator><text-object>` (e.g., `daf` = delete entire function, `vif` = select function body)

| Around | Inside | Description | Around | Inside | Description |
|--------|--------|-------------|--------|--------|-------------|
| `af` | `if` | Function | `ac` | `ic` | Class |
| `al` | `il` | Loop | `ai` | `ii` | Conditional |
| `aa` | `ia` | Parameter/Argument |

**Navigation:** `]f`/`[f` (next/prev function start) · `]F`/`[F` (function end) · `]c`/`[c` (class start) · `]C`/`[C` (class end)

**Incremental Selection:** `gnn` (init) → `grn` (expand node) → `grc` (expand scope) → `grm` (shrink)

---

## Completion (nvim-cmp) - Insert Mode

| Key | Action | Key | Action | Key | Action |
|-----|--------|-----|--------|-----|--------|
| `<C-b>` | Scroll docs up | `<C-f>` | Scroll docs down | `<C-o>` | Manual trigger |
| `<C-e>` | Abort | `<CR>` | Confirm | `<Tab>` / `<S-Tab>` | Next/Prev item |

---

## Telescope Picker Controls

| Key | Action | Key | Action |
|-----|--------|-----|--------|
| `<C-n>` / `<C-p>` | History next/prev | `<C-d>` | Delete buffer |

---

## Essential Vim Motions

| Movement | | Editing | | Visual/Search | |
|----------|---|---------|---|---------------|---|
| `h/j/k/l` | ←↓↑→ | `i/a` | Insert before/after | `v/V` | Visual/Line |
| `w/b/e` | Word fwd/back/end | `I/A` | Line start/end insert | `<C-v>` | Visual block |
| `0/^/$` | Line start/first/end | `o/O` | New line below/above | `/` / `?` | Search fwd/back |
| `gg/G` | File start/end | `dd/yy/p` | Delete/Yank/Paste line | `n/N` | Next/Prev match |
| `{/}` | Para prev/next | `u/<C-r>` | Undo/Redo | `*/#` | Search word fwd/back |
| `%` | Match bracket | `.` | Repeat change | `>>` / `<<` | Indent/Unindent |
| `<C-d>/<C-u>` | Scroll half page | `<C-o>/<C-i>` | Jump back/fwd |

---

## Window & Tab Management

| Windows | | Tabs | |
|---------|---|------|---|
| `<C-w>s` | Split horizontal | `:tabnew` | New tab |
| `<C-w>v` | Split vertical | `gt/gT` | Next/Prev tab |
| `<C-w>c` | Close window | `<num>gt` | Go to tab # |
| `<C-w>h/j/k/l` | Navigate windows | `:tabclose` | Close tab |
| `<C-w>=` | Equalize sizes |

---

## Marks

| Key | Action | Key | Action |
|-----|--------|-----|--------|
| `ma` | Set mark 'a' | `` `a `` | Jump to mark 'a' |
| `'a` | Jump to line of mark 'a' | `:marks` | List marks |

---

## Quick Command Reference

```
WORKFLOW                    NAVIGATION                 CODE EDITING
,l → ,f     Save & format   gd         Goto def        ,rn      Rename
,t          Find files      K          Docs            ,ac      Actions
,g          Search code     gr         References      ,f       Format
,n          Toggle tree     [d / ]d    Diagnostics     ,c<sp>   Comment
,vs → ,vc   Git status/commit

TEXT OBJECTS                SELECTION                   SPLIT/SEARCH
vaf         Select function gnn → grn  Smart select    <C-w>v   V-split
dif         Delete fn body  grm        Shrink          /        Search
vac         Select class    grc        Scope           *        Search word
```

---

**Config Files:** `lua/config/keymaps.lua` · `lua/config/lsp/keymaps.lua` · `lua/plugins/*.lua`
