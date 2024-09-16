{ config, lib, ... }:

{
  options.sshAgent.enable = lib.mkEnableOption ''
    Enable ssh-agent.
  '';
  config = lib.mkIf config.sshAgent.enable { programs.ssh.startAgent = true; };
}
