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

    age.keyFile = "/home/${userSettings.user.name}/.config/sops/age/keys.txt";
  };
}
