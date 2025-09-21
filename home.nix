{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # ./waybar.nix
    ./hyprlock.nix
    # ./foot.nix
    ./ghostty.nix
    ./rofi-pass.nix
    ./hyprland.nix
    ./bash.nix
    ./remotegamepad.nix
    inputs.dank-material-shell.homeModules.dankMaterialShell
    inputs.niri.homeModules.niri
  ];

  systemd.user.sessionVariables = {
    PATH = "${config.home.profileDirectory}/bin:/run/current-system/sw/bin";
  };

  programs.home-manager.enable = true;

  home.username = "murtaza";
  home.homeDirectory = "/home/murtaza";
  home.stateVersion = "25.05"; # Use your NixOS version

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;

    name = "Catppuccin-Mocha-Dark-Cursors";
    package = pkgs.catppuccin-cursors.mochaDark;
    size = 16;
  };

  home.packages = with pkgs; [
    # language servers
    vtsls
    nixd
    eslint
    lua-language-server
    gopls
    protols
    zls
    vscode-json-languageserver
    prettier

    # programming languages
    zig
    clang
    go

    # command line tools
    lazygit
    curl
    gh
    fd
    ripgrep
    nvtopPackages.amd
    wl-clipboard
    swaybg
    file
    bitwarden-cli
    bluetui
    impala

    # desktop apps
    bitwarden-desktop
    brave
    nautilus
    qimgv
    gnome-tweaks
    rofi
    nwg-look
    webcord
    gfn-electron
    grim
    rawtherapee

    # extra
    gnome-themes-extra
    playerctl
    sassc
    gtk-engine-murrine
  ];

  programs.git = {
    enable = true;
    userName = "sayedmurtaza24";
    userEmail = "sayedmurtazamuttahar@gmail.com";
  };

  programs.hyprshot.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;

  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [mangohud winetricks gamemode umu-launcher];
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.cliphist.enable = true;

  programs.dankMaterialShell = {
    enable = true;

    # Enable niri keybinds (recommended)
    enableKeybinds = false;

    # Choose startup method - use either systemd OR spawn-at-startup, not both
    enableSystemd = true;          # Recommended: systemd service
    enableSpawn = false;           # Alternative: niri spawn-at-startup

    # Feature toggles - enable/disable based on your needs
    enableSystemMonitoring = true;    # CPU/RAM monitoring, process list
    enableClipboard = true;            # Clipboard manager
    enableVPN = true;                  # VPN status widget
    enableBrightnessControl = true;    # Brightness control
    enableNightMode = true;            # Night mode/blue light filter
    enableDynamicTheming = true;       # Wallpaper-based theming with matugen
    enableAudioWavelength = true;      # Audio visualizer with cava
    enableCalendarEvents = true;       # Calendar integration with khal

    # Specify quickshell package (uses the one from their flake)
    quickshell = {
      package = inputs.dank-material-shell.packages.${pkgs.system}.quickshell;
    };
  };
}
