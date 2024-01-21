{ pkgs, config, lib, ... }:

 {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = let modifier = config.xsession.windowManager.i3.config.modifier;
      in lib.mkOptionDefault {
        "Mod4+Return" = "exec /usr/bin/kitty";
        "Mod4+Shift+Return" = "exec /usr/bin/firefox";
        "Mod4+q" = "kill";
        "Mod4+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
      };
    };
  };
 }
