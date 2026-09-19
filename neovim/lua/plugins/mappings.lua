return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      vim.api.nvim_create_user_command("CopyBufferList", function()
        local buffers = vim.api.nvim_list_bufs()
        local paths = {}
        for _, buf in ipairs(buffers) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= "" then table.insert(paths, name) end
          end
        end
        local result = table.concat(paths, "\n")
        vim.fn.setreg("+", result)
        vim.notify("Copied " .. #paths .. " open buffer paths to clipboard!")
      end, {})

      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        n = {
          ["<leader>gs"] = { "<cmd>Git<CR>", desc = "Git Status (Fugitive)" },
          ["<leader>gd"] = { "<cmd>Gvdiffsplit!<CR>", desc = "Git Merge Conflict Diff (3-way)" },
          ["<leader>gch"] = { "<cmd>diffget //2<CR>", desc = "Choose Target/Current (Left)" },
          ["<leader>gcl"] = { "<cmd>diffget //3<CR>", desc = "Choose Incoming/Merge (Right)" },
          ["<leader>xb"] = { "<cmd>CopyBufferList<cr>", desc = "Copy open buffer list to clipboard" },
        },
      })
    end,
  },
}
