local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

whichkey.setup {}

whichkey.add({
	mode = { "n" },
	{ "<leader>b", group = "Buffers", nowait = true, remap = false },
	{ "<leader>bc", "<cmd>Bdelete!<cr>", desc = "Close Buffer", nowait = true, remap = false },
	{
		"<leader>bs",
		function ()
			vim.cmd([[
				split
				noswapfile hide enew
				setlocal buftype=nofile
				setlocal bufhidden=hide
				file scratch
			]])
		end,
		desc = "Open Scratch Buffer",
		nowait = true,
		remap = false,
	},
	{ "<leader>l", group = "LSP", nowait = true, remap = false },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
	{ "<leader>ld", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", nowait = true, remap = false },
	{ "<leader>lD", "<cmd>Trouble diagnostics toggle<cr>", desc = "All Diagnostics", nowait = true, remap = false },
	{ "<leader>lf", "<cmd>lua require('conform').format({ lsp_fallback = true })<cr>", desc = "Format", nowait = true, remap = false },
	{ "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature help", nowait = true, remap = false },
	{ "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "Show diagnostics", nowait = true, remap = false },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
	{ "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Document Symbols", nowait = true, remap = false },
	{ "<leader>lw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
	{ "<leader>o", group = "Open", nowait = true, remap = false },
	{ "<leader>p", group = "Project", nowait = true, remap = false },
	{ "<leader>q", "<cmd>q!<cr>", desc = "Quit", nowait = true, remap = false },
	{ "<leader>t", group = "Tabs", nowait = true, remap = false },
	{ "<leader>t[", "<cmd>-tabmove<cr>", desc = "Move current tab left", nowait = true, remap = false },
	{ "<leader>t]", "<cmd>+tabmove<cr>", desc = "Move current tab right", nowait = true, remap = false },
	{ "<leader>tc", "<cmd>tabclose<cr>", desc = "Close current tab", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>$tabnew<cr>", desc = "New tab", nowait = true, remap = false },
	{ "<leader>w", "<cmd>w!<cr>", desc = "Save", nowait = true, remap = false },
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{ "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover details", nowait = true, remap = false },
	{ "[d", "<cmd>lua vim.diagnostic.goto_prev<cr>", desc = "Go to prev diagnostic", nowait = true, remap = false },
	{ "[q", "<cmd>cprev<cr>", desc = "Go to prev quickfix", nowait = true, remap = false },
	{ "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Go to next diagnostic", nowait = true, remap = false },
	{ "]q", "<cmd>cnext<cr>", desc = "Go to next quickfix", nowait = true, remap = false },
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to declaration", nowait = true, remap = false },
})


