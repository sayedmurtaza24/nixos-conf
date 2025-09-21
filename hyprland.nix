{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ pkgs.hyprlandPlugins.hy3 ];
    settings = {
      # Monitor configuration
      monitor = [
        "DP-3,highrr,auto,auto,vrr,1"
      ];

      # Program variables
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "rofi -show drun";
      "$mainMod" = "SUPER";
      "$windowManageMod" = "ALT";

      # Autostart
      exec-once = [
        "swaybg --mode fill --image ~/.config/hypr/background.jpg"
      ];

      # debug = {
      #   full_cm_proto = true;
      # };

      exec = [
        "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
        "gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3\""
      ];

      # Environment variables
      env = [
        "XCURSOR_THEME,catppuccin-mocha-dark-cursors"
        "XCURSOR_SIZE,20"
        "GDK_SCALE,2"
        "QT_SCALE_FACTOR,2"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      # XWayland configuration
      # xwayland = {
      #   force_zero_scaling = true;
      # };

      # General settings
      general = {
        gaps_in = "3";
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(333333ff)";
        "col.inactive_border" = "rgba(222222ff)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settings
      decoration = {
        rounding = 6;
        rounding_power = 2;
        dim_strength = "0.1";
        dim_inactive = true;
        active_opacity = "1.0";
        inactive_opacity = "1.0";

        shadow = {
          enabled = true;
        };

        blur = {
          enabled = true;
          size = 15;
          passes = 3;
          xray = false;
          vibrancy = "0.5";
        };
      };

      # Animations
      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 0, 1.94, almostLinear, fade"
          "workspacesIn, 0, 1.21, almostLinear, fade"
          "workspacesOut, 0, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      group = {
        auto_group = false;

        merge_groups_on_drag = false;

        "col.border_active" = "rgba(629e83ff) rgba(94e2d5ff) 45deg";
        "col.border_inactive" = "rgba(595959ff)";

        groupbar = {
          text_offset = 2;
          font_family = "Operator Mono Medium";
          font_size = 14;
          height = 24;
          gradients = true;
          "col.active" = "rgba(1e1e1eff)";
          "col.inactive" = "rgba(2b2b2bee)";
          text_color = "rgba(629e83ff)";
          text_color_inactive = "rgba(888888ee)";
          gaps_in = 0;
          gaps_out = 0;
        };
      };

      # Master layout
      master = {
        new_status = "master";
      };

      # Misc settings
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input settings
      input = {
        kb_layout = "us,se,ir";
        kb_variant = ",mac,winkeys";
        follow_mouse = 1;
        sensitivity = 0;
        natural_scroll = true;
        repeat_rate = 35;
        repeat_delay = 220;
      };

      # Key bindings
      bind = [
        # System controls
        "CTRL SHIFT, Q, exec, playerctl pause && hyprlock"
        "SUPER SHIFT, 4, exec, hyprshot -m region -o $HOME/ScreenShots"
        "SUPER SHIFT, 5, exec, hyprshot -m output -o $HOME/ScreenShots"

        # Application launchers
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive"
        "$mainMod, W, killactive"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, SPACE, exec, $menu"
        "$mainMod, P, pseudo"

        # Focus movement
        "$windowManageMod, h, movefocus, l"
        "$windowManageMod, l, movefocus, r"
        "$windowManageMod, k, movefocus, u"
        "$windowManageMod, j, movefocus, d"

        # Focus movement group
        "$mainMod, h, changegroupactive, b"
        "$mainMod, l, changegroupactive, f"

        # Groups
        "$windowManageMod, G, togglegroup"

        # Workspace switching
        "$windowManageMod, y, workspace, 1"
        "$windowManageMod, u, workspace, 2"
        "$windowManageMod, i, workspace, 3"
        "$windowManageMod, o, workspace, 4"
        "$windowManageMod, p, workspace, 5"
        "$windowManageMod, 6, workspace, 6"
        "$windowManageMod, 7, workspace, 7"
        "$windowManageMod, 8, workspace, 8"
        "$windowManageMod, 9, workspace, 9"
        "$windowManageMod, 0, workspace, 10"

        # Move windows to workspaces
        "$windowManageMod SHIFT, y, movetoworkspace, 1"
        "$windowManageMod SHIFT, u, movetoworkspace, 2"
        "$windowManageMod SHIFT, i, movetoworkspace, 3"
        "$windowManageMod SHIFT, o, movetoworkspace, 4"
        "$windowManageMod SHIFT, p, movetoworkspace, 5"
        "$windowManageMod SHIFT, 6, movetoworkspace, 6"
        "$windowManageMod SHIFT, 7, movetoworkspace, 7"
        "$windowManageMod SHIFT, 8, movetoworkspace, 8"
        "$windowManageMod SHIFT, 9, movetoworkspace, 9"
        "$windowManageMod SHIFT, 0, movetoworkspace, 10"

        # Moving windows inside workspace
        "$windowManageMod CTRL, h, movewindoworgroup, l"
        "$windowManageMod CTRL, l, movewindoworgroup, r"
        "$windowManageMod CTRL, k, movewindoworgroup, u"
        "$windowManageMod CTRL, j, movewindoworgroup, d"

        # Window management
        "$windowManageMod, V, togglefloating"
        "$windowManageMod, F, fullscreen, 1"

        # Special workspace (scratchpad)
        "$windowManageMod, S, togglespecialworkspace, magic"
        "$windowManageMod SHIFT, S, movetoworkspace, special:magic"

        # Workspace navigation with mouse
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Mouse bindings
      bindm = [
        "$windowManageMod, mouse:272, movewindow"
        "$windowManageMod, mouse:273, resizewindow"
      ];

      # Volume and brightness controls
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media controls
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Window rules
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Network Manager
        "float, title:Network Manager"
        "size 500 700, title:Network Manager"
        "stayfocused, title:Network Manager"
        "dimaround 1, title:Network Manager"

        # Pipewire Volume Control
        "float, title:Pipewire Volume Control"
        "size 900 700, title:Pipewire Volume Control"
        "stayfocused, title:Pipewire Volume Control"
        "dimaround 1, title:Pipewire Volume Control"
        "noborder, title:Pipewire Volume Control"
        "rounding 14, title:Pipewire Volume Control"
        "roundingpower 10, title:Pipewire Volume Control"

        # Bluetui
        "float, title:Bluetui"
        "size 900 700, title:Bluetui"
        "stayfocused, title:Bluetui"
        "dimaround 1, title:Bluetui"
      ];

      # Layer rules
      layerrule = [
        "blur, waybar"
        "xray 1, waybar"
        "blur, rofi"
        "animation popin 97%, rofi"
        "dimaround, rofi"
        "ignorealpha 0.1, rofi"
      ];

      # Workspace configuration
      workspace = [
        "1, defaultName:Y"
        "2, defaultName:U"
        "3, defaultName:I"
        "4, defaultName:O"
        "5, defaultName:P"
      ];
    };
  };
}
