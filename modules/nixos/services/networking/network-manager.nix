{
  networking = {
    networkmanager.enable = true;
  };

  systemd = {
    network.wait-online.enable = false;
    services.NetworkManager-wait-online.enable = false;
  };
}
