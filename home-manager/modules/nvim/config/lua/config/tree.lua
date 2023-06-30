local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvimtree.setup({
	sort_by = "case_sensitive",
	view = {
		width = 35,
		-- adaptive_size = true,
		side = "right",
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
				{ key = "l", action = "edit" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
})
