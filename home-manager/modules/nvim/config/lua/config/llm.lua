if vim.fn.executable('node') == 1 then
	require("copilot").setup({})

	local creds = require("copilot.auth").get_creds()

	if creds then
		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuOpen",
			callback = function()
				vim.b.copilot_suggestion_hidden = true
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuClose",
			callback = function()
				vim.b.copilot_suggestion_hidden = false
			end,
		})

		vim.lsp.enable('copilot')
	end

	local sidekick = require("sidekick")

	sidekick.setup()
end
