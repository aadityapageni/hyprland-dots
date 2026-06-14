{ config, lib, pkgs, ... }: with lib; let cfg = config.dotfiles; in mkIf cfg.enable {
  xdg.configFile = {
    "tofi/config".source = ./../tofi/config;
    "tofi/configpowermenu".source = ./../tofi/configpowermenu;
    "tofi/powermenu.sh".source = ./../tofi/powermenu.sh;
    "tofi/tofi-wifi.sh".source = ./../tofi/tofi-wifi.sh;
    "wob/wob.ini".source = ./../wob/wob.ini;
  };
}
