{ config, lib, pkgs, ... }: with lib; let cfg = config.dotfiles; in mkIf cfg.enable {
  # Fix workspace typo: DP-28 -> DP-2
  xdg.configFile."hypr/workspaces.conf".text = ''
    workspace=1,monitor:eDP-1,default:true
    workspace=2,monitor:eDP-1
    workspace=3,monitor:eDP-1
    workspace=4,monitor:eDP-1
    workspace=5,monitor:eDP-1
    workspace=6,monitor:DP-2,default:true
    workspace=7,monitor:DP-2
    workspace=8,monitor:DP-2
    workspace=9,monitor:DP-2
    workspace=10,monitor:DP-2
  '';

  # Static files that need no path processing
  xdg.configFile = {
    "hypr/hyprland.conf".source = ./../hypr/hyprland.conf;
    "hypr/hyprland.lua".source = ./../hypr/hyprland.lua;
    "hypr/hyprlock.conf".source = ./../hypr/hyprlock.conf;
    "hypr/hyprsunset.conf".source = ./../hypr/hyprsunset.conf;
    "hypr/monitors.conf".source = ./../hypr/monitors.conf;

    # Modules (.conf)
    "hypr/modules/env.conf".source = ./../hypr/modules/env.conf;
    "hypr/modules/input.conf".source = ./../hypr/modules/input.conf;
    "hypr/modules/look_and_feel.conf".source = ./../hypr/modules/look_and_feel.conf;
    "hypr/modules/autostart.conf".source = ./../hypr/modules/autostart.conf;
    "hypr/modules/windowrules.conf".source = ./../hypr/modules/windowrules.conf;
    "hypr/modules/keybindings.conf".source = ./../hypr/modules/keybindings.conf;

    # Lua modules (most are static)
    "hypr/lua/env.lua".source = ./../hypr/lua/env.lua;
    "hypr/lua/look_and_feel.lua".source = ./../hypr/lua/look_and_feel.lua;
    "hypr/lua/input.lua".source = ./../hypr/lua/input.lua;
    "hypr/lua/monitors.lua".source = ./../hypr/lua/monitors.lua;
    "hypr/lua/workspaces.lua".source = ./../hypr/lua/workspaces.lua;
    "hypr/lua/windowrules.lua".source = ./../hypr/lua/windowrules.lua;
    "hypr/lua/animations.lua".source = ./../hypr/lua/animations.lua;
    "hypr/lua/permissions.lua".source = ./../hypr/lua/permissions.lua;
    "hypr/lua/programs.lua".source = ./../hypr/lua/programs.lua;
  };

  # autostart.lua: substitute hardcoded /home/matteo paths
  xdg.configFile."hypr/lua/autostart.lua".text = ''
    local programs = require("lua.programs")

    hl.on("hyprland.start", function ()
      hl.exec_cmd("foot --server")

      local zenBgRule = hl.window_rule({
          name = "zen-background-startup",
          match = { class = "zen" },
          workspace = "special:zenbg silent"
      })

      hl.timer(function()
          hl.exec_cmd("zen-browser")
          hl.timer(function()
              zenBgRule:set_enabled(false)
          end, { timeout = 5000, type = "oneshot" })
      end, { timeout = 2000, type = "oneshot" })

      hl.exec_cmd("hyprpaper")
      hl.exec_cmd(programs.bar)
      hl.exec_cmd(programs.rog)
      hl.exec_cmd("wl-paste --type text --watch cliphist store")
      hl.exec_cmd("wl-paste --type image --watch cliphist store")
      hl.exec_cmd("nm-applet --indicator")
      hl.exec_cmd("systemctl --user start hyprpolkitagent")
      hl.exec_cmd("hyprsunset -t 5000")
      hl.exec_cmd("${cfg.homeDir}/.config/hypr/scripts/switch_theme.sh ${cfg.theme}")
      hl.exec_cmd("rm -f $XDG_RUNTIME_DIR/wob.fifo && mkfifo $XDG_RUNTIME_DIR/wob.fifo")
      hl.exec_cmd("cliphist list | tail -n +501 | cliphist delete")
    end)
  '';

  # keybindings.lua: substitute paths
  xdg.configFile."hypr/lua/keybindings.lua".text = ''
    local p = require("lua.programs")
    local mainMod = "SUPER"

    -- Basic binds
    hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(p.terminal))
    hl.bind(mainMod .. " + C", hl.dsp.window.close())
    hl.bind(mainMod .. " + M", hl.dsp.exit())
    hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
    hl.bind(mainMod .. " + SHIFT + Space", function()
        hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
        hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, relative = false }))
        hl.dispatch(hl.dsp.window.center())
    end)
    hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(p.fileManager))
    hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("nautilus"))
    hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("quickshell ipc call qsIpc toggleClipboard"))
    hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("quickshell ipc call qsIpc toggleControlCenter"))
    hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(p.menu))
    hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
    hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
    hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(p.browser))
    hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(p.note))
    hl.bind("F6", hl.dsp.exec_cmd(p.screenshot))
    hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(p.powermenu))
    hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd(p.lock))
    hl.bind(mainMod .. " + SHIFT + F12", hl.dsp.exec_cmd("brightnessctl s 0"))
    hl.bind("XF86Launch1", hl.dsp.exec_cmd(p.rog))
    hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("quickshell ipc call qsIpc toggleThemeSwitcher"))
    hl.bind("mouse:277", hl.dsp.window.close())
    local battery_mode = false
    hl.bind(mainMod .. " + B", function()
        battery_mode = not battery_mode
        if battery_mode then
            hl.config({
                animations = { enabled = false },
                decoration = {
                    rounding = 0,
                    shadow = { enabled = false },
                    blur = { enabled = false }
                }
            })
        else
            local theme = require("theme")
            hl.config({
                animations = { enabled = true },
                decoration = {
                    rounding = theme.rounding,
                    shadow = { enabled = theme.shadow_enabled },
                    blur = { enabled = theme.blur_enabled }
                }
            })
        end
        hl.exec_cmd("${cfg.homeDir}/.local/bin/battery_mode.sh")
    end)

    -- Workspace Packing
    hl.bind(mainMod .. " + A", function()
        local workspaces = hl.get_workspaces()
        local windows = hl.get_windows()
        local active_ws = hl.get_active_workspace()
        if not workspaces or not windows or not active_ws then return end
        local active_ids = {}
        for _, ws in pairs(workspaces) do
            if ws.id and ws.id > 0 and ws.windows and ws.windows > 0 then
                table.insert(active_ids, ws.id)
            end
        end
        table.sort(active_ids)
        local target = 1
        local curr_ws_id = active_ws.id
        local new_active_ws_id = curr_ws_id
        for _, ws_id in ipairs(active_ids) do
            if ws_id ~= target then
                for _, win in pairs(windows) do
                    if win.workspace and win.workspace.id == ws_id then
                        hl.dispatch(hl.dsp.window.move({ workspace = target, follow = false, window = win }))
                    end
                end
                if ws_id == curr_ws_id then new_active_ws_id = target end
            end
            target = target + 1
        end
        hl.dispatch(hl.dsp.focus({ workspace = new_active_ws_id }))
    end)

    -- Movement
    hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
    hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
    hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
    hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

    -- Resize
    hl.bind("ALT + right", hl.dsp.window.resize({ x = 30,  y = 0,  relative = true }), { repeating = true })
    hl.bind("ALT + left",  hl.dsp.window.resize({ x = -30, y = 0,  relative = true }), { repeating = true })
    hl.bind("ALT + up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
    hl.bind("ALT + down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })

    -- Workspaces
    hl.bind(mainMod .. " + Space", hl.dsp.focus({ workspace = "empty" }))
    for i = 1, 10 do
        local key = i % 10
        hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
        hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    end
    hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    -- Mouse
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- Media
    hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+ && quickshell ipc call qsIpc showOsd V $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o '[0-9.]*' | awk '{print $1 * 100}')"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- && quickshell ipc call qsIpc showOsd V $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o '[0-9.]*' | awk '{print $1 * 100}')"), { locked = true, repeating = true })
    hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && quickshell ipc call qsIpc showOsd V $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED' && echo 0 || wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o '[0-9.]*' | awk '{print $1 * 100}')"), { locked = true })
    hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl s 5%+ | grep -oP '\\(\\K[^%]+' | xargs -I {} quickshell ipc call qsIpc showOsd B {}"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl s 5%- | grep -oP '\\(\\K[^%]+' | xargs -I {} quickshell ipc call qsIpc showOsd B {}"), { locked = true, repeating = true })
    hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
    hl.bind(mainMod .. " + XF86AudioMicMute", hl.dsp.exec_cmd("${cfg.homeDir}/.local/bin/spotify_restart.sh"),   { locked = true })

    hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
    hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

    -- Switch
    hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
    hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
  '';

  # hyprpaper.conf needs proper wallpaper path
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${cfg.homeDir}/.config/hypr/wallpaper/${cfg.theme}.jpg
    wallpaper = ,${cfg.homeDir}/.config/hypr/wallpaper/${cfg.theme}.jpg
    splash = false
    ipc = on
  '';
}
