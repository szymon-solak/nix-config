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
      blink-cmp
      blink-cmp-avante
      avante-nvim
      copilot-lua
      blink-copilot

      # lsp
      nvim-lspconfig
      trouble-nvim
      tiny-inline-diagnostic-nvim
      nvim-lint
      conform-nvim

      # treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context

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

  # home.file.".config/nvim" = {
  #    source = ./config;
  #    recursive = true;
  # };
}
