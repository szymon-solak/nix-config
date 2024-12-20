-- LSP
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup_servers({
	'ts_ls',
	'lua_ls',
	'rust_analyzer',
	'nil_ls',
	'elixirls',
	'eslint',
	'biome',
	'ruff'
})

require('lspconfig').lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				}
			}
		}
	}
})

local elixir_ls_path = vim.env.ELIXIR_LS_PATH
require('lspconfig').elixirls.setup({
	cmd = { elixir_ls_path }
})

local nil_ls_path = vim.env.NIL_LS_PATH
require('lspconfig').nil_ls.setup({
	cmd = { nil_ls_path }
})

require('lspconfig').ts_ls.setup({
	init_options = {
		preferences = {
			importModuleSpecifierPreference = 'relative'
		}
	},
})

require('lspconfig').eslint.setup({
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'vue',
		'svelte',
		'astro',
		'graphql',
	}
})

lsp.setup()

-- Linters
local lint = require('lint')

lint.linters_by_ft = {
	bash = { "shellcheck" },
	json = { "jsonlint" },
	elixir = { "credo" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
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
		typescript = { "biome" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "biome" },
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		elixir = { "mix" },
	},
})
