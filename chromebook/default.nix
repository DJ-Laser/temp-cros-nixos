{ config, pkgs, ... }:

{
  imports = [
    ./cros-keymap.nix
    ./audio/audio.nix
  ];

  environment.systemPackages = [
    (pkgs.callPackage ./ectool.nix { })
  ];
}
