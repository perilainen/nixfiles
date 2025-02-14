{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      sketchybar
      sketchybar-app-font
      # bottom
      # jq
    ];
  };
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        temperature_type = "c";
      };
    };
  };
}
