{ config, lib, pkgs, ... }:

{
  options.audioTools.enable = lib.mkEnableOption ''
    Install software to manipulate audio playback.
  '';

  config = lib.mkIf config.audioTools.enable {
    services = {
      easyeffects = {
        enable = true;
        preset = "./easyeffects-presets/output/hifi.json";
      };
    };

    home.packages = with pkgs; [ pulsemixer pamixer qpwgraph ];

    home.file.".config/wireplumber/wireplumber.conf.d/50-device-rename.conf".text =
      ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                device.name = "alsa_card.pci-0000_00_1f.3"
              }
            ]
            actions = {
              update-props = {
                device.description = "Speakers"
              }
            }
          }
        ]
        monitor.alsa.rules = [
          {
            matches = [
              {
                device.name = "alsa_card.pci-0000_01_00.1"
              }
            ]
            actions = {
              update-props = {
                device.description = "Headphones"
              }
            }
          }
        ]
        monitor.alsa.rules = [
          {
            matches = [
              {
                device.name = "alsa_card.usb-Sony_Interactive_Entertainment_Wireless_Controller-00"
              }
            ]
            actions = {
              update-props = {
                device.description = "Dualsense Controller"
              }
            }
          }
        ]
      '';

    home.file.".config/wireplumber/wireplumber.conf.d/51-node-rename.conf".text =
      ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "alsa_output.pci-0000_00_1f.3.analog-stereo"
              }
            ]
            actions = {
              update-props = {
                node.description = "Speakers"
                node.nick = "SPR"
              }
            }
          }
        ]
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra4"
              }
            ]
            actions = {
              update-props = {
                node.description = "Headphones"
                node.nick = "HDP"
              }
            }
          }
        ]
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "alsa_output.usb-Sony_Interactive_Entertainment_Wireless_Controller-00.analog-surround-40"
              }
            ]
            actions = {
              update-props = {
                node.description = "Dualsense Controller"
                node.nick = "DSC"
              }
            }
          }
        ]
      '';
  };
}
