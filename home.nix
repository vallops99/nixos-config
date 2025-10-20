{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "vallops";
  home.homeDirectory = lib.mkForce "/home/vallops";

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  home.file = {
    ".config/helix/themes/nightwolf.toml".text =
      builtins.readFile "${inputs.self}/nightwolf-helix-theme.toml";
  };

  imports = [ ./helix.nix ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # archives
    zip
    unzip

    # utils
    git
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    fd
    joplin-desktop
    realvnc-vnc-viewer
    postman
    git-graph
    xclip
    xsel

    # productivity
    glow # markdown previewer in terminal
    zellij

    zenith # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    ctop # container monitoring

    # Nix related
    nixfmt-rfc-style

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # IDE
    helix
    code-cursor
    nodePackages.prettier # generic formatter

    # Chats
    vesktop
    slack

    # Terminal
    ghostty

    # Safe
    bitwarden-desktop

    spotify
    rpi-imager
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Valerio Farrotti";
    userEmail = "valerio.farrotti@gmail.com";
    extraConfig = {
      url = {
        "ssh://git@bitbucket.org/" = {
          insteadOf = [ "https://bitbucket.org/" ];
        };
      };
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 12;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    shellAliases = {
      dcka = "docker container kill $(docker container ls | awk '{print $1}')";
      dska = "docker stack rm $(docker stack ls | awk '{print $1}')";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
