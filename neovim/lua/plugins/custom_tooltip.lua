return {
	{
		"AstroNvim/astrocore",
		---@param opts AstroCoreOpts
		opts = function(_, opts)
			-- 1. Store states based on the Current Working Directory (Workspace)
			local workspaces = {}

			local function get_workspace_state()
				local cwd = vim.fn.getcwd()
				-- Initialize the workspace state if it doesn't exist yet
				if not workspaces[cwd] then
					workspaces[cwd] = {
						buf = nil,
						win = nil,
						text = "Type <leader>xq to edit",
					}
				end
				return workspaces[cwd]
			end

			-- 2. Toggle Function (<leader>xt)
			local function toggle_tooltip()
				local state = get_workspace_state()

				-- If window exists and is valid, close it
				if state.win and vim.api.nvim_win_is_valid(state.win) then
					vim.api.nvim_win_close(state.win, true)
					state.win = nil
				else
					-- Create an unlisted scratch buffer if one doesn't exist
					if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
						state.buf = vim.api.nvim_create_buf(false, true)
					end

					-- Add padding to make it look like a nice notification
					local padded_text = "  " .. state.text .. "  "

					-- Calculate dynamic width and height (max width of 50 columns)
					local max_width = 50
					local width = math.min(#padded_text, max_width)
					local height = math.ceil(#padded_text / max_width)

					-- Set the buffer text
					vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, { padded_text })

					-- Calculate top-right position
					local col = vim.o.columns - width - 2
					local row = 1

					-- Open the floating window
					state.win = vim.api.nvim_open_win(state.buf, false, {
						relative = "editor",
						width = width,
						height = height,
						col = col,
						row = row,
						style = "minimal",
						border = "rounded",
						-- Format the title with an icon and blue Diagnostic color
						title = { { " 󰎞 Note ", "DiagnosticInfo" } },
						title_pos = "center",
						zindex = 150, -- Ensures it stays on top of other elements
					})

					-- Prettify: Link border to DiagnosticInfo (usually blue) and add transparency
					vim.api.nvim_set_option_value(
						"winhl",
						"Normal:NormalFloat,FloatBorder:DiagnosticInfo",
						{ win = state.win }
					)
					vim.api.nvim_set_option_value("winblend", 10, { win = state.win })
				end
			end

			-- 3. Edit Function (<leader>xq)
			local function edit_tooltip()
				local state = get_workspace_state()
				local workspace_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

				vim.ui.input(
					{ prompt = "Edit Note for [" .. workspace_name .. "]: ", default = state.text },
					function(input)
						if input then
							state.text = input
							-- If the tooltip is currently open, we close and reopen it so
							-- the dynamic width/height recalculates beautifully based on the new text length
							if state.win and vim.api.nvim_win_is_valid(state.win) then
								vim.api.nvim_win_close(state.win, true)
								state.win = nil
								toggle_tooltip()
							end
						end
					end
				)
			end

			-- 4. Inject keymaps into AstroCore
			if not opts.mappings then
				opts.mappings = {}
			end
			if not opts.mappings.n then
				opts.mappings.n = {}
			end

			opts.mappings.n["<Leader>x"] = { desc = "󰎞 Tooltip" }
			opts.mappings.n["<Leader>xt"] = { toggle_tooltip, desc = "Toggle Workspace Tooltip" }
			opts.mappings.n["<Leader>xq"] = { edit_tooltip, desc = "Edit Workspace Tooltip" }
		end,
	},
}
