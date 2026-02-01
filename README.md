# NeovimConfig

A simple Neovim configuration using **lazy.nvim** for plugin management.  
Most settings live under `lua/`.

## Structure

- `init.lua`
  - Loads core settings (`lua/config`)
  - Bootstraps `lazy.nvim`
  - Loads all plugin specs from `lua/plugins`

- `lua/config/`
  - `options.lua`: Neovim options
  - `keymaps.lua`: global keymaps

- `lua/plugins/`
  - Plugin specs grouped by topic (editor / LSP / UI / markdown, etc.)

## Setup

1. Clone this repository into your Neovim config directory (e.g. `~/.config/nvim/`).
2. Start `nvim`.
   - `lazy.nvim` will be installed automatically (if missing)
   - plugins will be installed/updated automatically

## Keymaps (from `lua/config/keymaps.lua`)

### Basics
- `jk` (insert): exit insert mode
- `<leader>w`: save
- `<leader>q`: quit
- `<leader>Q`: quit all

### Window navigation / resize
- `<C-h/j/k/l>`: move between windows
- `<C-Up/Down>`: increase/decrease window height
- `<C-Left/Right>`: decrease/increase window width

### Move lines
- `<A-j>` / `<A-k>` (normal/visual): move line/selection down/up

### Search
- `<Esc>` (normal): clear search highlight

### LSP
- `gd`: go to definition
- `gD`: go to declaration
- `gi`: go to implementation
- `gy`: go to type definition
- `<leader>ca`: code action
- `<leader>cr`: rename
- `<leader>cd`: line diagnostics
- `[d` / `]d`: previous / next diagnostic

### UI toggles
- `<leader>un`: toggle line numbers
- `<leader>ur`: toggle relative numbers
- `<leader>uw`: toggle word wrap

## Plugins (from `lua/plugins/`)

### Editor / Navigation (`lua/plugins/editor.lua`)
- **neo-tree.nvim**: file explorer  
  - `<leader>e`: toggle explorer
- **fzf-lua**: fuzzy finder  
  - `<leader>ff`: find files
  - `<leader>fg`: live grep
  - `<leader>fb`: buffers
  - `<leader>fh`: help tags
  - `<leader>fr`: recent files
  - `<leader><leader>`: find files
- **gitsigns.nvim**: git signs + actions  
  - `<leader>gb`: blame line
  - `<leader>gd`: diff this
- **todo-comments.nvim**: TODO/FIXME highlights + list  
  - `<leader>xt`: todo list (via FzfLua)
- **trouble.nvim**: diagnostics list UI  
  - `<leader>xx`: toggle diagnostics
- **which-key.nvim**: keymap hint popup
- **nvim-surround** / **nvim-autopairs** / **Comment.nvim**: surround, auto pairs, commenting utilities

### LSP / Completion / Formatting (`lua/plugins/lsp.lua`)
- **mason.nvim** + **mason-lspconfig.nvim**: manage/install LSP servers
- **nvim-lspconfig**: LSP configuration (enables: `pyright`, `ruff`, `gopls`, `lua_ls`, `html`, `cssls`, `ts_ls`, `jsonls`)
- **nvim-cmp** (+ sources) + **LuaSnip** + **friendly-snippets**: completion/snippets  
  - `<C-Space>` completion, `<CR>` confirm, `<Tab>/<S-Tab>` select, etc.
- **conform.nvim**: formatting on save + manual format  
  - `<leader>cf`: format

### UI (`lua/plugins/ui.lua`)
- **dashboard-nvim**: start screen
- **lualine.nvim**: statusline (theme: kanagawa)
- **bufferline.nvim**: buffer tabs  
  - `<S-h>` / `<S-l>`: prev/next buffer
  - `<leader>bp`: pin buffer
  - `<leader>bd`: delete buffer
- **noice.nvim** (+ notify): improved command line / messages / LSP UI
- **indent-blankline.nvim (ibl)**: indentation guides

### Treesitter (`lua/plugins/treesitter.lua`)
- **nvim-treesitter**: syntax highlighting/indent (Lua/TS/Python/HTML/CSS/JSON/Go/Rust/Markdown, etc.)

### Markdown (`lua/plugins/markdown.lua`)
- **render-markdown.nvim**: improved Markdown rendering in Neovim

### Obsidian (`lua/plugins/obsidian.lua`)
- **obsidian.nvim**: Obsidian vault integration (with `fzf-lua` + `nvim-cmp`)
  - `<leader>on`: new note
  - `<leader>os`: search text
  - `<leader>ow`: switch workspace
  - `<leader>oq`: quick switch (find file)
  - `<leader>oD`: today’s note
  - `<leader>ot`: insert template
  - `<leader>ob`: backlinks
  - `<leader>oc`: `:tcd` to vault directory  
  - (inside Obsidian buffers)
    - `<leader>of`: follow link (`gf` passthrough)
    - `<leader>od`: toggle checkbox
    - `<CR>`: smart action

### Colorscheme (`lua/plugins/kanagawa.lua`)
- **kanagawa.nvim**: colorscheme (set as default)

Try it in Neovim:
```vim
:colorscheme kanagawa
```

## Notes
- Plugin versions are pinned in `lazy-lock.json`.
