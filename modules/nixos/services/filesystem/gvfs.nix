{ config, lib, ... }:

{
  # For automatic drive partition mounting and trashcan functionality.

  services.gvfs.enable = true;
}
