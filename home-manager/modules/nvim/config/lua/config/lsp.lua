-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup_servers({
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
	'rnix',
})

require('lspconfig').lua_ls.setup({})

lsp.setup()

-- Format/Lint
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.eslint,
		formatting.rustfmt,
		diagnostics.eslint,
		diagnostics.tsc,
		diagnostics.jsonlint,
		diagnostics.shellcheck,
	},
})
