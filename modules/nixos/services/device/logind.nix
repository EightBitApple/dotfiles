{
  # Limit number of TTYs.
  services.logind.settings.Login = {
    NAutoVTs = 2;
    ReserveVT = 1;
  };
}
