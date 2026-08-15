-- if true then return end -- remove this

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

-- 1. Initialize text when Neovim starts
vim.g.my_status_text = load_status_text()

-- Automatically swap text if you change directories inside Neovim
vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		vim.g.my_status_text = load_status_text()
		vim.cmd.redrawstatus()
	end,
})

-- 2. Create the User Commands
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

-- 3. Keyboard Shortcuts using <leader>x
-- Name the group in which-key so <leader>x shows up cleanly
local wk_status_ok, wk = pcall(require, "which-key")
if wk_status_ok then
	wk.add({
		{ "<leader>x", group = "Workspace Status" },
	})
end

vim.keymap.set("n", "<leader>xs", "<cmd>SetWorkspaceText<cr>", { desc = "Set Workspace Text" })
vim.keymap.set("n", "<leader>xc", "<cmd>ClearWorkspaceText<cr>", { desc = "Clear Workspace Text" })
