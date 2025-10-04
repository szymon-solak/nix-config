local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "default" },
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
