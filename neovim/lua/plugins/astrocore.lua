-- AstroCore provides a central place to modify mappings,
-- vim options, autocommands, and more!

---@type LazySpec
return {
  "AstroNvim/astrocore",

  ---@type AstroCoreOpts
  opts = {

    -- Core AstroNvim features
    features = {
      large_buf = {
        size = 1024 * 256,
        lines = 10000,
      },

      autopairs = true,
      cmp = true,

      diagnostics = {
        virtual_text = true,
        virtual_lines = false,
      },

      highlighturl = true,
      notifications = true,
    },

    -- Diagnostics appearance
    diagnostics = {
      virtual_text = true,
      underline = true,
    },

    -- Filetype detection
    filetypes = {
      extension = {
        foo = "fooscript",
      },

      filename = {
        [".foorc"] = "fooscript",
      },

      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },

    -- Vim options
    options = {
      opt = {

        -- line numbers
        number = true,
        relativenumber = true,

        -- editor behavior
        wrap = false,
        spell = false,
        signcolumn = "yes",

        -- cursor line highlight
        cursorline = true,

        -- better splits
        splitbelow = true,
        splitright = true,

        -- tabs/spaces
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,

        -- searching
        ignorecase = true,
        smartcase = true,

        -- scrolling
        scrolloff = 8,
        sidescrolloff = 8,

        -- ui
        termguicolors = true,
        mouse = "a",

        -- clipboard
        clipboard = "unnamedplus",
      },

      g = {
        -- global variables here if needed
      },
    },

    -- Key mappings
    mappings = {
      n = {

        -- buffer navigation
        ["]b"] = {
          function()
            require("astrocore.buffer").nav(vim.v.count1)
          end,
          desc = "Next buffer",
        },

        ["[b"] = {
          function()
            require("astrocore.buffer").nav(-vim.v.count1)
          end,
          desc = "Previous buffer",
        },

        -- close buffer picker
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(function(bufnr)
              require("astrocore.buffer").close(bufnr)
            end)
          end,
          desc = "Close buffer from tabline",
        },

        -- close current split only
        ["<Leader>wc"] = {
          "<cmd>close<cr>",
          desc = "Close window",
        },

        -- equalize split sizes
        ["<Leader>we"] = {
          "<cmd>wincmd =<cr>",
          desc = "Equalize windows",
        },

        -- vertical split
        ["<Leader>wv"] = {
          "<cmd>vsplit<cr>",
          desc = "Vertical split",
        },

        -- horizontal split
        ["<Leader>wh"] = {
          "<cmd>split<cr>",
          desc = "Horizontal split",
        },
      },
    },
  },
}
