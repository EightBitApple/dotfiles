{ config, lib, ... }:

{
  options.physlock.enable = lib.mkEnableOption ''
    Enable Physlock and allow any user to lock their display server session and all TTYs.
  '';

  config = lib.mkIf config.physlock.enable {
    services.physlock = {
      enable = true;
      muteKernelMessages = true;
      allowAnyUser = true;
      lockOn = {
        suspend = true;
        hibernate = true;
      };
    };
  };
}
