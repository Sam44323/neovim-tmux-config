# neovim-tmux-config

Personal Neovim (AstroNvim v6) and tmux configuration.

# Neovim-Plugins

| Plugin | Use |
|---|---|
| [AstroNvim](https://github.com/AstroNvim/AstroNvim) | Framework: editor options, buffer nav, window management, LSP, UI |
| [astrocore](https://github.com/AstroNvim/astrocore) | Core vim options (tabs=2, relativenumber, scrolloff=8, clipboard, splits, search) |
| [astrolsp](https://github.com/AstroNvim/astrolsp) | LSP config: format-on-save, codelens, semantic tokens, inlay hints |
| [astroui](https://github.com/AstroNvim/astroui) | UI: astrodark theme, custom cursor/visual/illuminated highlights, spinner icons |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder: `<C-p>` files, `<C-f>` live grep, `<leader>fg` grep, `<leader>fb` buffers, `<leader>fh` help |
| [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | FZF sorting for Telescope |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless vim/tmux pane nav with `Ctrl+h/j/k/l` |
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | AI inline autocomplete, accept with `<C-l>` |
| [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) | AI assistant: `<leader>oa` ask, `<leader>os` select, `go`/`goo` operators |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git: `<leader>gs` status, `<leader>gd` 3-way diff |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs: `]c`/`[c` hunk nav, `<leader>ghs` stage, `<leader>ghr` reset, `<leader>ghp` preview, `<leader>ghb` blame |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust IDE with codelldb DAP, auto-format on save |
| [move.vim](https://github.com/yanganto/move.vim) | Move (Sui) syntax highlighting + `move-analyzer` LSP |
| [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) | Smooth scrolling (`<C-u/d/b/f/y/e>`, `zt/zz/zb`) with circular easing |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol base |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | Debugger UI |
| [resession.nvim](https://github.com/stevearc/resession.nvim) | Session management: `:SessionSave`, `:SessionRestore`, `:SessionDelete` |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multi-cursor editing |

### Additional (in `user.lua`, disabled by default)

- **snacks.nvim** — dashboard with ASCII art header
- **nvim-autopairs** — auto-pairing with custom `$` rules for tex/latex
- **todo-comments.nvim** — highlight TODO/FIXME comments
- **LuaSnip** — snippet engine with filetype extends
- **better-escape.nvim** (disabled) — `jk`/`jj` to escape

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

Mouse enabled, base indexing starts at 1, splits/new windows open in current pane's working directory.

# Enabler

Sync with `:Lazy sync` on addition of the plugins for `neovim` and `<C-b> Shift + I` for tmux for the installation of the plugins

# Caveats

With restore system of tmux using `tmux-continuum` and `tmux-resurrect`, post system re-start you might not be able to see the list of active sessions using `tmux ls`. For that very reason, start an empty session, which pushes resurrect to re-sync with the plugins configs and once you `detach` from that session, doing `tmux ls` would show all the past-sessions

# Config

PWD for neovim and tmux are as such:

Neovim: `~/.config/nvim`
Tmux: `~/.tmux/` (you could have your configs in `~/.config/.tmux`, but I prefer a cleaned dir. for `tmux`

# License

Unlicense (public domain).
