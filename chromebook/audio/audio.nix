{config, pkgs, lib, ...}:

let
  inherit (lib) types;
  inherit (lib.lists) optional;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;

  linkWireplumberConfig = confPath:
    let
      fileName = builtins.baseNameOf confPath;
    in
    pkgs.linkFarm fileName {
      name = "share/wireplumber/wireplumber.conf.d/${fileName}";
      path = "${pkgs.chromebook.audioConf}/${confPath}";
    };

  cfg = config.chromebook.audio;
in
{
  imports = [
    ./overlay.nix
  ];

  options.chromebook.audio = {
    enable = mkEnableOption "chromebook audio configs";
  };

  config = 
    let
      headroomConfig = linkWireplumberConfig "common/51-increase-headroom.conf";
      avsConfig = linkWireplumberConfig "avs/51-avs-dmic.conf";

      wireplumberConfigs = [ headroomConfig avsConfig ];
    in
    mkIf cfg.enable {
      boot.extraModprobeConfig = builtins.readFile "${pkgs.chromebook.audioConf}/conf/avs/snd-avs.conf";
      services.pipewire.wireplumber.configPackages = wireplumberConfigs;

      system.replaceRuntimeDependencies = [{
        original = pkgs.alsa-ucm-conf;
        replacement = pkgs.chromebook.alsa-ucm-conf;
      }];
    };
}
