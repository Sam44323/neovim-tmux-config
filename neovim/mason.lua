return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "rust_analyzer",
        "solidity_ls_nomicfoundation",
        "pyright",
      },
    },
  },
}
