{ inputs, userSettings, ... }:

{
  imports = [ inputs.sopsNix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "wpa/network1/SSID" = {
        owner = "${userSettings.username}";
      };
      "wpa/network1/psk" = {
        owner = "${userSettings.username}";
      };

      "wpa/network2/SSID" = {
        owner = "${userSettings.username}";
      };
      "wpa/network2/psk" = {
        owner = "${userSettings.username}";
      };
    };
  };
}
