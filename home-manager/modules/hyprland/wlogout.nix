{
  programs.wlogout = {
    enable = true;

    layout = [
      {
        "label" = "lock";
        "action" = "hyprlock || loginctl lock-session";
        "text" = " Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "systemctl hibernate || loginctl hibernate";
        "text" = " Hibernate";
        "keybind" = "h";
      }
      {
        "label" = "logout";
        "action" = "pkill Hyprland || loginctl terminate-user $USER";
        "text" = " Logout";
        "keybind" = "e";
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff || loginctl poweroff";
        "text" = " Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend || loginctl suspend";
        "text" = " Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot || loginctl reboot";
        "text" = " Reboot";
        "keybind" = "r";
      }
    ];

    style = ./wlogout.css;
  };
}
