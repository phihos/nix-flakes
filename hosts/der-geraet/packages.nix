{
  config,
  pkgs,
  inputs,
  ...
}: {
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
    black
    dig
    distrobox
    docker-compose
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
    helmfile
    inetutils
    inputs.nix-software-center.packages.${system}.nix-software-center
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    krew
    kubectl
    kubectx
    kubelogin-oidc
    kubernetes-helm
    kubernetes-helmPlugins.helm-diff
    kubernetes-helmPlugins.helm-secrets
    kubetail
    libvirt
    lsof
    nethogs
    networkmanager-openvpn
    nix-index
    nix-output-monitor
    openssl
    pciutils
    pdk
    pika-backup
    poetry
    pstree
    ruby
    rubyPackages.ffi
    slack
    usbutils
    vagrant
    vim
    virt-manager
    wget
    yubioath-flutter
    zoom-us
    inputs.alejandra.defaultPackage.${system}
    (vscode-with-extensions.override {
      vscodeExtensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        bbenoist.nix
        eamodio.gitlens
        k--kato.intellij-idea-keybindings
        kamadorueda.alejandra
        ms-azuretools.vscode-docker
        ms-python.python
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        puppet.puppet-vscode
        val.vscode-continue-inline-comments
      ];
    })

    # dev libs
    pkgs.openldap.dev
    pkgs.cyrus_sasl.dev
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
  virtualisation.docker.enable = true;
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
  ];
}
