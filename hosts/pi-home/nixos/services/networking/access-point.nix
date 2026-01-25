{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops = {
    secrets = {
      "wpa/network1/SSID" = { };
      "wpa/network1/psk" = { };
    };

    templates."create_ap.conf".content = ''
      GATEWAY=192.168.5.1
      INTERNET_IFACE=end0
      WIFI_IFACE=wlp1s0u1u2
      HIDDEN=1
      SSID=${config.sops.placeholder."wpa/network1/SSID"}
      PASSPHRASE=${config.sops.placeholder."wpa/network1/psk"}
    '';
  };

  systemd.services.create_ap = {
    serviceConfig = {
      ExecStart = lib.mkForce "${pkgs.linux-wifi-hotspot}/bin/create_ap --config ${
        config.sops.templates."create_ap.conf".path
      }";
      Restart = "on-failure";
    };
  };
}
