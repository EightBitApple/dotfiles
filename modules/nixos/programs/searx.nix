{ config, ... }:

{
  sops = {
    secrets."keys/searx" = { };
    templates."searx-secrets.env".content = ''
      SEARX_SECRET_KEY="${config.sops.placeholder."keys/searx"}"
    '';
  };

  services.searx = {
    enable = true;

    environmentFile = config.sops.templates."searx-secrets.env".path;

    # Searx configuration
    settings = {
      # Instance settings
      general = {
        debug = false;
        instance_name = "Local SearXNG";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      # Search engine settings
      search = {
        safe_search = 1;
        default_lang = "en-GB";
      };

      # Server configuration
      server = {
        port = 8080;
        image_proxy = true;
        public_instance = false;
        secret_key = "@SEARX_SECRET_KEY@";
        bind_address = "localhost";
        method = "POST";
      };

      ui.results_on_new_tab = true;

      # Enabled plugins
      enabled_plugins = [
        "Basic Calculator"
        "Hash plugin"
        "Tor check plugin"
        "Open Access DOI rewrite"
        "Hostnames plugin"
        "Unit converter plugin"
        "Tracker URL remover"
      ];
    };
  };
}
