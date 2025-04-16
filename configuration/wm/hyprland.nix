{ pkgs, lib, ... }: {
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    swaynotificationcenter
    hyprpaper
    waybar
    wofi
    hypridle
    hyprlock
    hyprshot
    networkmanagerapplet
    kitty
    keepassxc
  ];

  environment.etc."xdg/hypr/hyprlock.conf".text = ''
    background {
      blur_passes=2
      blur_size=7
      brightness=0.800000
      contrast=0.800000
      path=screenshot
    }

    input-field {
      position {
        x=0
        y=-20
      }

      size {
        height=50
        width=200
      }
      dots_center=false
      dots_size=0.330000
      dots_spacing=0.150000
      fade_on_empty=true
      halign=center
      hide_input=false
      outline_thickness=3
      placeholder_text=<i>Input Password...</i>
      valign=center
    }

    label {
      position {
        x=0
        y=80
      }
      color=#c5c8c6
      font_family=Noto Sans
      font_size=50
      halign=center
      text=$TIME
      valign=center
    }
  '';
  environment.etc."xdg/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = pidof hyprlock || hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
    }

    listener {
        timeout = 150
        on-timeout = brightnessctl -s set 10
        on-resume = brightnessctl -r
    }

    listener {
        timeout = 150
        on-timeout = brightnessctl -sd rgb:kbd_backlight set 0
        on-resume = brightnessctl -rd rgb:kbd_backlight
    }

    listener {
        timeout = 300
        on-timeout = loginctl lock-session
    }

    listener {
        timeout = 330
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on && brightnessctl -r
    }

    listener {
        timeout = 1800
        on-timeout = systemctl suspend
    }
  '';

  systemd.user.services.hypridle = {
    description = "Hypridle idle daemon";
    environment.PATH = lib.mkForce (lib.makeSearchPath "bin" [
      pkgs.brightnessctl
      pkgs.hyprland
      pkgs.hyprlock
      pkgs.procps
      pkgs.systemd
    ]);
    serviceConfig = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
    };
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
  };
}
