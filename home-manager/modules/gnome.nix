{ pkgs, ... }: {
  home.packages = [
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.pop-launcher-super-key
    pkgs.gnome.gnome-tweaks
    pkgs.lato
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Compact-Pink";
      package = pkgs.catppuccin-gtk.override {
        size = "compact";
        tweaks = [ "rimless" ];
        # TODO: Revisit after update
        # accents = [ "pink" ];
        # variant = "frappe";
      };
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors.frappeLavender;
      name = "Catppuccin-Frappe-Lavender-Cursors";
    };
    font = {
      name = "Lato";
      size = 12;
    };
  };
}
