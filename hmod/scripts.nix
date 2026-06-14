{ config, lib, pkgs, ... }: with lib; let cfg = config.dotfiles; in mkIf cfg.enable {
  home.packages = [
    # battery_mode.sh
    (pkgs.writeShellScriptBin "battery_mode.sh" ''
      CONFIG="$HOME/.config/hypr/modules/look_and_feel.conf"
      START="### BEST BATTERY LIFE ###"
      END="### MONITORS ###"
      MONITOR_INFO=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true)')
      MONITOR=$(echo "$MONITOR_INFO" | jq -r '.name')
      WIDTH=$(echo "$MONITOR_INFO" | jq -r '.width')
      HEIGHT=$(echo "$MONITOR_INFO" | jq -r '.height')
      RES="${WIDTH}x${HEIGHT}"
      POS="$(echo "$MONITOR_INFO" | jq -r '.x')x$(echo "$MONITOR_INFO" | jq -r '.y')"
      SCALE=$(echo "$MONITOR_INFO" | jq -r '.scale')
      enable_battery() {
          sed -i "/$START/,/$END/ { /$START/! { /$END/! s/^#[[:space:]]*// } }" "$CONFIG"
          hyprctl keyword monitor "$MONITOR,$RES@120,$POS,$SCALE,vrr,1"
          hyprctl eval 'hl.config({ animations = { enabled = false }, decoration = { rounding = 0, shadow = { enabled = false }, blur = { enabled = false } } })'
      }
      disable_battery() {
          sed -i "/$START/,/$END/ { /$START/! { /$END/! { /^[[:space:]]*#/! s/^/#/ } } }" "$CONFIG"
          hyprctl keyword monitor "$MONITOR,$RES@120,$POS,$SCALE,vrr,1"
          hyprctl eval '
          local theme = require("theme")
          hl.config({
              animations = { enabled = true },
              decoration = {
                  rounding = theme.rounding,
                  shadow = { enabled = theme.shadow_enabled },
                  blur = { enabled = theme.blur_enabled }
              }
          })
          ' >> /tmp/battery_mode.log 2>&1
      }
      if sed -n "/$START/,/$END/p" "$CONFIG" | grep -q "^#animations"; then
          enable_battery
      else
          disable_battery
      fi
      quickshell ipc call qsIpc refreshBatteryMode
    '')

    # notify
    (pkgs.writeShellScriptBin "notify" (builtins.readFile ./../bin/notify))

    # spotify_restart.sh
    (pkgs.writeShellScriptBin "spotify_restart.sh" ''
      exec > /tmp/spotify_restart.log 2>&1
      echo "--- Spotify Restart Started at $(date) ---"
      pkill -9 -x spotify
      sleep 3
      systemd-run --user --unit=spotify-restart-$(date +%s) \
        --description="Spotify from Shell" spotify \
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland \
        --force-device-scale-factor=2 > /dev/null 2>&1
      sleep 2
      for i in {1..30}; do
          if playerctl --player=spotify status > /dev/null 2>&1; then
              playerctl --player=spotify play 2>/dev/null
              break
          fi
          sleep 0.5
      done
    '')

    # pack_workspaces.sh
    (pkgs.writeShellScriptBin "pack_workspaces.sh" (builtins.readFile ./../hypr/scripts/pack_workspaces.sh))

    # start_zen_bg.sh
    (pkgs.writeShellScriptBin "start_zen_bg.sh" (builtins.readFile ./../hypr/scripts/start_zen_bg.sh))

    # ricesync - only kept as reference, no-op in Nix
    (pkgs.writeShellScriptBin "ricesync" ''
      echo "ricesync is not needed in NixOS - use home-manager rebuild instead."
    '')

    # switch_theme.sh - runtime theme switching
    (pkgs.writeShellScriptBin "switch_theme.sh" ''
      set -e
      THEME_NAME="''${1:-}"
      if [ -z "$THEME_NAME" ]; then
        THEME_NAME=$(ls "$HOME/.config/hypr/themes/"*.conf 2>/dev/null | xargs -n 1 basename | sed 's/\.conf//' | tofi --prompt-text " Tema: ")
      fi
      [ -z "$THEME_NAME" ] && exit 0
      THEME_FILE="$HOME/.config/hypr/themes/$THEME_NAME.conf"
      [ ! -f "$THEME_FILE" ] && echo "Theme $THEME_NAME not found" && exit 1

      cp "$THEME_FILE" "$HOME/.config/hypr/theme.conf"

      # Extract theme variables
      while IFS='=' read -r key value; do
        [[ $key =~ ^\$ ]] || continue
        var_name="$(echo "${key//\$/}" | xargs)"
        var_value="$(echo "$value" | xargs)"
        export "$var_name=$var_value"
      done < "$THEME_FILE"

      ACTIVE_COLORS=$(echo "$active_border" | grep -o "rgba([^)]*)" | sed 's/^/"/;s/$/"/' | paste -sd, -)
      ACTIVE_ANGLE=$(echo "$active_border" | grep -o "[0-9]\+deg" | sed 's/deg//' || echo 45)
      cat > "$HOME/.config/hypr/theme.lua" << LUA
      return {
          gaps_in = $gaps_in,
          gaps_out = $gaps_out,
          border_size = $border_size,
          active_border = { colors = { $ACTIVE_COLORS }, angle = $ACTIVE_ANGLE },
          inactive_border = "$inactive_border",
          rounding = $rounding,
          rounding_power = $rounding_power,
          active_opacity = $active_opacity,
          inactive_opacity = $inactive_opacity,
          shadow_enabled = $( [[ "$shadow_enabled" == "true" ]] && echo "true" || echo "false" ),
          shadow_range = $shadow_range,
          shadow_render_power = $shadow_render_power,
          shadow_color = "$shadow_color",
          blur_enabled = $( [[ "$blur_enabled" == "true" ]] && echo "true" || echo "false" ),
          blur_size = $blur_size,
          blur_passes = $blur_passes,
          blur_vibrancy = $blur_vibrancy,
      }
      LUA

      WALLPAPER=${wallpaper:-}
      ACCENT=${accent_color:-"#ffffff"}
      BG=${bg_color:-"#000000"}
      FG=${fg_color:-"#ffffff"}

      if [[ "$THEME_NAME" == "nero" || "$THEME_NAME" == "black" || "$THEME_NAME" == "earth" || "$THEME_NAME" == "minimal" ]]; then
          ACCENT="#ffffff" ; BG="#000000" ; FG="#ffffff"
      fi

      for CONFIG in "config" "configpowermenu"; do
        mkdir -p "$HOME/.config/tofi"
        cat > "$HOME/.config/tofi/$CONFIG" << TOFI
      anchor = top
      width = 100%
      height = $( [ "$CONFIG" = "config" ] && echo 25 || echo 30 )
      horizontal = true
      font-size = 10
      prompt-text = " $( [ "$CONFIG" = "config" ] && echo "run:" || echo "Action:" ) "
      font = JetBrainsMono Nerd Font
      outline-width = 0
      border-width = 0
      min-input-width = 120
      result-spacing = 25
      padding-top = 5
      padding-bottom = 5
      padding-left = 10
      padding-right = 10
      background-color = $BG
      text-color = $FG
      selection-color = ''${TOFI_SEL:-$ACCENT}
      selection-background = #00000000
      TOFI
      done

      mkdir -p "$HOME/.config/waybar"
      printf "@define-color accent %s;\n@define-color bg %s;\n@define-color fg %s;\n" "$ACCENT" "$BG" "$FG" > "$HOME/.config/waybar/theme.css"
      mkdir -p "$HOME/.config/kitty" "$HOME/.config/ghostty" "$HOME/.config/foot"
      cat > "$HOME/.config/kitty/theme.conf" << KITTY
      foreground $FG
      background $BG
      cursor $ACCENT
      KITTY
      cat > "$HOME/.config/ghostty/theme" << GHOSTTY
      foreground = $FG
      background = $BG
      cursor-color = $ACCENT
      GHOSTTY
      FOOT_BG=$(echo "$BG" | sed 's/#//')
      FOOT_FG=$(echo "$FG" | sed 's/#//')
      cat > "$HOME/.config/foot/theme" << FOOT
      [colors-dark]
      foreground=$FOOT_FG
      background=$FOOT_BG
      selection-foreground=$FOOT_BG
      selection-background=$FOOT_FG
      FOOT

      WALLPAPER="''${WALLPAPER/#\~/$HOME}"
      if [ "$WALLPAPER" != "black" ] && [ -f "$WALLPAPER" ] && [ -n "$WALLPAPER" ]; then
          printf "preload = %s\nwallpaper = ,%s\nsplash = false\nipc = on\n" "$WALLPAPER" "$WALLPAPER" > "$HOME/.config/hypr/hyprpaper.conf"
          pgrep -x "hyprpaper" > /dev/null || hyprpaper &
          sleep 1
          hyprctl hyprpaper preload "$WALLPAPER" > /dev/null 2>&1
          hyprctl hyprpaper wallpaper ",$WALLPAPER" > /dev/null 2>&1
      else
          pkill hyprpaper 2>/dev/null || true
      fi

      killall -SIGUSR2 waybar 2>/dev/null || true
      killall -USR1 kitty 2>/dev/null || true
    '')
  ];
}
