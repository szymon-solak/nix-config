local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
	return
end

local theme = {}

theme.should_use_light_mode = tonumber(os.date("%H")) < 16

if theme.should_use_light_mode then
	vim.cmd("set background=light")
else
	vim.cmd("set background=dark")
end

nightfox.setup {}

vim.cmd("colorscheme nightfox")

return theme
