{ pkgs, config, lib, ... }:

 {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
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
