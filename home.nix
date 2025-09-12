{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./waybar.nix
    ./hyprlock.nix
    ./foot.nix
    ./rofi-pass.nix
    ./hyprland.nix
    ./bash.nix
    ./remotegamepad.nix
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

    # desktop apps
    bitwarden-desktop
    brave
    nautilus
    qimgv
    gnome-tweaks
    rofi-wayland
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
}
