{
  pkgs,
  ...
}:

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ pkgs.intel-vaapi-driver ];
    enable32Bit = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  }; # Force intel-vaapi-driver (older but works better for Firefox/Chromium)
}
