{ pkgs, ... }: {
  home.packages = [
    pkgs.neovim
    pkgs.vimPlugins.packer-nvim # TODO: Maybe install plugins here
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
