{ config, pkgs, lib, ... }:

{
  # Clone the repository and setup style-2
  home.activation.cloneHyprlockStyles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    REPO_DIR="$HOME/.config/hyprlock-styles"
    ASSETS_DIR="$HOME/.config/hypr/hyprlock-assets"

    if [ ! -d "$REPO_DIR" ]; then
      ${pkgs.git}/bin/git clone https://github.com/MrVivekRajan/Hyprlock-Styles.git "$REPO_DIR"
    fi

    # Copy style-2 assets
    if [ -d "$REPO_DIR/Style-2" ]; then
      mkdir -p "$ASSETS_DIR"
      cp -r "$REPO_DIR/Style-2/"* "$ASSETS_DIR/"
    fi
  '';

  # Configure hyprlock style-2
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = [
        {
          monitor = "";
          path = "~/.config/hypr/hyprlock-assets/hypr.png";
          blur_passes = 0;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "SF Pro Display Bold";
          placeholder_text = "<i><span foreground=\"##ffffff99\">🔒 Enter Pass</span></i>";
          hide_input = false;
          position = "0, -250";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"%I:%M\")</span>\"";
          color = "rgba(216, 222, 233, .7)";
          font_size = 160;
          font_family = "JetBrains Mono Nerd Font";
          position = "0, 370";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
          color = "rgba(216, 222, 233, .7)";
          font_size = 28;
          font_family = "Operator Mono";
          position = "0, 490";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          outline_thickness = 2;
          font_size = 18;
          font_family = "Operator Mono";
          position = "0, -180";
          halign = "center";
          valign = "center";
        }
      ];

      image = [
        {
          monitor = "";
          path = "~/.config/hypr/hyprlock-assets/foreground.png";
          size = 700;
          border_size = 0;
          rounding = 0;
          rotate = 0;
          reload_time = 0;
          reload_cmd = "";
          position = "0, -66";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
