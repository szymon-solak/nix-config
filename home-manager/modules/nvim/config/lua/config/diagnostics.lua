local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = false,
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup {}

local status_ok, tiny_inline_diagnostic = pcall(require, "tiny-inline-diagnostic")
if not status_ok then
	return
end

tiny_inline_diagnostic.setup {
	preset = "simple"
}

local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

comment.setup {}
