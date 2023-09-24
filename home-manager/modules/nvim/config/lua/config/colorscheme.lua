local theme = {}

theme.should_use_light_mode = tonumber(os.date("%H")) < 16

if theme.should_use_light_mode then
	vim.cmd("set background=light")
else
	vim.cmd("set background=dark")
end

vim.cmd("colorscheme catppuccin")

return theme
