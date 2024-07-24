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

    style = ''
           * {
        	all: unset;
        	background-image: none;
        	transition: 200ms cubic-bezier(0.05, 0.7, 0.1, 1);
           }

           window {
        	background: rgba(0, 0, 0, 0.5);
           }

           button {
        	font-family: "Iosevka NFM";
        	font-size: 4rem;
        	background-color: rgba(11, 11, 11, 0.4);
        	color: #FFFFFF;
      margin-bottom: 1rem;
           }

       button > * {
      	 margin-bottom: 2.5rem;
       }

       button:first-child {
      border-radius: 2rem 2rem 0 0;
      	}

      	button:last-child {
      border-radius: 0 0 2rem 2rem ;
      		}

           button:focus,
           button:active,
           button:hover {
        	background-color: rgba(51, 51, 51, 0.5);
           }
    '';
  };
}
