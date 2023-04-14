{ pkgs, ... }: {
  home.packages = [ pkgs.kitty pkgs.kitty-themes ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka Term";
      # font_family = "VictorMono Nerd Font";
      font_size = 16;
      cursor_shape = "underline";
    };
    # theme = "Catppuccin-Frappe";
    # theme = "Nightfox";
  };
}
