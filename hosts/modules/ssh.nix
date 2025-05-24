{pkgs, ...}: {
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    extraConfig = ''
      AddKeysToAgent=yes
    '';
  };
}
