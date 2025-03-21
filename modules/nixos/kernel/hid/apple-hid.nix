{
  # Enables and sets the Apple HID module. This may be required to access the
  # function key row of less then full size keyboards, by holding the 'Fn' key.

  boot = {
    kernelModules = [ "hid_apple" ];
    extraModprobeConfig = ''
      # example settings
      options hid_apple fnmode=2
    '';
  };
}
