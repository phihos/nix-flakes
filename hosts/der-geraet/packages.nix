{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages-kubernetes-helm.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope (gfinal: gprev: {
        gnome-keyring = gprev.gnome-keyring.overrideAttrs (oldAttrs: {
          configureFlags =
            oldAttrs.configureFlags
            or []
            ++ [
              "--disable-ssh-agent"
            ];
        });
      });
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Search "programs.<name>" https://search.nixos.org/options before.
  environment.systemPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    adwaita-qt
    alejandra
    config.boot.kernelPackages.perf
    black
    dig
    distrobox
    docker-compose
    fzf
    gcc
    git-crypt
    gnome.gnome-tweaks
    gnome.networkmanager-openvpn
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.utcclock
    gnumake
    grpc_cli
    grpcurl
    helmfile
    htop
    inetutils
    inputs.nix-software-center.packages.${system}.nix-software-center
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.phpstorm
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    krew
    kubectl
    kubectx
    kubelogin-oidc
    kubetail
    libvirt
    lsof
    meld
    mitmproxy
    nethogs
    networkmanager-openvpn
    nix-index
    nix-output-monitor
    nodejs
    openssl
    pciutils
    pdk
    pika-backup
    poetry
    postgresql
    pstree
    ruby
    rubyPackages.ffi
    slack
    texlive.combined.scheme-full
    usbutils
    vagrant
    vault
    vim
    virt-manager
    wget
    yubioath-flutter
    zoom-us
    (vscode-with-extensions.override {
      vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        bbenoist.nix
        eamodio.gitlens
        james-yu.latex-workshop
        k--kato.intellij-idea-keybindings
        kamadorueda.alejandra
        ms-azuretools.vscode-docker
        ms-python.python
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        puppet.puppet-vscode
        val.vscode-continue-inline-comments
        redhat.vscode-yaml
        yzhang.markdown-all-in-one
      ];
    })
  ];

  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["phil"];
  programs._1password.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = false;
  programs.iftop.enable = true;
  programs.mtr.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.virt-manager.enable = true;
  programs.wireshark.enable = true;
  programs.yubikey-touch-detector.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    zsh-autoenv.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "npm"
        "history"
        "rust"
        "docker"
        "kubectx"
        "poetry"
      ];
    };
  };
  virtualisation.docker.enable = true;
  virtualisation.docker.package = pkgs.docker_26;
  virtualisation.libvirtd.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

    # Jetbrains remote development
    fontconfig.lib
    freetype
    jetbrains.jdk
    libz
    vcpkg
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.libXtst

    # Ruby bundler
    libffi

    # ldap libs
    pkgs.openldap.dev
    pkgs.cyrus_sasl.dev

    # grpc
    libgcc
  ];
}
