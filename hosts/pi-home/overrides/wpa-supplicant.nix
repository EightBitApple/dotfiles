{ config, ... }:

{
  sops = {
    secrets.wpa.network1 = {
      SSID = { };
      psk = { };
    };

    # https://discourse.nixos.org/t/sops-nix-templates-in-config-file/40225/2
    # https://discourse.nixos.org/t/wireless-network-configuration-parameters-hidding/54935
    # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
    templates."wpa_supplicant.conf" = {
      content = ''
        network={
          ssid="${config.sops.placeholder."wpa/network1/SSID"}"
          psk="${config.sops.placeholder."wpa/network1/psk"}"
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
