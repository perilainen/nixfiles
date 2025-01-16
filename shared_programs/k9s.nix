{pkgs, ...}: {
  programs.k9s = {
    enable = true;
    # settings = {
    #   k9s = {
    #     clusters = {
    #       app.aurora = {
    #         namespace = {
    #           active = "undertext";
    #         };
    #       };
    #
    #       defaultNamespace = "svt";
    #       dev.aurora = {
    #         namespace = {
    #           active = "undertext";
    #         };
    #       };
    #     };
    #   };
    # };
    hotkey = {
      hotKeys = {
        shift-1 = {
          shortCut = "Shift-1";
          description = "Switch to context app";
          command = "context app.aurora";
        };
      };
    };
  };
}
