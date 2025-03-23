{
  # Limit number of TTYs.
  services.logind.extraConfig = ''
    NAutoVTs=0
    ReserveVT=1
  '';
}
