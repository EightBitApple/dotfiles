{ config, ... }:

{
  services.searx = {
    enable = true;

    environmentFile = config.sops.templates."searx-secrets".path;

    # Searx configuration
    settings = {
      # Instance settings
      general = {
        debug = false;
        instance_name = "Home Network SearXNG";
        donation_url = false;
        contact_url = false;
        privacypolicy_url = false;
        enable_metrics = false;
      };

      # Search engine settings
      search.safe_search = 1;

      # Server configuration
      server = {
        port = 8080;
        bind_address = "192.168.4.2";
        secret_key = "@SEARX_SECRET_KEY@";
        public_instance = false;
        method = "POST";
      };

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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };
}
