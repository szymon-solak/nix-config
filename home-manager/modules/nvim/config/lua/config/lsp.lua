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

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

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

-- Dap
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not status_ok then
	return
end

dap_vscode_js.setup({
	debugger_path = os.getenv("VSCODE_JS_DEBUG_PATH"),
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
  require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require'dap.utils'.pick_process,
			cwd = "${workspaceFolder}",
		}
  }
end

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
