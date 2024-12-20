{pkgs, ...}: {
  environment.variables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  environment.sessionVariables = {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    extraConfig = ''
      AddKeysToAgent=yes
    '';
  };
}
