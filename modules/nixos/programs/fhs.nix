{
  pkgs,
  userSettings,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let
        base = pkgs.appimageTools.defaultFhsEnvArgs;
      in
      pkgs.buildFHSEnv (
        base
        // {
          name = "fhs";
          targetPkgs = pkgs: (base.targetPkgs pkgs);
          profile = "export FHS=1";
          runScript = "${userSettings.terminal.shell}";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];
}
