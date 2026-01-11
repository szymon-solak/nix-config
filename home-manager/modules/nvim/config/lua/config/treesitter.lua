local treesitter = require("nvim-treesitter")

treesitter.setup {
	ensure_installed = {},
	sync_install = false,
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
	},
	indent = { enable = true, disable = { "yaml" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-Space>",
			node_incremental = "<C-Space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	}
}

vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'html',
		'javascript',
		'javascriptreact',
		'typescript',
		'typescriptreact',
		'markdown',
		'yaml',
		'python',
		'lua',
		'go',
		'rust',
		'sql',
		'typst',
		'nix',
	},
	callback = function() vim.treesitter.start() end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
