# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}@other:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowBroken = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # boot.blacklistedKernelModules = [ "mt7925e" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  #24.11
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.gvfs.enable = true; # for nautilus to work
  services.getty.autologinOnce = true;
  services.getty.autologinUser = "murtaza";
  services.hypridle.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-mocha-mauve";
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
  };

  programs.gamescope.enable = true;
  programs.nix-ld.enable = true;
  programs.gamemode.enable = true;
  programs.uwsm.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.steam.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  environment.systemPackages = with pkgs; [
    swaynotificationcenter
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font = "Operator Mono";
      fontSize = "12";
    })
    pwvucontrol
    overskride
    wttrbar
    baobab
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";

  users.users.murtaza = {
    isNormalUser = true;
    description = "Murtaza";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    (pkgs.stdenv.mkDerivation {
      pname = "operator-mono";
      version = "1.0";
      # needs "nix-prefetch-url file:///etc/nixos/fonts/operator-mono.tar.gz" for now
      src = pkgs.fetchurl {
        url = "file:///etc/nixos/fonts/operator-mono.tar.gz";
        sha256 = "161g8q7xmgjzjcfqfsy37khcj0mdql83x2jyql7kvybbn22jwgkg";
      };

      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp *.otf $out/share/fonts/opentype/
      '';
    })
  ];

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ 43081 3216 ];
  networking.firewall.allowedUDPPorts = [ 43081 3216 ];
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  system.stateVersion = "25.05";
}
