return {
  -- Syntax highlighting
  {
    "yanganto/move.vim",
    branch = "sui-move",
    ft = "move",
  },

  -- LSP (move-analyzer via Cargo, not Mason)
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = { "move_analyzer" },
      config = {
        move_analyzer = {
          cmd = { vim.fn.expand("~/.cargo/bin/move-analyzer") },
          filetypes = { "move" },
          root_dir = require("lspconfig.util").root_pattern("Move.toml", ".git"),
          single_file_support = true,
        },
      },
    },
  },
}
