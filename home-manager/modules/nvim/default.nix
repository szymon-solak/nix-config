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
      blink-cmp
      copilot-lua
      sidekick-nvim
      # ((fromGitHub "folke/sidekick.nvim" "main" "0ab6a23b779e208c3733c48a380bf35e3ec1d49d").overrideAttrs {
      #   nvimSkipModules = ["sidekick.docs"];
      # })

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

  home.packages = [
    pkgs.nodejs_22 # Required for copilot
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
