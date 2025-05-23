# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.

  services.flatpak.enable = true;
  services.input-remapper.enable = true;
  # Enable the GNOME Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "none+awesome";
  # services.xserver.desktopManager.gnome.enable = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
      gnome.enable = true;
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
        luadbi-mysql
      ];
    };
  };
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us,se";
    xkb.variant = "";
    xkb.options = "caps:escape";
  };
  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;

  systemd.services.vmtoolsd = {
    description = "VMware Tools Daemon";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/vmtoolsd";
      Restart = "always";
    };
  };
  #fileSystems."/mnt/perjohansson" = {
  #  device = ".host:/";
  #  fsType = "fuse.vmhgfs-fuse";
  #  options = [ "rw" "allow_other"];
  #};

  virtualisation.vmware.guest.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  virtualisation.docker.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.perj = {
    isNormalUser = true;
    description = "Per Johansson";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
    packages = with pkgs; [
      vim
      #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;
  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "perj";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.systemPackages = with pkgs; [
    (pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags =
        oldAttrs.mesonFlags
        ++ ["-Dexperimental=true"];
    }))
    git
    # nerd-fonts.fira-code
    # nerd-fonts.iosevka-term-slab
    # nerd-fonts.symbols-only
    # font-awesome
    # openconnect
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-emoji
    fish
    rustup
    (python3.withPackages (p:
      with p; [
        pip
        virtualenv
      ]))
    ripgrep
    wayland
    waybar
    dunst
    rofi-wayland
    libnotify
    swww
    copyq
    cliphist
    wl-clipboard
    ninja
    cmake
    vim
    open-vm-tools
    git

    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];
  programs.fish.enable = true;
  # fonts.fontDir.enable = true;

  # fonts.packages = with pkgs; [
  #   noto-fonts
  #   noto-fonts-cjk-sans
  #   noto-fonts-emoji
  #   liberation_ttf
  #   fira-code
  #   fira-code-symbols
  #   mplus-outline-fonts.githubRelease
  #   dina-font
  #   proggyfonts
  # ];
  programs.hyprland = {
    enable = true;
    # xwayland.enable = true;
    # nvidiaPatches = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  hardware = {
    graphics = {enable = true;};
    # nvidia.modesetting.enable = true;
  };
  xdg.portal.enable = true;
  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
