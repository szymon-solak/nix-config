local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local status_ok, mason = pcall(require, 'mason')
if not status_ok then
	return
end

mason.setup {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	},
}

local status_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
	return
end

mason_lspconfig.setup()

mason_lspconfig.setup_handlers {
	function(server_name)
		local opts = {
			on_attach = require("config.lsp.handlers").on_attach,
			capabilities = require("config.lsp.handlers").capabilities,
		}

		local server_config_path = "config.lsp.settings." .. server_name

		local settings_exist, server_settings = pcall(require, server_config_path)

		if settings_exist then
			local old_on_attach = opts.on_attach

			opts = vim.tbl_deep_extend("force", server_settings, opts)

			opts.on_attach = function(client, bufnr)
				old_on_attach(client, bufnr)

				if type(server_settings.on_attach) == 'function' then
					server_settings.on_attach(client, bufnr)
				end
			end
		end

		lspconfig[server_name].setup(opts)
	end,
}

-- TODO: Mason installed lua_ls doesn't work on nix
local _, lua_settings = pcall(require, 'config.lsp.settings.lua_ls')
lspconfig['lua_ls'].setup(lua_settings)

-- TODO: Consider mason-tool-installer
