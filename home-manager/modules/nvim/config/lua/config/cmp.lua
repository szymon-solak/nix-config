local cmp_status_ok, blink = pcall(require, "blink.cmp")
if not cmp_status_ok then
	return
end

blink.setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = 'mono'
	},
	sources = {
		default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
		providers = {
			avante = {
				module = 'blink-cmp-avante',
				name = 'avante',
				opts = {},
			},
		},
	},
	signature = { enabled = true },
})
