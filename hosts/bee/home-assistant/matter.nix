{ pkgs, ... }:
{
  services.matterjs-server = {
    enable = true;
    port = 5580;
    package = pkgs.matterjs-server;
    extraArgs = [
      "--vendorid=4939"
    ];
    bluetoothSupport = false;
		openFirewall = true;
  };

  services.matter-waker = {
    enable = true;
    nodes = [
      3
      8
    ];
  };
}
