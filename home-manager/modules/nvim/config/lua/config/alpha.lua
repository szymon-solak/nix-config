local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	"                                                       _...--.",
	"                                       _____......----'     .'",
	"                                 _..-''                   .'",
	"                               .'                       ./",
	"                       _.--._.'                       .' |",
	"                    .-'                           .-.'  /",
	"                  .'   _.-.                     .  \\   '",
	"                .'  .'   .'    _    .-.        / `./  :",
	"              .'  .'   .'  .--' `.  |  \\  |`. |     .'",
	"           _.'  .'   .' `.'       `-'   \\ / |.'   .'",
	"        _.'  .-'   .'     `-.            `      .'",
	"      .'   .'    .'          `-.._ _ _ _ .-.    :",
	"     /    /o _.-'               .--'   .'   \\   |",
	"   .'-.__..-'                  /..    .`    / .'",
	" .'   . '                       /.'/.'     /  |",
	"`---'                                   _.'   '",
	"                                      /.'    .'",
	"                                       /.'/.'",
}

dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", "<cmd>ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  > Projects", "<cmd>Telescope project<CR>"),
	dashboard.button("r", "  > Recent", "<cmd>Telescope oldfiles<CR>"),
	dashboard.button("s", "  > Settings", "<cmd>e $MYVIMRC<CR>"),
	dashboard.button("q", "  > Quit", "<cmd>qa<CR>"),
}

alpha.setup(dashboard.opts)
