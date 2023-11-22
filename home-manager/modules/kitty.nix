{ pkgs, ... }:
let fonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
in {
  home.packages = [ pkgs.kitty-themes fonts ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Iosevka NFM";
      font_size = 14;
      cursor_shape = "underline";
      enabled_layouts = "tall";
      macos_option_as_alt = "yes";
      allow_remote_control = "yes";
      modify_font = "cell_height 125%";
      hide_window_decorations = "yes";
      window_margin_width = 4;
    };

    theme = "Catppuccin-Latte";

    extraConfig =
      "	# map kitty_mod+enter launch --cwd=current\n	map kitty_mod+t     new_tab_with_cwd\n";
  };

  programs.zsh.initExtra =
    "	set_theme () {\n		kitty @ set-colors --all ${pkgs.kitty-themes}/share/kitty-themes/themes/\"$1\".conf;\n	}\n\n	set_theme_based_on_time () {\n		local switch_to_dark_after_hour='13'\n		local current_hour=$(date +\"%H\")\n\n		if [ $current_hour -lt $switch_to_dark_after_hour ]; then\n			set_theme Catppuccin-Latte;\n		else\n			set_theme Catppuccin-Mocha;\n		fi\n	}\n\n	[[ -v KITTY_WINDOW_ID ]] && set_theme_based_on_time\n";
}
