let
  hasIPv6Address = true;
  stateDirectory = "dnscrypt-proxy";
in
{
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services = {
    resolved.enable = false;

    # See https://wiki.nixos.org/wiki/Encrypted_DNS
    dnscrypt-proxy = {
      enable = true;
      settings = {
        # See https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
        sources.public-resolvers = {
          # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];

          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          cache_file = "/var/lib/${stateDirectory}/public-resolvers.md";
        };

        ipv6_servers = hasIPv6Address;
        block_ipv6 = !(hasIPv6Address);

        require_dnssec = true;
        require_nolog = true;
        require_nofilter = true;

        disabled_server_names = [
          "dnscrypt.uk-ipv4"
          "dnscrypt.uk-ipv6"
          "scaleway-ams"
          "scaleway-ams-ipv6"
          "cs-berlin"
          "cs-berlin6"
          "cs-belgium"
          "cs-belgium6"
        ];

        anonymized_dns = {
          routes = [
            {
              server_name = "*";
              via = [
                "anon-dnscrypt.uk-ipv4"
                "anon-dnscrypt.uk-ipv6"
                "anon-scaleway-ams"
                "anon-scaleway-ams-ipv6"
                "anon-cs-berlin"
                "anon-cs-berlin6"
                "anon-cs-belgium"
                "anon-cs-belgium6"
              ];
            }
          ];
        };
      };
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = stateDirectory;
}
