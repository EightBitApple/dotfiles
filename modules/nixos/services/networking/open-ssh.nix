{
  services.openssh = {
    enable = true;
    # Enforce public key authentication.
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
