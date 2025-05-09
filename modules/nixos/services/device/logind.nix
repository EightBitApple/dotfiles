{
  # Limit number of TTYs.
  services.logind.extraConfig = ''
    NAutoVTs=2
    ReserveVT=1
  '';
}
