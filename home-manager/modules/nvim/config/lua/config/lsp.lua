-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup_servers({
	'tsserver',
	'lua_ls',
	'rust_analyzer',
	'nil_ls',
	'elixirls',
	'eslint',
})


require('lspconfig').lua_ls.setup({})

local elixir_ls_path = vim.env.ELIXIR_LS_PATH
require('lspconfig').elixirls.setup({
	cmd = { elixir_ls_path }
})

local nil_ls_path = vim.env.NIL_LS_PATH
require('lspconfig').nil_ls.setup({
	cmd = { nil_ls_path }
})

lsp.setup()

-- Linters
local lint = require('lint')

lint.linters_by_ft = {
	bash = { "shellcheck" },
	json = { "jsonlint" },
	elixir = { "credo" },
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
		elixir = { "mix" },
	},
})
