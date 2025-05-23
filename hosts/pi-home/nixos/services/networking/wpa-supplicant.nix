{
  config,
  pkgs,
  lib,
  ...
}:

let
  iface = "wlan0";
  service = "wpa_supplicant-${iface}.service";

  watchdog = {
    name = "wpa_watchdog";
    interval = "5m";
    bssid_ignore = config.sops.secrets."wpa/network1/BSSID_ignore".path;
  };

  systemctl = "${pkgs.systemd}/bin/systemctl";
  grep = "${pkgs.gnugrep}/bin/grep";
in
{
  sops = {
    secrets = {
      "wpa/network1/SSID" = { };
      "wpa/network1/BSSID" = { };
      "wpa/network1/BSSID_ignore" = { };
      "wpa/network1/psk" = { };
    };

    # https://discourse.nixos.org/t/sops-nix-templates-in-config-file/40225/2
    # https://discourse.nixos.org/t/wireless-network-configuration-parameters-hidding/54935
    # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
    templates."wpa_supplicant.conf" = {
      content = ''
        freq_list=5170 5180 5190 5200 5210 5220 5230 5240 5260 5280 5300 5320 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825
        network={
          ssid="${config.sops.placeholder."wpa/network1/SSID"}"
          bssid=${config.sops.placeholder."wpa/network1/BSSID"}
          bssid_ignore=${config.sops.placeholder."wpa/network1/BSSID_ignore"}
          psk=${config.sops.placeholder."wpa/network1/psk"}
        }
      '';
      path = "/etc/wpa_supplicant.conf";
    };
  };

  networking = {
    hostName = lib.mkForce "pi-home";
    wireless = {
      interfaces = [ iface ];
      # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
      allowAuxiliaryImperativeNetworks = true;
    };
  };

  systemd.services."${watchdog.name}" = {
    script = ''
      while :
      do
        if ${systemctl} status ${service} | ${grep} ''$(cat "${watchdog.bssid_ignore}") > /dev/null; then
          ${systemctl} restart ${service}
          printf "${service} connected to 2.4GHz band, restarted it."
        fi
        sleep ${watchdog.interval}
      done
    '';
    wantedBy = [ "multi-user.target" ];
  };
}
