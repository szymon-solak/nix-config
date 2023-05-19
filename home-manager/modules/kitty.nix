{ pkgs, ... }: {
  home.packages = [ pkgs.kitty-themes ];

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
