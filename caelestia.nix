{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true; # if you prefer starting from your compositor
      target = "graphical-session.target";
      environment = [];
    };
    settings = {
      general = {
        apps = {
            terminal = ["ghostty"];
            audio = ["pwvucontrol"];
        };
        idle = {
            inhibitWhenAudio = true;
            lockTimeout = 180;
            dpmsTimeout = 300;
            sleepTimeout = 600;
        };
      };
      services = {
        weatherLocation = "Stockholm, SE";
        useFahrenheit = false;
      };
      osd = {
          enabled = true;
          enableBrightness = false;
          enableMicrophone = true;
          hideDelay = 2000;
      };
      sidebar = {
        enabled = true;
        dragThreshold = 0;
      };
      bar = {
        sizes = {
          innerWidth = 30;
        };
        status = {
            showAudio = true;
            showBattery = false;
            showBluetooth = true;
            showKbLayout = true;
            showMicrophone = false;
            showNetwork = true;
            showLockStatus = true;
        };
        workspaces = {
            activeIndicator = true;
            activeLabel = "";
            activeTrail = false;
            label = "";
            occupiedBg = false;
            occupiedLabel = "";
            perMonitorWorkspaces = true;
            showWindows = false;
            shown = 5;
        };
      };
      border = {
          rounding = 0;
          thickness = 1;
      };
      paths.wallpaperDir = "~/Pictures/Edited/";
    };
    cli = {
      enable = true; # Also add caelestia-cli to path
      settings = {
        theme.enableGtk = true;
      };
    };
  };
}
