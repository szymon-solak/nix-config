{pkgs, ...}: let
  set-color = pkgs.writeScriptBin "set-color" ''
    #!/bin/sh
    NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --list-devices | grep -E '^[0-9]+: ' | wc -l)

    for i in $(seq 0 $(($NUM_DEVICES - 1))); do
      ${pkgs.openrgb}/bin/openrgb --device ''$i --mode direct --color 6C3BAA
    done
  '';
in {
  environment.systemPackages = [
    pkgs.i2c-tools
  ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
  '';

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  hardware.i2c.enable = true;

  # systemd.services.set-color = {
  #   description = "set-color";
  #   serviceConfig = {
  #     ExecStart = "${set-color}/bin/set-color";
  #     Type = "oneshot";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
}
