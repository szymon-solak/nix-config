vim.lsp.enable('rust_analyzer')
vim.lsp.enable('biome')
vim.lsp.enable('gopls')

vim.lsp.config('tinymist', {
	cmd = { 'tinymist' },
	filetypes = { 'typst' },
})
vim.lsp.enable('tinymist')

vim.lsp.enable('harper_ls')

vim.lsp.config('luals', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				}
			}
		}
	}
})
vim.lsp.enable('luals')

local elixir_ls_path = vim.env.ELIXIR_LS_PATH

if elixir_ls_path ~= nil then
	vim.lsp.config('elixirls', {
		cmd = { elixir_ls_path }
	})
	vim.lsp.enable('elixirls')
end

local nil_ls_path = vim.env.NIL_LS_PATH

if nil_ls_path ~= nil then
	vim.lsp.config('nil_ls', {
		cmd = { nil_ls_path }
	})
	vim.lsp.enable('nil_ls')
end

vim.lsp.config('ts_ls', {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = 'relative'
		}
	},
})
vim.lsp.enable('ts_ls')

vim.lsp.config('eslint', {
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
vim.lsp.enable('eslint')

vim.lsp.config('jsonls', {
	settings = {
		json = {
			validate = { enable = true },
		}
	}
})
vim.lsp.enable('jsonls')

-- Formatters
local conform = require('conform')

local js_formatters = { "prettierd", "prettier", "eslint_d", "biome", stop_after_first = true }

conform.setup({
	formatters_by_ft = {
		javascript = js_formatters,
		typescript = js_formatters,
		javascriptreact = js_formatters,
		typescriptreact = js_formatters,
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		elixir = { "mix" },
	},
})
