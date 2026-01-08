{pkgs, ...}: {
  home.packages = [
    pkgs.eza
    pkgs.bat
    pkgs.ripgrep
    pkgs.fd
    pkgs.editorconfig-core-c
    pkgs.ffmpeg
    pkgs.unzip
    pkgs.fzf
    pkgs.fx
    pkgs.jq
    pkgs.zenith
    pkgs.lazygit
    pkgs.nmap
    pkgs.dig
    pkgs.harper
  ];

  fonts.fontconfig.enable = true;
}
