{ pkgs, lib, ... }: 

let
	fromGitHub = repo: ref: rev: pkgs.vimUtils.buildVimPluginFrom2Nix {
	  pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
	};
in {
	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;

		plugins = with pkgs.vimPlugins; [
			# base
			popup-nvim
			plenary-nvim

			# general use
			nvim-autopairs
			comment-nvim
			zen-mode-nvim
			lualine-nvim
			nvim-web-devicons
			which-key-nvim
			editorconfig-nvim
			nvim-tree-lua
			vim-sandwich
			leap-nvim
			vim-repeat
			vim-bufferline # TODO: Maybe switch to https://github.com/nanozuki/tabby.nvim

			# telescope
			telescope-nvim
			telescope-ui-select-nvim
			(fromGitHub "debugloop/telescope-undo.nvim" "main" "231b5ebb4328d2768c830c9a8d1b9c696116848d")

			# theme
			nightfox-nvim

			# completion
			cmp-nvim-lsp
			cmp-buffer
			cmp-path
			cmp-cmdline
			nvim-cmp
			cmp-vsnip
			vim-vsnip

			# lsp
			nvim-lspconfig
			lspkind-nvim
			null-ls-nvim
			trouble-nvim
			nvim-dap
			(fromGitHub "VonHeikemen/lsp-zero.nvim" "v2.x" "12bcd4a43e46ac64c30644dc86142a21a84d357a")

			# treesitter
			nvim-treesitter.withAllGrammars
			nvim-treesitter-context

			# git
			gitsigns-nvim
			vim-fugitive
		];

		extraPackages = [
			pkgs.delta # better diffs for telescope-undo

			# TODO: Can we have those in lang specific shells?
			# TODO: Lua LSP for neovim config
			pkgs.nodePackages.jsonlint
			pkgs.nodePackages.typescript-language-server
			pkgs.nodePackages.eslint
			pkgs.nodePackages.vscode-langservers-extracted
		];
	};

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
