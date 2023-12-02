{ pkgs, lib, ... }:

let
  fromGitHub = repo: ref: rev:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
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
      lualine-nvim
      nvim-web-devicons
      which-key-nvim
      editorconfig-nvim
      nvim-tree-lua
      vim-sandwich
      leap-nvim
      vim-repeat
      tabby-nvim

      # telescope
      telescope-nvim
      telescope-ui-select-nvim
      telescope-undo-nvim
      telescope-fzf-native-nvim

      # theme
      # nightfox-nvim
      catppuccin-nvim

      # completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-vsnip
      vim-vsnip

      # lsp
      lsp-zero-nvim
      nvim-lspconfig
      lspkind-nvim
      trouble-nvim
      nvim-lint
      (fromGitHub "stevearc/conform.nvim" "master"
        "4db76a68b47aa6e9777e4da4aed16f0fff74920e")

      # treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

      # git
      gitsigns-nvim
      vim-fugitive
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
