{
  inputs,
  userSettings,
  config,
  ...
}:

{
  imports = [ inputs.sopsNix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "wpa/network1/SSID" = { };
      "wpa/network1/psk" = { };

      "wpa/network2/SSID" = { };
      "wpa/network2/psk" = { };

    };
    templates."wireless.conf".content = ''
      network1_psk=${config.sops.placeholder."wpa/network1/psk"}
      network2_psk=${config.sops.placeholder."wpa/network2/psk"}
    '';

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
}
