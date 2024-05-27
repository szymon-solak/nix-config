{pkgs, ...}: let
  fonts = pkgs.nerdfonts.override {fonts = ["Iosevka"];};
in {
  home.packages = [pkgs.kitty-themes fonts];

  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "underline";
      enabled_layouts = "tall";
      macos_option_as_alt = "yes";
      allow_remote_control = "yes";
      modify_font = "cell_height 125%";
      hide_window_decorations = "yes";
      window_margin_width = 4;
    };

    theme = "Catppuccin-Latte";

    extraConfig = ''
      map kitty_mod+enter launch --cwd=current
      map kitty_mod+t new_tab_with_cwd
    '';
  };

  programs.zsh.initExtra = ''
     set_theme () {
       kitty @ set-colors --all ${pkgs.kitty-themes}/share/kitty-themes/themes/"$1".conf;
     }

     set_theme_based_on_time () {
       local switch_to_dark_after_hour=13
       local switch_to_light_after_hour=7
       local current_hour=$(($(date +\"%-k\")))

       if [ $current_hour -lt $switch_to_dark_after_hour ] && [ $current_hour -gt $switch_to_light_after_hour ]; then
       	set_theme Catppuccin-Latte;
       else
       	set_theme Catppuccin-Mocha;
       fi
     }

    [[ -v KITTY_WINDOW_ID ]] && set_theme_based_on_time
  '';
}
