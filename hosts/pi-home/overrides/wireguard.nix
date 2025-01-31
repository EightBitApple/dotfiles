{ config, ... }:

{
  sops = {
    secrets = {
      "wireguard/address" = { };
      "wireguard/dns" = { };
      "wireguard/server_key" = { };
      "wireguard/psk" = { };
      "wireguard/allowed_ips/device_1" = { };
    };

    templates."wg0.conf" = {
      content = ''
        [Interface]
        Address = ${config.sops.placeholder."wireguard/address"}
        ListenPort = 51820
        PrivateKey = ${config.sops.placeholder."wireguard/server_key"}
        DNS = ${config.sops.placeholder."wireguard/dns"}

        [Peer]
        # device_1
        PublicKey = lPPxD0yMJfw8gbMiihQihit79GZx6LNRqO3u1wQ/Lmw=
        PreSharedKey = ${config.sops.placeholder."wireguard/psk"}
        AllowedIPs = ${config.sops.placeholder."wireguard/allowed_ips/device_1"}
      '';
      path = "/etc/wireguard/wg0.conf";
    };
  };

  networking.nat = {
    enable = true;
    externalInterface = "wlp3s0";
    internalInterfaces = [ "wg0" ];
  };
}
