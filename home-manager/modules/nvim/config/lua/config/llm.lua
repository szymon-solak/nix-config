local status_ok, avante = pcall(require, "avante")
if not status_ok then
	return
end

if vim.fn.executable('node') == 1 then
	require("copilot").setup({})

	local creds = require("copilot.auth").get_creds()

	if creds then
			avante.setup {
				provider = "copilot",
				auto_suggestions_provider = "copilot",

				providers = {
					ollama = {
						endpoint = "http://localhost:11434",
						model = "qwen3:8b",
						timeout = 15000,
						disable_tools = true,
					}
				},

				behaviour = {
					auto_suggestions = true,
					use_cwd_as_project_root = true,
				},
			}
		end
end
