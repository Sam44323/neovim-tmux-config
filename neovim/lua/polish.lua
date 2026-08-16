-- This will run last in the setup process.

vim.opt.smoothscroll = true
vim.opt.scroll = 10
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
vim.opt.sidescrolloff = 8

vim.opt.lazyredraw = false
vim.opt.ttyfast = true

vim.opt.cursorline = false
vim.opt.relativenumber = false

-----------------------------------------------------------------------------
-- FEATURE 1: WORKSPACE STATUS TEXT (Local File)
-----------------------------------------------------------------------------
-- Define the local file name to store the text
local status_filename = ".workspace_status.txt"

-- Helper: Get the full path for the local status file
local function get_workspace_file()
	return vim.fn.getcwd() .. "/" .. status_filename
end

-- Helper: Check for .gitignore and append the status file if missing
local function ensure_gitignored()
	local gitignore_path = vim.fn.getcwd() .. "/.gitignore"

	-- Check if .gitignore exists in the current directory
	if vim.fn.filereadable(gitignore_path) == 1 then
		local lines = vim.fn.readfile(gitignore_path)
		local is_ignored = false

		-- Scan existing lines
		for _, line in ipairs(lines) do
			if line:match(status_filename) then
				is_ignored = true
				break
			end
		end

		-- Append to .gitignore if not found
		if not is_ignored then
			local file = io.open(gitignore_path, "a")
			if file then
				file:write("\n# AstroVim Workspace Status\n" .. status_filename .. "\n")
				file:close()
			end
		end
	end
end

-- Helper: Save text to the local file
local function save_status_text(text)
	local file = io.open(get_workspace_file(), "w")
	if file then
		file:write(text)
		file:close()
		ensure_gitignored() -- Run the gitignore check every time we save
	end
end

-- Helper: Load text from the local file
local function load_status_text()
	local file = io.open(get_workspace_file(), "r")
	if file then
		local text = file:read("*a")
		file:close()
		return text
	end
	return ""
end

-- Initialize text when Neovim starts
vim.g.my_status_text = load_status_text()

-- Automatically swap text if you change directories inside Neovim
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		vim.g.my_status_text = load_status_text()
		vim.cmd.redrawstatus()
	end,
})

-- Create the User Commands for Status Text
vim.api.nvim_create_user_command("SetWorkspaceText", function()
	vim.ui.input({ prompt = "Workspace Note: " }, function(input)
		if input ~= nil then
			vim.g.my_status_text = input
			save_status_text(input)
			vim.cmd.redrawstatus()
		end
	end)
end, { desc = "Set persistent workspace text" })

vim.api.nvim_create_user_command("ClearWorkspaceText", function()
	vim.g.my_status_text = ""
	save_status_text("")
	vim.cmd.redrawstatus()
end, { desc = "Clear persistent workspace text" })

-----------------------------------------------------------------------------
-- FEATURE 2: WORKSPACE REMINDER POPUP (Centralized File)
-----------------------------------------------------------------------------
local fn = vim.fn
local api = vim.api

-- Store reminders centrally so we don't dirty the git repositories
local reminder_data_file = fn.stdpath("data") .. "/workspace_reminders.json"

-- Helper to load reminders from disk
local function load_reminders()
	local f = io.open(reminder_data_file, "r")
	if not f then
		return {}
	end

	local content = f:read("*a")
	f:close()

	if content == "" then
		return {}
	end

	local ok, parsed = pcall(fn.json_decode, content)
	return (ok and type(parsed) == "table") and parsed or {}
end

-- Helper to save reminders to disk
local function save_reminders(data)
	local f = io.open(reminder_data_file, "w")
	if f then
		f:write(fn.json_encode(data))
		f:close()
	end
end

-- Command: Set a reminder popup for the current directory
api.nvim_create_user_command("SetWorkspaceReminder", function()
	vim.ui.input({ prompt = "Workspace Reminder: " }, function(input)
		if input ~= nil and input ~= "" then
			local reminders = load_reminders()
			local cwd = fn.getcwd()

			reminders[cwd] = input
			save_reminders(reminders)

			vim.notify("Reminder saved for this workspace.", vim.log.levels.INFO, { title = "Workspace Reminder" })
		end
	end)
end, { desc = "Set popup reminder for workspace" })

-- Command: Clear the reminder popup for the current directory
api.nvim_create_user_command("ClearWorkspaceReminder", function()
	local reminders = load_reminders()
	local cwd = fn.getcwd()

	if reminders[cwd] then
		reminders[cwd] = nil
		save_reminders(reminders)
		vim.notify("Reminder cleared.", vim.log.levels.INFO, { title = "Workspace Reminder" })
	else
		vim.notify("No reminder found for this workspace.", vim.log.levels.WARN, { title = "Workspace Reminder" })
	end
end, { desc = "Clear popup reminder for workspace" })

-- Autocommand: Trigger popup when opening a workspace
local reminder_group = api.nvim_create_augroup("WorkspaceRemindersGroup", { clear = true })
api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	group = reminder_group,
	callback = function()
		local reminders = load_reminders()
		local cwd = fn.getcwd()
		local msg = reminders[cwd]

		if msg then
			-- Defer slightly to ensure the UI is fully loaded before popping up
			vim.defer_fn(function()
				vim.notify(msg, vim.log.levels.WARN, {
					title = "📌 Workspace Reminder",
					timeout = 15000, -- Stays on screen for 15 seconds
				})
			end, 500)
		end
	end,
})

-----------------------------------------------------------------------------
-- KEYBINDINGS
-----------------------------------------------------------------------------
-- Name the group in which-key so <leader>x shows up cleanly
local wk_status_ok, wk = pcall(require, "which-key")
if wk_status_ok then
	wk.add({
		{ "<leader>x", group = "Workspace Notes/Reminders" },
	})
end

-- Feature 1: Status Text bindings
vim.keymap.set("n", "<leader>xs", "<cmd>SetWorkspaceText<cr>", { desc = "Set Workspace Text" })
vim.keymap.set("n", "<leader>xc", "<cmd>ClearWorkspaceText<cr>", { desc = "Clear Workspace Text" })

-- Feature 2: Reminder bindings
vim.keymap.set("n", "<leader>xr", "<cmd>SetWorkspaceReminder<cr>", { desc = "Add Workspace Reminder" })
vim.keymap.set("n", "<leader>xd", "<cmd>ClearWorkspaceReminder<cr>", { desc = "Clear Workspace Reminder" })

