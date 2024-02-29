local theme = {}

vim.cmd("colorscheme catppuccin")

local timer = vim.loop.new_timer()

timer:start(0, 60000, vim.schedule_wrap(function ()
	local should_use_light_mode = tonumber(os.date("%H")) < 13

	if should_use_light_mode then
		vim.cmd("set background=light")
	else
		vim.cmd("set background=dark")
	end
end))

return theme
