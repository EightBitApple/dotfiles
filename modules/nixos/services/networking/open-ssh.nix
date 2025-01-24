{
  services.openssh = {
    enable = true;
    # Enforce public key authentication.
    settings = {
      PaswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
