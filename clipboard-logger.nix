{
  config,
  lib,
  pkgs,
  ...
}: let
  loggerScript = pkgs.writeShellScript "clipboard-logger" ''
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

  plistContents = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
     "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>com.user.clipboardlogger</string>
      <key>ProgramArguments</key>
      <array>
        <string>${loggerScript}</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>/tmp/clipboardlogger.out</string>
      <key>StandardErrorPath</key>
      <string>/tmp/clipboardlogger.err</string>
    </dict>
    </plist>
  '';

  launchAgentPlist = pkgs.writeText "com.user.clipboardlogger.plist" plistContents;
in {
  options.services.clipboardLogger = {
    enable = lib.mkEnableOption "Clipboard logger using launchd on macOS";
  };

  config = lib.mkIf config.services.clipboardLogger.enable {
    home.packages = [pkgs.coreutils];

    home.file."bin/clipboard-logger.sh".source = loggerScript;
    home.file."Library/LaunchAgents/com.user.clipboardlogger.plist".source = launchAgentPlist;

    home.activation.reloadClipboardLogger = lib.hm.dag.entryAfter ["writeBoundary"] ''
      /bin/launchctl unload "$HOME/Library/LaunchAgents/com.user.clipboardlogger.plist" 2>/dev/null || true
      /bin/launchctl load "$HOME/Library/LaunchAgents/com.user.clipboardlogger.plist"
    '';
  };
}
