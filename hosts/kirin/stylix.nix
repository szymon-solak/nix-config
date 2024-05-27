{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
		base16Scheme = {
			base00 = "303446";
			base01 = "292c3c";
			base02 = "414559";
			base03 = "51576d";
			base04 = "626880";
			base05 = "c6d0f5";
			base06 = "f2d5cf";
			base07 = "babbf1";
			base08 = "e78284";
			base09 = "ef9f76";
			base0A = "e5c890";
			base0B = "a6d189";
			base0C = "81c8be";
			base0D = "8caaee";
			base0E = "ca9ee6";
			base0F = "eebebe";
		};
    image = ./wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Moderna-Ice";
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
        name = "Iosevka NFM";
      };

      sansSerif = {
        package = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
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
      terminal = 0.8;
      desktop = 0.8;
      popups = 1.0;
    };
  };
}
