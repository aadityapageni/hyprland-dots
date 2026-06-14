{ config, lib, pkgs, ... }: with lib; let cfg = config.dotfiles; in mkIf cfg.enable let
  wallpaperDir = "${cfg.homeDir}/.config/hypr/wallpaper";

  # All themes defined as Nix attrsets
  themes = {
    black = {
      gaps_out = 0; gaps_in = 0; border_size = 1;
      active_border = "rgba(ffffffcc) rgba(ffffffff) 45deg";
      inactive_border = "rgba(595959aa)";
      rounding = 0; rounding_power = 0;
      active_opacity = 1; inactive_opacity = 1;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "black"; accent_color = "#dddddd"; bg_color = "#000000"; fg_color = "#797979";
    };
    color = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(ff5733ee) rgba(ffc300aa) 45deg";
      inactive_border = "rgba(1a0a0aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = true; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/color.jpg"; accent_color = "#ff5733"; bg_color = "#1a0a0a"; fg_color = "#e6e6e6";
    };
    dark_green = {
      gaps_out = 5; gaps_in = 5; border_size = 1;
      active_border = "rgba(2e5e2eee) rgba(1a3a1aaa) 45deg";
      inactive_border = "rgba(0a120aaa)"; rounding = 8; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/dark_green.jpg"; accent_color = "#2e5e2e"; bg_color = "#0a120a"; fg_color = "#b0b0b0";
    };
    dark_mountains = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(4a6a8aff) rgba(2a3a5aff) 45deg";
      inactive_border = "rgba(0a0f1aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = true; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/dark_mountains.jpg"; accent_color = "#4a6a8a"; bg_color = "#0a0f1a"; fg_color = "#c0c0c0";
    };
    earth = {
      gaps_out = 5; gaps_in = 5; border_size = 1;
      active_border = "rgba(8a7a5aff) rgba(5a4a3aff) 45deg";
      inactive_border = "rgba(0a0a0aaa)"; rounding = 8; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/earth.jpg"; accent_color = "#8a7a5a"; bg_color = "#0a0a0a"; fg_color = "#999999";
    };
    green = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(527352ee) rgba(385238aa) 45deg";
      inactive_border = "rgba(0a0f0aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 1;
      shadow_enabled = false; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/green.jpg"; accent_color = "#527352"; bg_color = "#0a0f0a"; fg_color = "#e6e6e6";
    };
    light_green = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(7aaa7acc) rgba(5a8a5aaa) 45deg";
      inactive_border = "rgba(1a1f1aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/light_green.jpg"; accent_color = "#7aaa7a"; bg_color = "#1a1f1a"; fg_color = "#e6e6e6";
    };
    line = {
      gaps_out = 5; gaps_in = 5; border_size = 1;
      active_border = "rgba(ffffffcc) rgba(aaaaaacc) 45deg";
      inactive_border = "rgba(444444aa)"; rounding = 0; rounding_power = 0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/line.jpg"; accent_color = "#ffffff"; bg_color = "#000000"; fg_color = "#aaaaaa";
    };
    minimal = {
      gaps_out = 5; gaps_in = 5; border_size = 1;
      active_border = "rgba(3a8fbfff) rgba(ff4b30ff) 45deg";
      inactive_border = "rgba(0a151caa)"; rounding = 12; rounding_power = 4.0;
      active_opacity = 1.0; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/minimal.jpg"; accent_color = "#dddddd"; bg_color = "#000000"; fg_color = "#797979";
    };
    mountains = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(6a8aaaee) rgba(4a6a8aaa) 45deg";
      inactive_border = "rgba(0a1a2aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/mountains.jpg"; accent_color = "#6a8aaa"; bg_color = "#0a1a2a"; fg_color = "#d0d0d0";
    };
    purple = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(8a4a9aee) rgba(6a2a7aaa) 45deg";
      inactive_border = "rgba(1a0a1aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/purple.jpg"; accent_color = "#8a4a9a"; bg_color = "#1a0a1a"; fg_color = "#d0d0d0";
    };
    red = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(cc3333ee) rgba(992222aa) 45deg";
      inactive_border = "rgba(1a0a0aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/red.jpg"; accent_color = "#cc3333"; bg_color = "#1a0a0a"; fg_color = "#d0d0d0";
    };
    simple_green = {
      gaps_out = 5; gaps_in = 5; border_size = 1;
      active_border = "rgba(3a7a3acc) rgba(2a5a2aaa) 45deg";
      inactive_border = "rgba(0a0f0aaa)"; rounding = 8; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = false; shadow_range = 4; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = false; blur_size = 3; blur_passes = 1; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/simple_green.jpg"; accent_color = "#3a7a3a"; bg_color = "#0a0f0a"; fg_color = "#b0b0b0";
    };
    soft_color = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(cc9977ee) rgba(aa7755aa) 45deg";
      inactive_border = "rgba(1a1a1aaa)"; rounding = 12; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = true; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/soft_color.jpg"; accent_color = "#cc9977"; bg_color = "#1a1a1a"; fg_color = "#d0d0d0";
    };
    yellow = {
      gaps_out = 10; gaps_in = 5; border_size = 1;
      active_border = "rgba(cccc44ee) rgba(aaaa33aa) 45deg";
      inactive_border = "rgba(1a1a0aaa)"; rounding = 10; rounding_power = 4.0;
      active_opacity = 1; inactive_opacity = 0.90;
      shadow_enabled = true; shadow_range = 15; shadow_render_power = 3; shadow_color = "rgba(1a1a1aee)";
      blur_enabled = true; blur_size = 6; blur_passes = 2; blur_vibrancy = 0.1696;
      wallpaper = "${wallpaperDir}/yellow.jpg"; accent_color = "#cccc44"; bg_color = "#1a1a0a"; fg_color = "#d0d0d0";
    };
  };

  currentTheme = themes.${cfg.theme} or themes.minimal;

  # Generate theme .conf content
  themeConf = name: t: ''
    $gaps_out = ${toString t.gaps_out}
    $gaps_in = ${toString t.gaps_in}
    $border_size = ${toString t.border_size}
    $active_border = ${t.active_border}
    $inactive_border = ${t.inactive_border}
    $rounding = ${toString t.rounding}
    $rounding_power = ${toString t.rounding_power}
    $active_opacity = ${toString t.active_opacity}
    $inactive_opacity = ${toString t.inactive_opacity}
    $shadow_enabled = ${if t.shadow_enabled then "true" else "false"}
    $shadow_range = ${toString t.shadow_range}
    $shadow_render_power = ${toString t.shadow_render_power}
    $shadow_color = ${t.shadow_color}
    $blur_enabled = ${if t.blur_enabled then "true" else "false"}
    $blur_size = ${toString t.blur_size}
    $blur_passes = ${toString t.blur_passes}
    $blur_vibrancy = ${toString t.blur_vibrancy}
    $wallpaper = ${t.wallpaper}
    $accent_color = ${t.accent_color}
    $bg_color = ${t.bg_color}
    $fg_color = ${t.fg_color}
  '';

  # Generate theme .lua content
  genThemeLua = t: let
    inherit (builtins) match elemAt;
    parsed = match "rgba\\(([^)]+)\\) rgba\\(([^)]+)\\) ([0-9]+)deg" t.active_border;
    colorsStr = if parsed == null
      then ''{ colors = { "rgba(ffffffcc)", "rgba(ffffffff)" }, angle = 45 }''
      else ''{ colors = { "rgba(${elemAt parsed 0})", "rgba(${elemAt parsed 1})" }, angle = ${elemAt parsed 2} }'';
  in ''
    return {
        gaps_in = ${toString t.gaps_in},
        gaps_out = ${toString t.gaps_out},
        border_size = ${toString t.border_size},
        active_border = ${colorsStr},
        inactive_border = "${t.inactive_border}",
        rounding = ${toString t.rounding},
        rounding_power = ${toString t.rounding_power},
        active_opacity = ${toString t.active_opacity},
        inactive_opacity = ${toString t.inactive_opacity},
        shadow_enabled = ${if t.shadow_enabled then "true" else "false"},
        shadow_range = ${toString t.shadow_range},
        shadow_render_power = ${toString t.shadow_render_power},
        shadow_color = "${t.shadow_color}",
        blur_enabled = ${if t.blur_enabled then "true" else "false"},
        blur_size = ${toString t.blur_size},
        blur_passes = ${toString t.blur_passes},
        blur_vibrancy = ${toString t.blur_vibrancy},
    }
  '';

  # Build all theme .conf files as an attrset for xdg.configFile
  themeConfFiles = let
    addTheme = name: t: { "hypr/themes/${name}.conf".text = themeConf name t; };
  in builtins.foldl' (acc: name: acc // (addTheme name themes.${name})) {} (builtins.attrNames themes);
