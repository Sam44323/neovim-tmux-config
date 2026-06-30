-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",

  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",

    -- highlight overrides
    highlights = {
      init = {

        CursorLine = {
          bg = "#2a2a2a",
        },

        Cursor = {
          fg = "#000000",
          bg = "#ffcc00",
        },

        Visual = {
          bg = "#264f78",
        },

        IlluminatedWordText = {
          bg = "#ff5f87",
          fg = "#ffffff",
        },

        IlluminatedWordRead = {
          bg = "#ff5f87",
          fg = "#ffffff",
        },

        IlluminatedWordWrite = {
          bg = "#ff5f87",
          fg = "#ffffff",
    },
  },
},


    -- Icons can be configured throughout the interface
    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
