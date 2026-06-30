{
  pkgs,
  lib,
  ...
}: let
  fromGitHub = repo: ref: rev:
    pkgs.vimUtils.buildVimPlugin {
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

    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      # base
      plenary-nvim

      # general use
      nvim-autopairs
      lualine-nvim
      nvim-web-devicons
      which-key-nvim
      editorconfig-nvim
      nvim-tree-lua
      tabby-nvim
      render-markdown-nvim
      snacks-nvim

      # theme
      # nightfox-nvim
      catppuccin-nvim

      # completion
      nvim-cmp
      blink-cmp
      # copilot-lua
      # sidekick-nvim

      # lsp
      nvim-lspconfig
      trouble-nvim
      tiny-inline-diagnostic-nvim
      conform-nvim

      # treesitter
      nvim-treesitter.withAllGrammars

      # git
      gitsigns-nvim
      vim-fugitive
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

  # home.file.".config/nvim" = {
  #    source = ./config;
  #    recursive = true;
  # };
}
