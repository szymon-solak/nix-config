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

	require("which-key").add({
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Toggle Sidekick",
			nowait = true,
			remap = false
		},
		{
			"<leader>at",
			function() require("sidekick.cli").send({ msg = "{this}" }) end,
			desc = "Send this",
			mode = { "x", "n" },
			nowait = true,
			remap = false
		},
		{
			"<leader>av",
			function() require("sidekick.cli").send({ msg = "{selection}" }) end,
			desc = "Send selection",
			mode = { "x" },
			nowait = true,
			remap = false
		},
		{
			"<leader>ap",
			function() require("sidekick.cli").prompt() end,
			desc = "Send selection",
			mode = { "x", "n" },
			nowait = true,
			remap = false
		},
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			desc = "Send selection",
			nowait = true,
			remap = false,
		},
	})
end
