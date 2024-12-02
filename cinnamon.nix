{config, pkgs, ...}:

{
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = true;
    desktopManager.cinnamon.enable = true;
  };

  environment.cinnamon.excludePackages = with pkgs; [
    gnome.geary
    gnome.file-roller
    cinnamon.warpinator
    gnome.gnome-calculator
    gnome.gnome-calendar
  ];
}
