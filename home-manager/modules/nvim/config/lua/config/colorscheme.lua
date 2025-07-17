local theme = {}

require('catppuccin').setup({
	transparent_background = true,
})

vim.cmd("colorscheme catppuccin")

-- local timer = vim.loop.new_timer()

vim.cmd("set background=dark")

-- timer:start(0, 60000, vim.schedule_wrap(function ()
-- 	local current_time = tonumber(os.date("%H"))
-- 	local should_use_light_mode = current_time > 7 and current_time < 13
--
-- 	if should_use_light_mode then
-- 		vim.cmd("set background=light")
-- 	else
-- 		vim.cmd("set background=dark")
-- 	end
-- end))

return theme
