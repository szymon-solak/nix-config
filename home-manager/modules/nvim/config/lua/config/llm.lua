local status_ok, avante = pcall(require, "avante")
if not status_ok then
	return
end

avante.setup {
	provider = "ollama",
	mode = 'legacy',

	providers = {
		ollama = {
			endpoint = "http://localhost:11434",
			model = "qwen3:8b",
			timeout = 15000,
			disable_tools = true,
		}
	},

	behaviour = {
		auto_suggestions = false,
		use_cwd_as_project_root = true,
	},
}
