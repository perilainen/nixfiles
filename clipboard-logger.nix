{ config, lib, pkgs, ... }:

with lib;

let
  clipboardLoggerScript = pkgs.writeShellScript "clipboard-logger" ''
    mkdir -p "$HOME/.clipboard-history"
    last_clip_file="$HOME/.clipboard-history/.last_clip"

    while true; do
      current_clip=$(pbpaste)

      if [[ -n "$current_clip" ]]; then
        if [[ ! -f "$last_clip_file" ]] || [[ "$current_clip" != "$(cat "$last_clip_file")" ]]; then
          echo "$current_clip" > "$last_clip_file"
          echo "$current_clip" > "$HOME/.clipboard-history/clip_$(date +%s).txt"
        fi
      fi

      sleep 5
    done
  '';
in
{
  options.services.clipboardLogger = {
    enable = mkEnableOption "Enable clipboard history logging for macOS";
  };

  config = mkIf config.services.clipboardLogger.enable {
    systemd.user.services.clipboard-logger = {
      Unit = {
        Description = "Clipboard history logger for macOS";
      };

      Service = {
        ExecStart = "${clipboardLoggerScript}";
        Restart = "always";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
