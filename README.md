# neovim-tmux-config

Personal Neovim (AstroNvim v6) and tmux configuration.

## Neovim

- **Framework**: [AstroNvim v6](https://github.com/AstroNvim/AstroNvim) with lazy.nvim
- **AI**: [Supermaven](https://github.com/supermaven-inc/supermaven-nvim) (inline autocomplete) + [opencode.nvim](https://github.com/anomalyco/opencode) (chat/inline AI)
- **Rust**: rustaceanvim with codelldb DAP, auto-format on save
- **Move (Sui)**: syntax highlighting + `move-analyzer` LSP
- **Navigation**: vim-tmux-navigator (`Ctrl+h/j/k/l`), Telescope (`Ctrl+p` files, `Ctrl+f` grep)
- **Git**: fugitive (`<leader>gs` status, `<leader>gd` diff), gitsigns (inline blame, hunk nav)
- **Debugging**: nvim-dap + dap-ui
- **Session management**: resession.nvim
- **Theme**: astrodark colorscheme with custom highlights

## Tmux

- **Plugins** (via TPM): catppuccin theme, tmux-yank, tmux-resurrect, tmux-continuum (auto-save/restore)
- Indexing starts at 1, splits open in working directory, mouse enabled

## License

Unlicense (public domain).