in {
  xdg.configFile = themeConfFiles // {
    # Copy wallpaper images
    "hypr/wallpaper/color.jpg".source = ./../hypr/wallpaper/color.jpg;
    "hypr/wallpaper/dark_green.jpg".source = ./../hypr/wallpaper/dark_green.jpg;
    "hypr/wallpaper/dark_mountains.jpg".source = ./../hypr/wallpaper/dark_mountains.jpg;
    "hypr/wallpaper/earth.jpg".source = ./../hypr/wallpaper/earth.jpg;
    "hypr/wallpaper/green.jpg".source = ./../hypr/wallpaper/green.jpg;
    "hypr/wallpaper/light_green.jpg".source = ./../hypr/wallpaper/light_green.jpg;
    "hypr/wallpaper/line.jpg".source = ./../hypr/wallpaper/line.jpg;
    "hypr/wallpaper/minimal.jpg".source = ./../hypr/wallpaper/minimal.jpg;
    "hypr/wallpaper/mio.jpg".source = ./../hypr/wallpaper/mio.jpg;
    "hypr/wallpaper/mountains.jpg".source = ./../hypr/wallpaper/mountains.jpg;
    "hypr/wallpaper/purple.jpg".source = ./../hypr/wallpaper/purple.jpg;
    "hypr/wallpaper/red.jpg".source = ./../hypr/wallpaper/red.jpg;
    "hypr/wallpaper/simple_green.jpg".source = ./../hypr/wallpaper/simple_green.jpg;
    "hypr/wallpaper/soft_color.jpg".source = ./../hypr/wallpaper/soft_color.jpg;
    "hypr/wallpaper/yellow.jpg".source = ./../hypr/wallpaper/yellow.jpg;

    # Active theme (forceCopy so switch_theme.sh can overwrite at runtime)
    "hypr/theme.conf" = {
      text = themeConf cfg.theme currentTheme;
      forceCopy = true;
    };
    "hypr/theme.lua" = {
      text = genThemeLua currentTheme;
      forceCopy = true;
    };
  };
}
