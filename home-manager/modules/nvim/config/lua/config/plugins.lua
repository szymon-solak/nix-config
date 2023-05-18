local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	-- base
	use "wbthomason/packer.nvim"
	use "nvim-lua/popup.nvim"
	use "nvim-lua/plenary.nvim"

	-- general
	use "windwp/nvim-autopairs"
	use "numToStr/Comment.nvim"
	use "folke/zen-mode.nvim"
	use "akinsho/toggleterm.nvim"
	use "nvim-lualine/lualine.nvim"
	use "goolord/alpha-nvim"
	use "kyazdani42/nvim-web-devicons"
	use "folke/which-key.nvim"
	use "editorconfig/editorconfig-vim"
	use "kyazdani42/nvim-tree.lua"
	use "machakann/vim-sandwich"
	use {
		"ggandor/leap.nvim",
		requires = {{ "tpope/vim-repeat" }},
		config = function ()
			require('leap').set_default_keymaps()
		end
	}

	-- theme
	use "folke/tokyonight.nvim"
	use "catppuccin/nvim"

	-- completion
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/cmp-path"
	use "hrsh7th/cmp-cmdline"
	use "hrsh7th/nvim-cmp"
	use "hrsh7th/cmp-vsnip"
	use "hrsh7th/vim-vsnip"
	use "hrsh7th/cmp-nvim-lsp-signature-help"

	-- lsp
	use "neovim/nvim-lspconfig"
	use "onsails/lspkind.nvim"
	use "jose-elias-alvarez/null-ls.nvim"
	use "folke/trouble.nvim"
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	}
	use 'mfussenegger/nvim-dap'

	-- telescope
	use "nvim-telescope/telescope.nvim"
	use "nvim-telescope/telescope-media-files.nvim"
	use "nvim-telescope/telescope-file-browser.nvim"
	use "nvim-telescope/telescope-project.nvim"
	use "akinsho/bufferline.nvim"

	-- treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use 'nvim-treesitter/nvim-treesitter-context'

	-- git
	use "lewis6991/gitsigns.nvim"
	use "tpope/vim-fugitive"

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		packer.sync()
	end
end)
