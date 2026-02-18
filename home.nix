{ config, pkgs, ... }:

{
  home.username = "nexus";
  home.homeDirectory = "/home/nexus";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
	kitty
	fuzzel
	swww
	arch-install-scripts
	bat
	tealdeer
  ];
  home.file = {
  };

  home.sessionVariables = {
  };
  programs.git.enable = true;
  programs.home-manager.enable = true;
}
