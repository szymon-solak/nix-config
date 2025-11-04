{config, ...}: {
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smb.${toString config.networking.hostName}";
        "netbios name" = "smb.${toString config.networking.hostName}";
        "security" = "user";
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";

        "client ipc max protocol" = "SMB3";
        "client ipc min protocol" = "SMB2_10";
        "client max protocol" = "SMB3";
        "client min protocol" = "SMB2_10";
        "server max protocol" = "SMB3";
        "server min protocol" = "SMB2_10";
      };

      "public" = {
        "path" = "/mnt/Shares/Public";
        "browseable" = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
      };

			"notes" = {
        "path" = "/mnt/Shares/Notes";
        "browseable" = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
			};
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
}
