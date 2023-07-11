{ pkgs, ... }:
let fonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
in {
  home.packages = [ pkgs.kitty-themes fonts ];

  programs.kitty = {
    enable = true;
    settings = {
      # font_family = "Iosevka Term";
      font_size = 16;
      cursor_shape = "underline";
      enabled_layouts = "tall";
    };

		theme = "Nightfox";

    extraConfig =
      "	map kitty_mod+enter launch --cwd=current\n	map kitty_mod+t     new_tab_with_cwd";
  };
}
