{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # bottom
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
