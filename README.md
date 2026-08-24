# neovim-tmux-config

Personal Neovim (AstroNvim v6) and tmux configuration.

# Neovim-Plugins

| Plugin | Use |
|---|---|
| [AstroNvim](https://github.com/AstroNvim/AstroNvim) | Framework: editor options, buffer nav, window management, LSP, UI |
| [astrocore](https://github.com/AstroNvim/astrocore) | Core vim options (tabs=2, relativenumber, scrolloff=8, clipboard, splits, search) |
| [astrolsp](https://github.com/AstroNvim/astrolsp) | LSP config: format-on-save, codelens, semantic tokens, inlay hints |
| [astroui](https://github.com/AstroNvim/astroui) | UI: astrodark theme, custom cursor/visual/illuminated highlights, spinner icons |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Renders `markdown` (titles, code blocks, tables, lists, checkboxes); `ft = markdown`, `opts = {}`, depends on nvim-treesitter + nvim-web-devicons |
| [heirline.nvim](https://github.com/rebelot/heirline.nvim) | Statusline: workspace status component (pinned 📌 text). Shortcuts: `<leader>xs` set (`SetWorkspaceText`), `<leader>xc` clear (`ClearWorkspaceText`) — persisted to `.workspace_status.txt` (auto-added to project `.gitignore`), defined in `polish.lua` |
| `polish.lua` | Workspace reminder popup: per-cwd reminder shown on `VimEnter`/`DirChanged` (15s toast, title `📌 Workspace Reminder`), persisted to `~/.local/share/nvim/workspace_reminders.json`; `<leader>xr` set (`:SetWorkspaceReminder`), `<leader>xd` clear (`:ClearWorkspaceReminder`) |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP tool manager; install servers: lua_ls, ts_ls, rust_analyzer, solidity_ls_nomicfoundation, pyright (via [mason-org/mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim)) |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder: `<C-p>` files, `<C-f>` live grep, `<leader>fg` grep, `<leader>fb` buffers, `<leader>fh` help |
| [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorting for Telescope |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless vim/tmux pane nav with `Ctrl+h/j/k/l` |
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI inline autocomplete, accept with `<C-l>` |
| [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) | AI assistant: `<leader>oa` ask, `<leader>os` select, `go`/`goo` operators |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git: `<leader>gs` status, `<leader>gd` 3-way diff, `<leader>gch` choose current (left), `<leader>gcl` choose incoming (right) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs: `]c`/`[c` hunk nav, `<leader>ghs` stage, `<leader>ghr` reset, `<leader>ghp` preview, `<leader>ghb` blame |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust IDE with codelldb DAP, auto-format on save |
| [move.vim](https://github.com/yanganto/move.vim) | Move (Sui) syntax highlighting + `move-analyzer` LSP |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling (`<C-u/d/b/f/y/e>`, `zt/zz/zb`) with circular easing |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol base |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debugger UI |
| [resession.nvim](https://github.com/stevearc/resession.nvim) | Session management: `:SessionSave`, `:SessionRestore`, `:SessionDelete` |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multi-cursor editing |

### Additional (disabled by default)

The following live in `lua/plugins/` but are `disabled` (each file starts with `if true then return {} end` — remove the guard to activate):

- **`plugins/user.lua`** — snacks.nvim dashboard (ASCII art header), nvim-autopairs (custom `$` rules for tex/latex), todo-comments.nvim, LuaSnip (filetype extends), better-escape.nvim (`jk`/`jj`)
- **`plugins/treesitter.lua`** — Treesitter highlight/indent config; overrides `ensure_installed` (AstroNvim bundles nvim-treesitter)
- **`plugins/none-ls.lua`** — none-ls.nvim formatting & diagnostics sources (commented out)

> Note: `neovim/mason.lua` (top level) is a standalone Mason spec ensuring lua_ls, ts_ls, rust_analyzer, `solidity_ls_nomicfoundation`, and pyright. It is not imported via `plugins/` by `lazy_setup.lua`, so confirm it is wired in before relying on it.

# Tmux-Plugins (via TPM)

| Plugin | Use |
|---|---|
| [tpm](https://github.com/tmux-plugins/tpm) | Plugin manager |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sensible defaults |
| [catppuccin-tmux](https://github.com/dreamsofcode-io/catppuccin-tmux) | Catppuccin theme |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Clipboard yanking |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save/restore tmux environment |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save every 10min, restore on-start |

# Settings

Mouse enabled, base indexing starts at 1, splits/new windows open in current pane's active-directory.

# Enabler

Sync with `:Lazy sync` on addition of the plugins for `neovim` and `<C-b> Shift + I` for tmux for the installation of the plugins

# Caveats

With restore system of tmux using `tmux-continuum` and `tmux-resurrect`, post system re-start you might not be able to see the list of active sessions using `tmux ls`. For that very reason, start an empty session, which pushes resurrect to re-sync with the plugins configs and once you `detach` from that session, doing `tmux ls` would show all the past-sessions

# Config

PWD for neovim and tmux are as such:

Neovim: `~/.config/nvim` <br/>
Tmux: `~/.tmux/` (you could have your configs in `~/.config/.tmux`, but I prefer a cleaned dir. for `tmux`)

# License

Unlicense
