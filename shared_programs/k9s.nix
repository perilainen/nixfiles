{ pkgs, ... }:
{
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
    # hotkey = {
    hotKeys = {
      shift-1 = {
        shortCut = "Shift-1";
        description = "Switch to context app";
        command = "context app.aurora";
      };
    };
    plugins = {
      bunyan-deploy-logs = {
        shortCut = "Ctrl-B";
        description = "View Deployment logs piped to bunyan";
        scopes = [ "deployments" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          ''
            kubectl logs --context=$CONTEXT -f -l app=$NAME --all-containers | bunyan
          ''
        ];
      };
      bunyan-deploy-logs-history = {
        shortCut = "Ctrl-L";
        description = "View Deployment logs piped to bunyan | less";
        scopes = [ "deployments" ];
        command = "bash";
        background = false;
        args = [
          "-ic"
          ''
            "$@" | bunyan --color | less -R
          ''
          "dummy-arg"
          "kubectl"
          "logs"
          "-f"
          "-l"
          "app=$NAME"
          "-n"
          "$NAMESPACE"
          "--context"
          "$CONTEXT"
          "--all-containers=true"
          "--tail=10000"
        ];
      };
    };
  };
}
