{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/cda";
  boot.loader.grub.useOSProper = true;

  networking.hostName = "nixos"; # Set your hostname
  networking.networkmanager.enable = true; # Enable NetworkManager

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "trq"; # Turkish Q layout for virtual console

  services.xserver.enable = true;
  services.xserver.layout = "tr";
  services.xserver.xkbOptions = "grp:alt_shift_toggle"; # Allows toggling layout if needed
  services.xserver.desktopManager.plasma5.enable = true; # or another DE if you want

  # Allow non-free firmware
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  users.users.orgun = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enables ‘sudo’ for the user
    shell = pkgs.zsh; # or bash if preferred
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    wget
    btop
    curl
    neofetch
    git
  ];

  services.openssh.enable = false;

  system.stateVersion = "24.11"; # Change this to match your NixOS version
}
