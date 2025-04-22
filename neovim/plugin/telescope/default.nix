{
  telescope = {
    enable = false;
    extensions.fzf-native.enable = true;
    settings.defaults.layout_config.vertical.height = 0.5;
    keymaps = {
      "<leader>st" = "live_grep";
      "<leader>sf" = "find_files";
      "<leader>sb" = "buffers";
    };
  };
}
