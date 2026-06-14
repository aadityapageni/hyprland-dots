# Fork from `https://github.com/matteogini/dotfiles`



<h1 align="center">☁️ Hyprland Dotfiles</h1>

<p align="center">A feature-rich, beautiful, and highly functional Linux setup centered around <b>Hyprland</b> and <b>Quickshell</b>.</p>

<div align="center">

![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=for-the-badge)
![Hyprland](https://img.shields.io/badge/Hyprland-00A98F?logo=hyprland&logoColor=fff&style=for-the-badge)
![Fish](https://img.shields.io/badge/Fish-000?logo=fish&logoColor=fff&style=for-the-badge)
![Quickshell](https://img.shields.io/badge/Quickshell-5E5C64?style=for-the-badge)

</div>

https://github.com/user-attachments/assets/0529881d-1ff8-4aa2-973a-c108f8b27c02


## ✨ Features

- **Window Manager**: [Hyprland](https://hyprland.org/) - A dynamic tiling Wayland compositor that doesn't sacrifice on its looks.
- **Shell Interface**: [Quickshell](https://quickshell.com/) - A robust custom top bar with IPC, an integrated control center, Pomodoro timer, battery power mode switching, and an On-Screen Display (OSD).
- **Terminal Emulators**: Configured for [Kitty](https://sw.kovidgoyal.net/kitty/), [Foot](https://codeberg.org/dnkl/foot), and [Ghostty](https://github.com/mitchellh/ghostty).
- **Application Launcher**: [Tofi](https://github.com/philj56/tofi) - Minimalist and fast launcher for apps, power menu, and Wi-Fi networks.
- **Shell**: [Fish](https://fishshell.com/) - With custom prompts, frozen key bindings, and useful aliases.
- **Theming System**: Easily switch between 15+ built-in themes via custom scripts and `supergfxctl` GPU management tools.
- **System Fetch**: [Fastfetch](https://github.com/fastfetch-cli/fastfetch)

## 📸 Overview


<details>
<summary><b>Click to expand screenshots</b></summary>

| Clean Desktop | Tiled Windows |
| :---: | :---: |
| <img src="preview/desktop.png" width="400"/> | <img src="preview/windows.png" width="400"/> |

| Terminal & Fetch | Fullscreen Window |
| :---: | :---: |
| <img src="preview/terminal.png" width="400"/> | <img src="preview/window_fullscreen.png" width="400"/> |

| Control Center | App Launcher |
| :---: | :---: |
| <img src="preview/control_center.png" width="400"/> | <img src="preview/launcher.png" width="400"/> |

| Theme: Soft Color | Theme: Mountains |
| :---: | :---: |
| <img src="preview/soft_color.png" width="400"/> | <img src="preview/mountains.png" width="400"/> |

| Theme Switcher | Clipboard Manager |
| :---: | :---: |
| <img src="preview/themes.png" width="400"/> | <img src="preview/clipboard.png" width="400"/> |

| OSD Volume | OSD Brightness |
| :---: | :---: |
| <img src="preview/volume.png" width="400"/> | <img src="preview/brightness.png" width="400"/> |

| Power Menu | Performance Mode |
| :---: | :---: |
| <img src="preview/powermenu.png" width="400"/> | <img src="preview/performance_mode.png" width="400"/> |

</details>

The setup relies heavily on **Quickshell** written in QML, which acts as the main shell and control center. It includes:
- Live indicators for Battery, Brightness, Audio, Mic, and Bluetooth
- Quick toggles for Pomodoro, Stopwatch, and integrated Notes/Config Editor
- Workspaces tracking and integrated OSDs
- GPU mode switcher (Integrated / Hybrid) via `supergfxctl`

## 🛠️ Usage

### Theme Switcher
You can change the theme on the fly using the built-in script:
```bash
./hypr/scripts/switch_theme.sh <theme_name>
```

### Scripts & Utilities
- `battery_mode.sh`: Toggles power-saving mode (disables animations to save battery).
- `tofi-wifi.sh`: Tofi-based GUI to easily connect to open and secured Wi-Fi networks.
- `amd_s2idle.py`: Advanced AMD debugging script for suspend issues.
- `gacp`: Fish alias to quickly add, commit, and push updates.

## ⌨️ Keyboard Shortcuts

All shortcuts use <kbd>SUPER</kbd> (Windows/Meta key) unless noted.

### Launchers & Apps

| Key | Action |
|-----|--------|
| <kbd>SUPER</kbd> + <kbd>Q</kbd> | Open terminal (footclient) |
| <kbd>SUPER</kbd> + <kbd>E</kbd> | File manager (yazi via foot) |
| <kbd>SUPER</kbd> + <kbd>W</kbd> | Open browser (Zen) |
| <kbd>SUPER</kbd> + <kbd>R</kbd> | App launcher (Quickshell) |
| <kbd>SUPER</kbd> + <kbd>O</kbd> | Open Obsidian notes |
| <kbd>SUPER</kbd> + <kbd>V</kbd> | Clipboard manager (Quickshell) |
| <kbd>SUPER</kbd> + <kbd>Z</kbd> | Control Center (Quickshell) |
| <kbd>SUPER</kbd> + <kbd>T</kbd> | Theme switcher (Quickshell) |
| <kbd>SUPER</kbd> + <kbd>N</kbd> | Power menu (Quickshell) |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>E</kbd> | Nautilus file manager |
| <kbd>F6</kbd> | Screenshot region (grim+slurp) |
| <kbd>XF86Launch1</kbd> | ROG Control Center |

### Window Management

| Key | Action |
|-----|--------|
| <kbd>SUPER</kbd> + <kbd>C</kbd> | Close active window |
| <kbd>SUPER</kbd> + <kbd>F</kbd> | Toggle fullscreen |
| <kbd>SUPER</kbd> + <kbd>M</kbd> | Exit Hyprland |
| <kbd>SUPER</kbd> + <kbd>P</kbd> | Toggle pseudo-tiling |
| <kbd>SUPER</kbd> + <kbd>J</kbd> | Toggle split layout |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>Space</kbd> | Toggle float + resize + center |
| <kbd>SUPER</kbd> + <kbd>B</kbd> | Toggle battery saver (disables animations) |
| <kbd>SUPER</kbd> + <kbd>A</kbd> | Pack workspaces (re-number to 1,2,3…) |
| <kbd>mouse:277</kbd> | Close window (side button) |

### Focus & Movement

| Key | Action |
|-----|--------|
| <kbd>SUPER</kbd> + <kbd>←→↑↓</kbd> | Move focus between windows |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>←→↑↓</kbd> | Move window in direction |
| <kbd>ALT</kbd> + <kbd>←→↑↓</kbd> | Resize window (hold to repeat) |
| <kbd>SUPER</kbd> + <kbd>mouse:272</kbd> | Drag window |
| <kbd>SUPER</kbd> + <kbd>mouse:273</kbd> | Resize window |

### Workspaces

| Key | Action |
|-----|--------|
| <kbd>SUPER</kbd> + <kbd>1–0</kbd> | Switch to workspace 1–10 |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>1–0</kbd> | Move window to workspace 1–10 |
| <kbd>SUPER</kbd> + <kbd>Space</kbd> | Focus empty workspace |
| <kbd>SUPER</kbd> + <kbd>S</kbd> | Toggle special workspace (magic) |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>S</kbd> | Move window to special workspace |
| <kbd>SUPER</kbd> + <kbd>scroll</kbd> | Cycle through workspaces |

### Media & Hardware

| Key | Action |
|-----|--------|
| <kbd>XF86AudioRaiseVolume</kbd> | Volume up (shows OSD) |
| <kbd>XF86AudioLowerVolume</kbd> | Volume down (shows OSD) |
| <kbd>XF86AudioMute</kbd> | Toggle mute (shows OSD) |
| <kbd>XF86AudioMicMute</kbd> | Toggle mic mute |
| <kbd>XF86MonBrightnessUp</kbd> | Brightness up (shows OSD) |
| <kbd>XF86MonBrightnessDown</kbd> | Brightness down (shows OSD) |
| <kbd>XF86AudioNext/Pause/Play/Prev</kbd> | Media playback control |
| <kbd>SUPER</kbd> + <kbd>XF86AudioRaiseVolume</kbd> | Next track |
| <kbd>SUPER</kbd> + <kbd>XF86AudioLowerVolume</kbd> | Previous track |
| <kbd>SUPER</kbd> + <kbd>XF86AudioMicMute</kbd> | Restart Spotify |
| <kbd>SUPER</kbd> + <kbd>F12</kbd> | Lock screen |
| <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>F12</kbd> | Screen off (brightness 0) |
| <kbd>Lid Switch</kbd> | Lock on lid close/open |

## ⚙️ Structure

```text
.
├── bin/          # Custom scripts and binaries
├── fastfetch/    # Fastfetch config
├── fish/         # Fish shell config and functions
├── foot/         # Foot terminal config
├── ghostty/      # Ghostty terminal config
├── hypr/         # Hyprland configs, modules, themes, and scripts
├── kitty/        # Kitty terminal config
├── nano/         # Nano editor config
├── preview/      # UI screenshots and previews
├── quickshell/   # QML scripts for the main bar and control center
├── tofi/         # Tofi menus (app launcher, wifi, power)
└── waybar/       # (Legacy) Waybar configs
```

## 🚀 Installation

### Arch Linux
1. Ensure the core packages are installed (Hyprland, Quickshell, Fish, Tofi, Kitty, Fastfetch).
2. Clone this repository into your `~/.config` or use the included `ricesync` script to sync the dotfiles.
3. Reload Hyprland or log out and log back in.

> **Note**: This config relies on certain system tools like `brightnessctl`, `playerctl`, `nmcli` (NetworkManager), `bluetoothctl`, `wpctl` (WirePlumber), and `supergfxctl`. Make sure you have them installed for the Control Center to function fully.

### NixOS (via home-manager)

This repo provides a home-manager module. Integrate it into your NixOS config:

**1. Create `/etc/nixos/hypr.nix`** — system-level Hyprland config:

```bash
sudo cp examples/hypr.nix /etc/nixos/hypr.nix
```

This sets up Hyprland, Ly display manager, Wayland packages, portal, and polkit agent.

**2. Update `/etc/nixos/flake.nix`** — add inputs and home-manager module:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Your existing inputs ...

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-dots.url = "github:aadityapageni/hyprland-dots";
  };

  outputs = { self, nixpkgs, home-manager, hyprland-dots, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./hypr.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.wakizu = {
              imports = [ hyprland-dots.homeManagerModules.default ];
              dotfiles = {
                enable = true;
                theme = "minimal";
                useQuickshell = true;
              };
              home = {
                username = "wakizu";
                homeDirectory = "/home/wakizu";
                stateVersion = "25.11";
              };
            };
          };
        }
      ];
    };
  };
}
```

**3. Remove GNOME import** — edit `configuration.nix` and remove `./gnome.nix` from `imports` (or keep both if you want to switch between them).

**4. Deploy:**

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

Nix will automatically fetch and lock the new inputs. On next boot, Ly login → select Hyprland session.

After reboot, Ly will present a login prompt. Log in and Hyprland starts automatically.

See `examples/nixos-flake.nix` for the full reference.

> **Note**: Home-manager handles user-level configs (bash/fish prompts, editor themes, etc.) and dotfiles (hypr, quickshell, tofi). System-level packages (Hyprland, drivers, services) go in `hypr.nix` or `configuration.nix`. Requires `nixpkgs.config.allowUnfree = true` for `asusctl`, `supergfxctl`, etc.
