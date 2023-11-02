-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup_servers({
	'tsserver',
	'lua_ls',
	'rust_analyzer',
	'rnix',
})

require('lspconfig').lua_ls.setup({})

lsp.setup()

-- Linters
local lint = require('lint')

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	bash = { "shellcheck" },
	json = { "jsonlint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

-- Formatters
local conform = require('conform')

conform.setup({
	formatters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
	},
})
