local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local lsp_section = {
	function()
	    local lsp_prefix = ' [LSP] '
	    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	    local clients = vim.lsp.get_active_clients()

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
		component_separators = { left = '', right = '' },
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
}

lualine.setup(config)
