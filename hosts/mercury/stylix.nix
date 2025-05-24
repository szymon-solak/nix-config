{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.darwinModules.stylix];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    image = ./wallpaper.jpg;

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.nerd-fonts.iosevka;
        name = "Iosevka Nerd Font";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
        popups = 14;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.98;
      desktop = 0.98;
      popups = 1.0;
    };
  };
}
