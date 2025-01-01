{
  services.physlock = {
    enable = true;
    disableSysRq = true;
    lockMessage = "Machine locked.";
    muteKernelMessages = true;
    lockOn = {
      suspend = true;
      hibernate = true;
    };
    allowAnyUser = true;
  };
}
