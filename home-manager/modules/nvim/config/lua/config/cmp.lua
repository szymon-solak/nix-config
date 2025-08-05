local blink = require("blink.cmp")
require("blink-cmp-avante")

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
		default = { 'copilot', 'avante', 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			avante = {
				module = 'blink-cmp-avante',
				name = 'avante',
				opts = {},
			},
			copilot = {
				name = 'copilot',
				module = 'blink-copilot',
				score_offset = 100,
				async = true,
			}
		},
	},
	signature = { enabled = true },
})
