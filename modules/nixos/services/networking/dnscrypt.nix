{ config, lib, ... }:

{
  options.dnscrypt.enable = lib.mkEnableOption ''
    Enable encrypted DNS queries via dnscrypt-proxy2.
  '';

  config = lib.mkIf config.dnscrypt.enable {
    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        server_names = [
          "cs-belgium"
          "cs-ireland"
          "cs-pt"

          "dnscry.pt-geneva-ipv4"
          "dnscry.pt-geneva-ipv6"

          "dnscry.pt-london-ipv4"
          "dnscry.pt-london-ipv6"

          "dnscry.pt-munich-ipv4"
          "dnscry.pt-munich-ipv6"
        ];
        # Filters
        dnscrypt_servers = true;
        doh_servers = false;

        anonymized_dns = {
          routes = [
            {
              server_name = "cs-belgium";
              via = [
                "dnscry.pt-anon-warsaw02-ipv4"
                "dnscry.pt-anon-warsaw02-ipv6"
              ];
            }
            {
              server_name = "cs-ireland";
              via = [
                "anon-dnscrypt.uk-ipv4"
                "anon-dnscrypt.uk-ipv6"
              ];
            }

            {
              server_name = "cs-pt";
              via = [
                "dnscry.pt-anon-madrid-ipv4"
                "dnscry.pt-anon-madrid-ipv6"
              ];
            }

            {
              server_name = "dnscry.pt-geneva-ipv4";
              via = [
                "anon-cs-czech"
              ];
            }
            {
              server_name = "dnscry.pt-geneva-ipv6";
              via = [
                "anon-cs-czech"
              ];
            }

            {
              server_name = "dnscry.pt-london-ipv4";
              via = [
                "anon-cs-fr"
              ];
            }
            {
              server_name = "dnscry.pt-london-ipv6";
              via = [
                "anon-cs-fr"
              ];
            }

            {
              server_name = "dnscry.pt-munich-ipv4";
              via = [
                "anon-cs-finland"
              ];
            }
            {
              server_name = "dnscry.pt-munich-ipv6";
              via = [
                "anon-cs-finland"
              ];
            }

          ];
          skip_incompatible = true;
        };
      };
    };
  };
}
