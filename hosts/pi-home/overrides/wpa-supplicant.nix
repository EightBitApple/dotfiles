{ config, ... }:

{
  sops = {
    secrets = {
      "wpa/network1/SSID" = {};
      "wpa/network1/psk" = {};
    };

    # https://discourse.nixos.org/t/sops-nix-templates-in-config-file/40225/2
    # https://discourse.nixos.org/t/wireless-network-configuration-parameters-hidding/54935
    # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
    templates."wpa_supplicant.conf" = {
      content = ''
        network={
          ssid="${config.sops.placeholder."wpa/network1/SSID"}"
          psk="${config.sops.placeholder."wpa/network1/psk"}"
          freq_list=5160 5180 5200 5220 5240 5260 5280 5300 5320 5340 5480 5500 5520 5540 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 5845 5865
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
