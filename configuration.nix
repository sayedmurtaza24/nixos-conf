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

  boot.kernelParams = [
    "pcie_aspm=off"
    "btusb.enable_autosuspend=1"
    "usbcore.autosuspend=1"
    "snd-hda-intel.jackpoll_ms=1000"
  ];

  boot.extraModprobeConfig = ''
    options mt7925e disable_aspm=1

    options snd-hda-codec-alc269 model=auto
    options snd-hda-intel patch=hda-jack-retask.fw
    options snd-hda-intel power_save=0
    options snd-hda-intel probe_mask=1
    options snd-hda-codec-realtek model=auto
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.flatpak.enable = true;
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
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        GDK_SCALE = 2;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font = "Operator Mono";
      fontSize = "12";
    })
    pwvucontrol
    pavucontrol
    pulseaudio
    alsa-utils
    overskride
    wttrbar
    baobab
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    STEAM_FORCE_DESKTOP_UI_SCALING = "2";
  };

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
    roboto
    (pkgs.stdenv.mkDerivation {
      pname = "operator-mono";
      version = "1.0";
      # needs "nix-prefetch-url file:///etc/nixos/fonts/operator-mono.tar.gz" for now
      src = pkgs.fetchurl {
        url = "https://github.com/sayedmurtaza24/nixos-conf/raw/refs/heads/main/fonts/operator-mono.tar.gz";
        sha256 = "161g8q7xmgjzjcfqfsy37khcj0mdql83x2jyql7kvybbn22jwgkg";
      };

      installPhase = ''
        mkdir -p $out/share/fonts/opentype
        cp *.otf $out/share/fonts/opentype/
      '';
    })
    (pkgs.stdenv.mkDerivation {
      pname = "figtree";
      version = "1.0";
      # needs "nix-prefetch-url file:///etc/nixos/fonts/operator-mono.tar.gz" for now
      src = pkgs.fetchurl {
        url = "https://github.com/google/fonts/raw/refs/heads/main/ofl/figtree/Figtree%5Bwght%5D.ttf";
        sha256 = "sha256-Jq09ubMf993mepH/UV0CLS9JXNUGWQaZzyZPC/5vtxQ="; # replace with correct hash
      };

      unpackPhase = ":";

      installPhase = ''
        mkdir -p $out/share/fonts
        cp $src $out/share/fonts/Figtree.ttf
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
