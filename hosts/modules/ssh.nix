{pkgs, ...}: {
  environment.sessionVariables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  programs.ssh = {
    startAgent = true;
    askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    extraConfig = ''
      AddKeysToAgent=yes
    '';
  };
}
