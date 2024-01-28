{ pkgs, config, lib, ... }:

{
  
  services.picom = {
    enable = true;
  };
  services.polybar = {
    enable = true;
    package = pkgs.polybarFull;

    script = ''
      polybar top-main &
      polybar top-right &
    '';

    config = {
      "bar/top-right" = {
        monitor = "\${env:MONITOR:HDMI-1}";
        width = "100%";
        height = "3%";
        radius = 0;
        modules-right = "i3";
        modules-center = "date";
      };

      "bar/top-main" = {
        monitor = "\${env:MONITOR:DP-1}";
        width = "100%";
        height = "3%";
        radius = 0;
        modules-right = "i3";
        modules-center = "date";
      };

      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%time%  %date%";
      };
      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
      };
    };
  };

  xsession = {
    enable = true;
    initExtra = ''
      setxkbmap de -variant nodeadkeys -option caps:esc
    '';
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      gaps = {
        outer = 5;
        inner = 5;
        smartGaps = false;
      };
      window.border = 1;
      floating.border = 1;
      window.commands = [
        {
          command = "border pixel 1";
          criteria = {
            class = ".*";
          };
        }
      ];
      startup = [
         { command = "systemctl --user restart polybar"; always = true; notification = false; }
         { command = "nitrogen --restore &"; always = true; notification = false; }
      ];
      keybindings = let modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Return" = "exec /usr/bin/kitty";
        "${modifier}+Shift+Return" = "exec /usr/bin/firefox";
        "${modifier}+q" = "kill";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

        "${modifier}+less" = "move workspace to output left";
      };
    };
  };
 }
