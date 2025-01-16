{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
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
