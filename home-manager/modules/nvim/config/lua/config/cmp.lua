local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local lspkind_status_ok, lspkind = pcall(require, "lspkind")
if not lspkind_status_ok then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.select_prev_item(),
		['<C-j>'] = cmp.mapping.select_next_item(),
		['<C-b>'] = cmp.mapping.scroll_docs(-1),
		['<C-f>'] = cmp.mapping.scroll_docs(1),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp', priority = 4 },
		{ name = 'vsnip', priority = 3 },
		{ name = 'buffer', priority = 2 },
		{ name = 'path', priority = 1 },
	}),
	-- sorting = {
	-- 	priority_weight = 1.0,
	-- 	comparators = {
	-- 		cmp.config.compare.locality,
	-- 		cmp.config.compare.recently_used,
	-- 		cmp.config.compare.score,
	-- 		cmp.config.compare.offset,
	-- 		cmp.config.compare.order,
	-- 	},
	-- },
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 50
		})
	},
	experimental = {
		ghost_text = true
	},
})

