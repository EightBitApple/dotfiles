{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops = {
    secrets.wpa.network2 = {
      SSID = { };
      psk = { };
    };

    templates."create_ap.conf".content = ''
      GATEWAY=192.168.5.1
      INTERNET_IFACE=end0
      WIFI_IFACE=wlp1s0u1u4
      SSID=${config.sops.placeholder.wpa.network2.SSID}
      PASSPHRASE=${config.sops.placeholder.wpa.network2.psk}
    '';
  };

  systemd.services.create_ap = {
    serviceConfig.ExecStart = lib.mkForce "${pkgs.linux-wifi-hotspot}/bin/create_ap --config ${
      config.sops.templates."create_ap.conf".path
    }";
  };
}
