{ config, ... }:

{
  sops = {
    secrets = {
      "wpa/network1/SSID" = {};
      "wpa/network1/BSSID" = {};
      "wpa/network1/BSSID_ignore" = {};
      "wpa/network1/psk" = {};
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

  networking.wireless = {
    interfaces = [ "wlan0" ];
    # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
    allowAuxiliaryImperativeNetworks = true;
  };
}
