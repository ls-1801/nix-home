{ pkgs, config, lib, ... }:

{
  
  services.polybar = {
    enable = true;
    script = "polybar top &";
    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:DP-1}";
        width = "100%";
        height = "3%";
        radius = 0;
        modules-center = "date";
      };

      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%time%  %date%";
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
      startup = [
         { command = "systemctl --user restart polybar"; always = true; notification = false; }
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
