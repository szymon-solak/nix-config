local Snacks = require("snacks");

Snacks.setup({
	bigfile = { enabled = true },
	input = { enabled = true },
	lazygit = { enabled = true },
	statuscolumn = { enabled = true },
	picker = {
		enabled = true,
		prompt = "❯ ",
		auto_close = true,
		sources = {
			explorer = {
				auto_close = true,
				layout = {
					preset = "default",
				}
			}
		}
	},
})

require("which-key").add({
	mode = { "n" },
	{
		"<leader>gg",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>op",
		function()
			Snacks.picker.explorer()
		end,
		desc = "Browse Files",
		nowait = true,
		remap = false
	},
	{
		"<leader>pf",
		function()
			Snacks.picker.files()
		end,
		desc = "Find File",
		nowait = true,
		remap = false
	},
	{
		"<leader>bb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Switch to buffer",
		nowait = true,
		remap = false
	},
	{
		"<leader>sf",
		function()
			Snacks.picker.resume()
		end,
		desc = "Resume last search",
		nowait = true,
		remap = false
	},
	{
		"<leader>sp",
		function()
			Snacks.picker.grep()
		end,
		desc = "Find Text",
		nowait = true,
		remap = false
	},
	{
		"<leader>sr",
		function()
			Snacks.picker.recent()
		end,
		desc = "Open Recent File",
		nowait = true,
		remap = false
	},
	{
		"<leader>ss",
		function()
			Snacks.picker.lines()
		end,
		desc = "Find Text in current buffer",
		nowait = true,
		remap = false
	},
	{
		"<leader>su",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo",
		nowait = true,
		remap = false
	},
	{
		"<leader>sw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Search for word under cursor",
		nowait = true,
		remap = false,
		mode = { "n", "x" },
	},
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Go to definition",
		nowait = true,
		remap = false
	},
	{
		"gi",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Go to implementation",
		nowait = true,
		remap = false
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		desc = "Go to references",
		nowait = true,
		remap = false
	},
})
