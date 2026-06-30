return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- Git / Fugitive Status
          ["<leader>gs"] = { "<cmd>Git<CR>", desc = "Git Status (Fugitive)" },
          ["<leader>gd"] = { "<cmd>Gvdiffsplit!<CR>", desc = "Git Merge Conflict Diff (3-way)" },
          
          -- Direct Conflict Resolution Choices (Target vs Merge branch)
          -- "dh" -> diff obtain from Hunk/Left (Target/Current branch)
          -- "dl" -> diff obtain from List/Right (Merge/Incoming branch)
          ["<leader>gch"] = { "<cmd>diffget //2<CR>", desc = "Choose Target/Current (Left)" },
          ["<leader>gcl"] = { "<cmd>diffget //3<CR>", desc = "Choose Incoming/Merge (Right)" },
        },
      },
    },
  },
}
