{ lib, pkgs, ... }:

{
  # Enable printing using CUPS.

  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon_PIXMA_MG3200_Series";
        location = "Home";
        deviceUri = "usb://Canon/MG3200%20series?serial=064612&interface=1";
        model = "gutenprint.${lib.versions.majorMinor (lib.getVersion pkgs.gutenprint)}://bjc-PIXMA-MG3250/expert";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
