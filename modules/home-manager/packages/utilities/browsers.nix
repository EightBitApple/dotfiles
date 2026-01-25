{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    policies = {
      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below

        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

        "Tab-Session-Manager@sienori" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-session-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = false;
        };
      };
    };
  };
}
