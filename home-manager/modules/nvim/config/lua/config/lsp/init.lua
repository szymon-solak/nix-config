vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

require("config.lsp.mason")
require("config.lsp.null-ls")
require("config.lsp.handlers")
require("config.lsp.dap")
