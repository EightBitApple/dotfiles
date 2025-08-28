{
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  systemd = {
    network.wait-online.enable = false;
    services.NetworkManager-wait-online.enable = false;
  };
}
