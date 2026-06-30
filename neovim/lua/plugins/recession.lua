return {
  "stevearc/resession.nvim",

  event = "BufReadPre",

  opts = {},

  config = function(_, opts)
    local resession = require "resession"

    resession.setup(opts)

    vim.api.nvim_create_user_command("SessionSave", function()
      resession.save()
    end, {})

    vim.api.nvim_create_user_command("SessionRestore", function()
      resession.load()
    end, {})

    vim.api.nvim_create_user_command("SessionDelete", function()
      resession.delete()
    end, {})
  end,
}
