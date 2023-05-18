local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

bufferline.setup {
	options = {
		max_name_length = 30,
		max_prefix_length = 35,
		tab_size = 21,
		diagnostics = "nvim_lsp",
	}
}
