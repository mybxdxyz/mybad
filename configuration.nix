#https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./greetd.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    efi.efiSysMountPoint = "/boot/efi";
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  # services.printing.enable = true;
  services.libinput.enable = true;
  services.flatpak.enable = true;
  hardware.bluetooth.enable = true;
  services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  users.users.nexus = {
     isNormalUser = true;
     extraGroups = [ "wheel" ];
     shell = pkgs.fish;
     packages = with pkgs; [
     ];
   };

  hardware.graphics.enable = true;
  services.xserver = {
    xkb.layout = "us";
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };
  hardware.nvidia = {
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.light.enable = true;
  programs.fish.enable = true; 
  # envpkg
  environment.systemPackages = with pkgs; [
     wget
     neovim
     fastfetch
     fuzzel
     yazi
     git
     unzip
     lshw
     arch-install-scripts
     os-prober
     efibootmgr
     swww
     xclip
     bat
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; # Did you read the comment?

}

