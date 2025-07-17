local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local lsp_section = {
	function()
		local lsp_prefix = ' [LSP] '
		local buf_ft = vim.api.nvim_get_option_value('filetype', {})
		local clients = vim.lsp.get_clients()

		if next(clients) == nil then
			return ''
		end

		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return lsp_prefix .. client.name
			end
		end

		return ''
	end,
	color = { fg = '#ffffff', gui = 'bold' },
}

local config = {
	options = {
	 component_separators = '',
    section_separators = '',
	},
	sections = {
		lualine_c = {
			{ 'filetype', icon_only = true },
			'filename',
		},
		lualine_x = {
			lsp_section,
		},
	},
	inactive_sections = {
		lualine_a = { 'filename' },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { 'location' },
	},
}

lualine.setup(config)
