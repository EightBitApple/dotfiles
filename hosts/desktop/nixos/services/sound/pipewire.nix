let
  quantumSize = 256;
in

{
  services.pipewire = {
    extraConfig.pipewire."92-fixed-buffer" = {
      "context.properties" = {
        "default.clock.quantum" = quantumSize;
        "default.clock.min-quantum" = quantumSize;
        "default.clock.max-quantum" = quantumSize;
      };
    };

    wireplumber.extraConfig."99-disable-suspend" = {
      "monitor.alsa.rules" = [
        {
          matches = [
            { "node.name" = "~alsa_input.*"; }
            { "node.name" = "~alsa_output.*"; }
          ];
          actions.update-props = {
            "session.suspend-timeout-seconds" = 0;
          };
        }
      ];
    };
  };
}
