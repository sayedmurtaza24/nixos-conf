{ config, pkgs, ... }:

let
  pinentry-rofi-wayland = pkgs.pinentry-rofi.overrideAttrs (old: {
    buildInputs = old.buildInputs ++ [ ];
    postInstall = ''
      wrapProgram $out/bin/pinentry-rofi --prefix PATH : ${
        pkgs.lib.makeBinPath [
          pkgs.rofi-wayland
          pkgs.coreutils
        ]
      }
    '';
  });
in
{
  # use built-in rbw module instead of manual package
  programs.rbw = {
    enable = true;
    settings = {
      email = "sayedmurtazamuttahary@gmail.com";
      base_url = "https://api.bitwarden.eu";
      identity_url = "https://identity.bitwarden.eu";
      notifications_url = "https://notifications.bitwarden.eu";
      pinentry = pinentry-rofi-wayland;
    };
  };

  home.file."bin/bitwarden-rofi".text = ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    if ! ${pkgs.rbw}/bin/rbw unlocked >/dev/null 2>&1; then
      ${pkgs.rbw}/bin/rbw unlock || exit 1
    fi

    entry="$(${pkgs.rbw}/bin/rbw list | ${pkgs.rofi-wayland}/bin/rofi -dmenu -i -p 'Bitwarden')"
    [ -z "$entry" ] && exit 0

    ${pkgs.rbw}/bin/rbw get "$entry" --field username --clipboard
    notify-send -t 2000 "Bitwarden" "Username copied to clipboard"
    sleep 3
    wl-copy --clear

    ${pkgs.rbw}/bin/rbw get "$entry" --field password --clipboard
    notify-send -t 2000 "Bitwarden" "Password copied to clipboard"
    sleep 3
    wl-copy --clear

    ${pkgs.rbw}/bin/rbw get "$entry" --field totp --clipboard
    notify-send -t 2000 "Bitwarden" "TOTP copied to clipboard"
    sleep 3
    wl-copy --clear

  '';
  home.file."bin/bitwarden-rofi".executable = true;

  # In your home.nix
  xdg.desktopEntries = {
    my-script = {
      name = "Passwords";
      comment = "Pick bitwarden password";
      exec = "${config.home.homeDirectory}/bin/bitwarden-rofi";
      icon = "bitwarden";
      terminal = false;
      type = "Application";
      categories = [ "Utility" ];
    };
  };
}
