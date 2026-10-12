return {
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {} } },
    },
    -- Remember the directory nvim was launched from (the project root).
    init = function() vim.g.opencode_root = vim.fn.getcwd() end,
    config = function()
      local function root() return vim.g.opencode_root or vim.fn.getcwd() end

      -- The plugin matches sessions by Neovim's cwd, so keep it equal to the
      -- directory OpenCode runs in, even if AstroNvim's rooter/autochdir moved it.
      local function pin_cwd()
        if vim.fn.getcwd() ~= root() then vim.cmd("lcd " .. vim.fn.fnameescape(root())) end
      end

      local oc_tab, prev_tab
      local function oc_tab_valid() return oc_tab and vim.api.nvim_tabpage_is_valid(oc_tab) end

      -- Open (or jump to) a tab running `opencode` in the project root.
      local function open_tab(focus)
        local prev = vim.api.nvim_get_current_tabpage()
        if oc_tab_valid() then
          if focus then
            vim.api.nvim_set_current_tabpage(oc_tab)
            vim.cmd.startinsert()
          end
          return
        end

        vim.cmd.tabnew()
        vim.cmd("tcd " .. vim.fn.fnameescape(root()))

        local job_opts = {
          cwd = root(),
          on_exit = function()
            vim.schedule(function()
              if oc_tab_valid() and #vim.api.nvim_list_tabpages() > 1 then
                vim.cmd("tabclose " .. vim.api.nvim_tabpage_get_number(oc_tab))
              end
              oc_tab = nil
            end)
          end,
        }
        if vim.fn.has "nvim-0.11" == 1 then
          job_opts.term = true
          vim.fn.jobstart({ "opencode" }, job_opts)
        else
          vim.fn.termopen({ "opencode" }, job_opts)
        end

        oc_tab = vim.api.nvim_get_current_tabpage()
        if focus then
          vim.cmd.startinsert()
        else
          vim.api.nvim_set_current_tabpage(prev)
        end
      end

      -- Switch between the OpenCode tab and the tab you came from.
      local function toggle_tab()
        local cur = vim.api.nvim_get_current_tabpage()
        if oc_tab_valid() and cur == oc_tab then
          if prev_tab and vim.api.nvim_tabpage_is_valid(prev_tab) then
            vim.api.nvim_set_current_tabpage(prev_tab)
          else
            vim.cmd.tabprevious()
          end
        else
          prev_tab = cur
          open_tab(true)
        end
      end

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          -- Called when no OpenCode is running: start one in a background tab.
          start = function() open_tab(false) end,
        },
      }

      vim.o.autoread = true

      local function oc(fn)
        return function()
          pin_cwd()
          fn()
        end
      end

      vim.keymap.set(
        { "n", "x" },
        "<leader>oa",
        oc(function() require("opencode").ask "@this: " end),
        { desc = "Ask opencode" }
      )
      vim.keymap.set(
        { "n", "x" },
        "<leader>ox",
        oc(function() require("opencode").select() end),
        { desc = "Opencode actions…" }
      )
      vim.keymap.set(
        { "n", "x" },
        "<leader>og",
        oc(function() require("opencode").prompt "@this" end),
        { desc = "Add to opencode" }
      )
      vim.keymap.set("n", "<leader>ot", toggle_tab, { desc = "Toggle opencode tab" })
      vim.keymap.set({ "n", "t" }, "<C-;>", toggle_tab, { desc = "Toggle opencode tab" })
    end,
  },
}
