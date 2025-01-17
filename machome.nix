{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.file.".config/lvim.config.lua".source = ./config/lvim/config.lua;
}
