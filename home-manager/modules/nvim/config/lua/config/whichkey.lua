local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

whichkey.setup {}

 whichkey.add({
	mode = { "n" },
	{ "<leader>b", group = "Buffers", nowait = true, remap = false },
	{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Switch to buffer", nowait = true, remap = false },
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
	{ "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
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
	{ "<leader>of", "<cmd>NvimTreeFindFile<cr>", desc = "Find current file", nowait = true, remap = false },
	{ "<leader>op", "<cmd>NvimTreeToggle<cr>", desc = "Browse Files", nowait = true, remap = false },
	{ "<leader>p", group = "Project", nowait = true, remap = false },
	{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find File", nowait = true, remap = false },
	{ "<leader>q", "<cmd>q!<cr>", desc = "Quit", nowait = true, remap = false },
	{ "<leader>s", group = "Search", nowait = true, remap = false },
	{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
	{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
	{ "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
	{ "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
	{ "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
	{ "<leader>sf", "<cmd>Telescope resume<cr>", desc = "Resume last search", nowait = true, remap = false },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
	{ "<leader>sp", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text", nowait = true, remap = false },
	{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{ "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find Text in current buffer", nowait = true, remap = false },
	{ "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo", nowait = true, remap = false },
	{ "<leader>sw", "<cmd>Telescope grep_string theme=ivy<cr>", desc = "Search for word under cursor", nowait = true, remap = false },
	{ "<leader>t", group = "Tabs", nowait = true, remap = false },
	{ "<leader>t[", "<cmd>-tabmove<cr>", desc = "Move current tab left", nowait = true, remap = false },
	{ "<leader>t]", "<cmd>+tabmove<cr>", desc = "Move current tab right", nowait = true, remap = false },
	{ "<leader>tc", "<cmd>tabclose<cr>", desc = "Close current tab", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>$tabnew<cr>", desc = "New tab", nowait = true, remap = false },
	{ "<leader>w", "<cmd>w!<cr>", desc = "Save", nowait = true, remap = false },

	{ "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover details", nowait = true, remap = false },
	{ "[d", "<cmd>lua vim.diagnostic.goto_prev<cr>", desc = "Go to prev diagnostic", nowait = true, remap = false },
	{ "[q", "<cmd>cprev<cr>", desc = "Go to prev quickfix", nowait = true, remap = false },
	{ "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Go to next diagnostic", nowait = true, remap = false },
	{ "]q", "<cmd>cnext<cr>", desc = "Go to next quickfix", nowait = true, remap = false },
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go to declaration", nowait = true, remap = false },
	{ "gd", "<cmd>Telescope lsp_definitions jump_type=vsplit<cr>", desc = "Go to definition", nowait = true, remap = false },
	{ "gi", "<cmd>Telescope lsp_implementations jump_type=vsplit<cr>", desc = "Go to implementation", nowait = true, remap = false },
	{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to references", nowait = true, remap = false },

	{ "<leader>a", group = "Copilot", nowait = true, remap = false },
	-- { "<leader>ap", "<cmd>Copilot panel<cr>", desc = "Open Copilot panel", nowait = true, remap = false },
	{ "<leader>a]", "<cmd>Copilot panel next<cr>", desc = "Next suggestion", nowait = true, remap = false },
	{ "<leader>a[", "<cmd>Copilot panel prev<cr>", desc = "Previous suggestion", nowait = true, remap = false },
	{ "<leader>a<cr>", "<cmd>Copilot panel accept<cr>", desc = "Accept suggestion", nowait = true, remap = false },
	{ "<leader>as", "<cmd>Sidekick cli toggle<cr>", desc = "Toggle Sidekick", nowait = true, remap = false },
	{ "<leader>an", "<cmd>Sidekick nes toggle<cr>", desc = "Toggle NES", nowait = true, remap = false },
	{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, desc = "Send this", nowait = true, remap = false },
	{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, desc = "Send selection", nowait = true, remap = false },
	{ "<leader>ap", function() require("sidekick.cli").prompt() end, desc = "Send selection", nowait = true, remap = false },
	{
		"<tab>",
		function()
			-- if there is a next edit, jump to it, otherwise apply it if any
			if not require("sidekick").nes_jump_or_apply() then
				return "<Tab>" -- fallback to normal tab
			end
		end,
		desc = "Send selection",
		nowait = true,
		remap = false,
	},
})


