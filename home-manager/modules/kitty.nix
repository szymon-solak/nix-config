{ pkgs, ... }:
let fonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
in {
  home.packages = [ pkgs.kitty-themes fonts ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Term";
      font_size = 16;
      cursor_shape = "underline";
      enabled_layouts = "tall";
    };

    extraConfig =
      "	map kitty_mod+enter launch --cwd=current\n	map kitty_mod+t     new_tab_with_cwd\n\n	# TODO: Doesn't work on 23.05\n	include ${pkgs.kitty-themes}/themes/rose-pine-moon.conf\n";
  };
}
