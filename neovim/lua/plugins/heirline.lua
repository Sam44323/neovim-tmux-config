return {
	"rebelot/heirline.nvim",
	opts = function(_, opts)
		local status = require("astroui.status")

		local user_input_component = status.component.builder({
			-- condition: Only show the component if the text is NOT empty
			condition = function()
				return vim.g.my_status_text and vim.g.my_status_text ~= ""
			end,
			{
				-- provider: Dynamically fetch the text from the global variable
				provider = function()
					return " 📌 " .. vim.g.my_status_text .. " "
				end,
			},
			hl = { fg = "#1e1e2e", bg = "#89b4fa", bold = true },
		})

		-- Add it to the statusline
		table.insert(opts.statusline, user_input_component)

		return opts
	end,
}
