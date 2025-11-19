local blink = require("blink.cmp")

blink.setup({
	keymap = {
		preset = "default",
		["<Tab>"] = {
			"snippet_forward",
			function()
				return require("sidekick").nes_jump_or_apply()
			end,
			-- function()
			-- 	return vim.lsp.inline_completion.get()
			-- end,
			"fallback",
		},
	},
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = {
		menu = {
			border = "single",
		},
		documentation = {
			auto_show = true,
			window = {
				border = "single",
			},
		},
	},
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	signature = { enabled = true },
})
