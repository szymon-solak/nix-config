local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require "telescope.actions"

telescope.setup {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		layout_strategy = 'horizontal',
		layout_config = { width = 0.85 },
	},
	pickers = {},
	extensions = {},
}

telescope.load_extension('ui-select')
telescope.load_extension('undo')
