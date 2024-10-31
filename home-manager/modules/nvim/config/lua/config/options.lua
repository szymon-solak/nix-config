local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 500,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = false,
	-- shiftwidth = 2,
	-- tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	scrolloff = 8,
	sidescrolloff = 8,
	guifont = "monospace:h17",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]

-- vim.cmd [[set <M-e>=^[e]]

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Folds
function CountFoldLines()
  local text = vim.treesitter.foldtext()

  local n_lines = vim.v.foldend - vim.v.foldstart
  local text_lines = " lines"

  if n_lines == 1 then
    text_lines = " line"
  end

  table.insert(text, { " - " .. n_lines .. text_lines, { "Folded" }})

  return text
end

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 20
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
