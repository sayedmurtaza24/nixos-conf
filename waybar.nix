# waybar.nix - Separate file for Waybar configuration
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };

    settings = {
      mainBar = {
        # MAIN BAR
        position = "top";
        name = "main";

        height = 25;

        # margin-top = 5;
        # margin-left = 5;
        # margin-right = 5;

        modules-left = [
          "group/tray"
          "custom/spacer1"
          "custom/spacer2"
          "hyprland/workspaces"
          "custom/spacer2"
          "custom/spacer1"
          "hyprland/submap"
          "hyprland/window"
        ];

        modules-right = [
          "custom/spacer1"
          "cpu"
          "temperature"
          "group/gpu"
          "group/storage"
          "disk"
          "network#info"
          "custom/spacer1"
          "pulseaudio#input"
          "pulseaudio#output"
          "custom/spacer1"
          "hyprland/language"
          "bluetooth"
          "custom/spacer1"
          "custom/weather"
          "clock"
        ];

        bluetooth = {
          controller = "controller1";
          format = " {status}";
          format-disabled = "";
          format-connected = "";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "${pkgs.ghostty}/bin/ghostty --title=Bluetui -e ${pkgs.bluetui}/bin/bluetui";
        };

        # Module configurations
        disk = {
          interval = 16;
          format = " {percentage_used}%";
          tooltip = "{}";
          tooltip-format = "Free {free}";
          on-click = "${pkgs.baobab}/bin/baobab";
          states = {
            warning = 85;
            critical = 95;
          };
        };

        "custom/weather" = {
          format = "{}°";
          interval = 1800;
          exec = "${pkgs.wttrbar}/bin/wttrbar --nerd --location Stockholm";
          return-type = "json";
        };

        "group/tray" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = "500";
            transition-left-to-right = "true";
            children-class = "drawer-child";
          };
          modules = [ "custom/trayicon" "tray" ];
        };

        "group/gpu" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = "500";
            transition-left-to-right = "true";
            children-class = "drawer-child";
          };
          modules = [ "custom/gpu" "custom/vram" ];
        };

        "group/storage" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = "500";
            transition-left-to-right = "true";
            children-class = "drawer-child";
          };
          modules = [ "memory#ram" "memory#swap" ];
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "󱩎" "󱩑" "󱩓" "󱩕" "󰛨" ];
          scroll-step = 5;
        };

        "custom/gpu" = {
          format = "󰢮 {}%";
          interval = 2;
          exec = "cat /sys/class/drm/card1/device/gpu_busy_percent 2>/dev/null || echo '0'";
          return-type = "";
          tooltip = true;
          tooltip-format = "GPU Usage: {}%";
        };

        "custom/vram" = {
          format = "󰘚 {}%";
          interval = 2;
          exec = "echo \"scale=0; $(cat /sys/class/drm/card1/device/mem_info_vram_used) * 100 / $(cat /sys/class/drm/card1/device/mem_info_vram_total)\" | ${pkgs.bc}/bin/bc";
          return-type = "";
          tooltip-format = "VRAM Usage: {}%";
        };

        clock = {
          interval = 1;
          format = " {:%H:%M:%S    %d.%m}";
          tooltip-format = "{:%d.%m.%Y   Week %W}\n\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#94e2d5'> W{}</span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f5e0dc'><b><u>{}</u></b></span>";
            };
          };
          on-click = "${pkgs.swaynotificationcenter}/bin/swaync-client --toggle-panel";
        };

        cpu = {
          interval = 4;
          format = " {usage}%";
          states = {
            warning = 80;
            critical = 95;
          };
        };

        "hyprland/language" = {
          format = "  {}";
          format-en = "EN";
          format-sv = "SE";
          format-fa = "IR";
          on-click = "${pkgs.hyprland}/bin/hyprctl switchxkblayout current next";
        };

        "memory#ram" = {
          interval = 4;
          format = " {percentage}%";
          states = {
            warning = 80;
            critical = 95;
          };
          tooltip = "{}";
          tooltip-format = "{used}/{total} GiB";
        };

        "memory#swap" = {
          interval = 16;
          format = "󰾵 {swapPercentage}%";
          tooltip = "{}";
          tooltip-format = "{swapUsed}/{swapTotal}GiB";
        };

        "network#info" = {
          interval = 2;
          format = "󱘖  Offline";
          format-wifi = "{icon} {bandwidthDownBits}";
          format-ethernet = "󰈀 {bandwidthDownBits}";
          min-length = 6;
          tooltip = "{}";
          tooltip-format-wifi = "{ifname}\n{essid}\n{signalStrength}% \n{frequency} GHz\n󰇚 {bandwidthDownBits}\n󰕒 {bandwidthUpBits}";
          tooltip-format-ethernet = "{ifname}\n󰇚 {bandwidthDownBits} \n󰕒 {bandwidthUpBits}";
          on-click = "${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          format-icons = [ "󰤫" "󰤟" "󰤢" "󰤥" "󰤨" ];
          states = {
            normal = 25;
          };
        };

        "network#up" = {
          interval = 4;
          format = " ";
          format-wifi = "󰕒 {bandwidthUpBits}";
          format-ethernet = "󰕒 {bandwidthUpBits}";
          format-disconnected = " ";
          min-length = 11;
        };

        "network#down" = {
          interval = 4;
          format = "󰇚 {bandwidthDownBits}";
          format-wifi = "󰇚 {bandwidthDownBits}";
          format-ethernet = "󰇚 {bandwidthDownBits}";
          min-length = 11;
        };

        "hyprland/submap" = {
          always-on = true;
          default-submap = "";
          format = "{}";
          format-RESIZE = "{}lol";
          tooltip = false;
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 48;
          tooltip = true;
          icon = true;
          icon-size = 18;
        };

        "hyprland/workspaces" = {
          disable-scroll-wraparound = true;
          smooth-scrolling-threshold = 4;
          enable-bar-scroll = true;
          format = "{icon}";
          show-special = true;
          special-visible-only = false;
          format-icons = {
            magic = " ";
            "10" = "󰊴 ";
          };
        };

        "pulseaudio#output" = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-source-muted = "{volume}";
          format-icons = {
            headphone = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          tooltip = true;
          scroll-step = 5;
        };

        "pulseaudio#input" = {
          format = "{icon} {format_source}%";
          format-source = "{volume}";
          format-source-muted = "{volume}";
          on-scroll-up = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SOURCE@ 5%+ -l 1.0";
          on-scroll-down = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SOURCE@ 5%-";
          max-volume = "100";
          on-click-right = "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SOURCE@ toggle";
          on-click = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          tooltip-format = "{source_desc}";
        };

        temperature = {
          critical-threshold = 90;
          interval = 4;
          format = "{icon} {temperatureC}°";
          format-icons = ["" "" "" "" ""];
          tooltip = false;
        };

        tray = {
          icon-size = 17;
          spacing = 8;
        };

        "custom/spacer1" = {
          format = " | ";
          tooltip = false;
        };

        "custom/spacer2" = {
          format = " ";
          tooltip = false;
        };

        "custom/trayicon" = {
          format = "";
          tooltip = false;
          on-click = "${pkgs.systemd}/bin/systemctl suspend";
        };
      };
    };

    style = ''
      @define-color background  rgba(21, 21, 32, 0.75);
      @define-color warning     #f38ba8;
      @define-color caution     #45475a;
      @define-color performance #f5c2e7;
      @define-color audio       #cba6f7;
      @define-color misc        #94e2d5;
      @define-color date        #a6e3a1;
      @define-color work        #b4befe;
      @define-color window      #b4befe;
      @define-color resize      #eba0ac;
      @define-color process     #89b4fa;

      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        box-shadow: none;
        text-shadow: none;
      }

      @keyframes blink-critical-text {
        to {
          color: @warning;
        }
      }

      @keyframes blink-modifier-text {
        to {
          color: @caution;
        }
      }

      #waybar.main {
        background: rgba(20, 20, 20, 0.4);
        font-family: "Operator Mono";
        font-size: 11pt;
        font-weight: 500;
        border-bottom: 0px solid rgba(100, 100, 100, 0.2);
      }

      #waybar.main button {
        font-family: "Operator Mono";
        font-size: 10pt;
        font-weight: 500;
        transition: all 0.15s ease-in-out;
      }

      #waybar.main #custom-weather,
      #waybar.main #keyboard-state,
      #waybar.main #network,
      #waybar.main #battery,
      #waybar.main #backlight,
      #waybar.main #clock,
      #waybar.main #bluetooth,
      #waybar.main #cpu,
      #waybar.main #custom-gpu,
      #waybar.main #custom-vram,
      #waybar.main #language,
      #waybar.main #memory.swap,
      #waybar.main #memory.ram,
      #waybar.main #submap,
      #waybar.main #pulseaudio,
      #waybar.main #temperature,
      #waybar.main #tray,
      #waybar.main #window,
      #waybar.main #disk {
        padding-left: 8pt;
        padding-right: 8pt;
        padding-bottom: 4px;
        padding-top: 4px;
        background: transparent;
      }

      #waybar.main #tray {
        padding-right: 6pt;
      }

      #waybar.main #custom-weather {
        padding-right: 3pt;
      }

      #waybar.main #cpu,
      #waybar.main #custom-gpu,
      #waybar.main #custom-vram,
      #waybar.main #temperature,
      #waybar.main #memory.ram,
      #waybar.main #memory.swap,
      #waybar.main #disk,
      #waybar.main #network {
        color: @performance;
      }

      #waybar.main #pulseaudio {
        color: @audio;
      }

      #waybar.main #language,
      #waybar.main #bluetooth,
      #waybar.main #backlight,
      #waybar.main #battery {
        color: @misc;
      }

      #waybar.main #custom-weather,
      #waybar.main #clock {
        color: @date;
      }

      #waybar.main #window {
        color: @window;
        margin-top: -0px;
      }

      #waybar.main #network.info {
        padding-right: 10px;
        padding-left: 10px;
        color: @caution;
        background: transparent;
      }

      #waybar.main #network.info.wifi.normal,
      #waybar.main #network.info.ethernet {
        color: @performance;
        padding-right: 15px;
      }

      #waybar.main #network.info.wifi {
        color: @warning;
        padding-right: 15px;
      }

      #waybar.main #submap.\f0cf {
        color: @resize;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      #waybar.main #submap.\e0b0 {
        color: @date;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      #waybar.main #workspaces button.urgent,
      #waybar.main #workspaces button.special.urgent,
      #waybar.main #memory.swap.critical,
      #waybar.main #memory.ram.critical,
      #waybar.main #cpu.critical,
      #waybar.main #custom-gpu.critical,
      #waybar.main #custom-vram.critical,
      #waybar.main #temperature.critical,
      #waybar.main #battery.critical.discharging {
        color: @caution;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-critical-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      #waybar.main #pulseaudio.output.muted,
      #waybar.main #pulseaudio.input.source-muted {
        color: @caution;
      }

      #waybar.main #workspaces button {
        color: @caution;
        background: transparent;
        border: 1.5px solid transparent;
        padding-left: 2pt;
        padding-right: 2pt;
        border-radius: 16px;
        margin-bottom: 8px;
        margin-top: 8px;
        margin-left: 4px;
        margin-right: 4px;
        transition: all 0.25s ease;
      }

      #waybar.main #workspaces button.visible {
        color: @window;
      }

      #waybar.main #workspaces button.active {
        color: @window;
        border: 1.5px solid @caution;
      }

      #waybar.main #workspaces button:hover {
        color: @window;
      }

      #waybar.main #workspaces button.special.active {
        border: 1.5px solid transparent;
        color: @window;
        transition: all 0s ease;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        animation-name: blink-modifier-text;
        animation-duration: 1s;
        animation-timing-function: steps(15);
      }

      #waybar.main #custom-spacer1,
      #waybar.main #custom-spacer2,
      #waybar.main #custom-spacer3 {
        font-size: 10pt;
        font-weight: bold;
        color: @caution;
        background: transparent;
      }

      #waybar.main #custom-trayicon {
        font-size: 11pt;
        font-weight: bold;
        font-style: italic;
        color: @process;
        background: transparent;
        padding-right: 6pt;
        padding-left: 2pt;
      }

      tooltip {
        background: @background;
        border: 3px solid @caution;
        border-radius: 8px;
        font-weight: 500;
        font-family: "JetBrains Mono Nerd Font";
      }

      #waybar.main #tray menu {
        background: @background;
        border: 3px solid @caution;
        border-radius: 8px;
      }

      @keyframes blink-critical-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-warning-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-discharging-battery {
        to {
          border-color: @warning;
        }
      }

      @keyframes blink-charging-battery {
        to {
          border-color: @misc;
        }
      }

      @keyframes blink-full-battery {
        to {
          border-color: @misc;
        }
      }

      #waybar.indicator {
        font-size: 27px;
        color: rgba(0, 0, 0, 0);
        background: rgba(0, 0, 0, 0);
      }
    '';
  };
}
