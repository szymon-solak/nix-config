require('catppuccin').setup({
	transparent_background = true,
	custom_highlights = function(colors)
		return {
			SnacksPicker = { bg = "none", nocombine = true },
			SnacksPickerBorder = { fg = colors.blue, bg = "none", nocombine = true },
		}
	end
})

vim.cmd("colorscheme catppuccin")
vim.cmd("set background=dark")
