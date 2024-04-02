{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Search "programs.<name>" https://search.nixos.org/options before.
  environment.systemPackages = with pkgs; [
    adwaita-qt
    git-crypt
    gnome.gnome-tweaks
    gnome.networkmanager-openvpn
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.utcclock
    helmfile
    inputs.nix-software-center.packages.${system}.nix-software-center
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
    krew
    kubectl
    kubernetes-helm
    kubernetes-helmPlugins.helm-diff
    kubernetes-helmPlugins.helm-secrets
    kubetail
    libvirt
    nethogs
    networkmanager-openvpn
    nix-output-monitor
    openssl
    pciutils
    pdk
    pika-backup
    poetry
    ruby
    rubyPackages.ffi
    slack
    vagrant
    vim
    virt-manager
    wget
    yubioath-flutter
    zoom-us
    inputs.alejandra.defaultPackage.${system}
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        kamadorueda.alejandra
        ms-azuretools.vscode-docker
        ms-python.python
        ms-vscode-remote.remote-ssh
      ];
    })
  ];

  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["phil"];
  programs._1password.enable = true;
  programs.firefox.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
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
}
