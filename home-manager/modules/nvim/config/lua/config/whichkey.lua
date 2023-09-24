local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

whichkey.setup {}

local mappings = {
	w = { "<cmd>w!<cr>", "Save" },
	q = { "<cmd>q!<cr>", "Quit" },

	b = {
		name = "Buffers",
		b = { "<cmd>Telescope buffers<cr>", "Switch to buffer" },
		c = { "<cmd>Bdelete!<cr>", "Close Buffer" },
		s = { function ()
			vim.cmd([[
				split
				noswapfile hide enew
				setlocal buftype=nofile
				setlocal bufhidden=hide
				file scratch
			]])
		end, "Open Scratch Buffer" },
	},

	s = {
		name = "Search",
		p = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
		s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find Text in current buffer" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		f = { "<cmd>Telescope resume<cr>", "Resume last search" },
		u = { "<cmd>Telescope undo<cr>", "Undo" },
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		f = { "<cmd>lua vim.lsp.buf.format { async = true }<cr>", "Format" },
		F = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format", mode = "v" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature help" },

		d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics" },
		w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
	},

	o = {
		name = "Open",
		p = { "<cmd>NvimTreeToggle<cr>", "Browse Files" },
		f = { "<cmd>NvimTreeFindFile<cr>", "Find current file" }
	},

	p = {
		name = "Project",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
	},

	t = {
		name = "Tabs",
		t = { "<cmd>$tabnew<cr>", "New tab"  },
		c = { "<cmd>tabclose<cr>", "Close current tab" },
		["["] = { "<cmd>-tabmove<cr>", "Move current tab left" },
		["]"] = { "<cmd>+tabmove<cr>", "Move current tab right" },
	},
}

local no_prefix_mappings = {
	K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover details" },
	gD = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
	gd = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
	gi = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
}

whichkey.register(mappings, {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})

whichkey.register(no_prefix_mappings, {
	mode = "n",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = true,
})

