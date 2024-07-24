{pkgs, ...}: {
  services.sketchybar = {
    enable = true;
    package = pkgs.sketchybar;
    config = ''
         SCRIPTS_DIR=${./scripts}

         source ${./bar.sh}
         source ${./defaults.sh}

         			# Left
         source ${./items/spaces.sh}
         source ${./items/separator.sh}
         source ${./items/front_app.sh}

         			# Right
         source ${./items/clock.sh}
         source ${./items/battery.sh}
         source ${./items/wifi.sh}

      sketchybar --update
    '';
  };
}
