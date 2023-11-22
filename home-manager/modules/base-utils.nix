{ pkgs, ... }: {
  home.packages = [
    pkgs.exa
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd
    pkgs.editorconfig-core-c
    pkgs.ffmpeg
    pkgs.unzip
    pkgs.fzf
    pkgs.fx
    pkgs.jq
  ];

  fonts.fontconfig.enable = true;
}
