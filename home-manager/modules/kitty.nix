{ pkgs, ... }: 
let
	fonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
in {
  home.packages =
    [ pkgs.kitty-themes fonts ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Term";
      font_size = 16;
      cursor_shape = "underline";
    };

    extraConfig = "include ${pkgs.kitty-themes}/themes/rose-pine-moon.conf";
  };
}
