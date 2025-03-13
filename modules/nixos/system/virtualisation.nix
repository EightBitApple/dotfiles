{
  virtualisation = {
    containers.enable = true;
    spiceUSBRedirection.enable = true;

    # From https://wiki.nixos.org/wiki/Podman
    podman = {
      enable = true; # Enable common container config files in /etc/containers
      dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };
}
