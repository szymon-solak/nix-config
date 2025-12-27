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

-- Linters
local lint = require('lint')

lint.linters_by_ft = {
	bash = { "shellcheck" },
	-- json = { "jsonlint" },
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
