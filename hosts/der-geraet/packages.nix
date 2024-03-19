{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Search "programs.<name>" https://search.nixos.org/options before.
  environment.systemPackages = with pkgs; [
    pkgs.yubioath-flutter
    inputs.nix-software-center.packages.${system}.nix-software-center
    vim
    wget
    pciutils
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.goland
    jetbrains.ruby-mine
    ruby
    rubyPackages.ffi
    kubectl
    vagrant
    libvirt
    virt-manager
    krew
    kubetail
    slack
    git-crypt
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.utcclock
    networkmanager-openvpn
    gnome.networkmanager-openvpn
    gnomeExtensions.dash-to-dock
    zoom-us
    gnome.gnome-tweaks
    pdk
    inputs.alejandra.defaultPackage.${system}
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        kamadorueda.alejandra
      ];
    })
  ];

  programs.wireshark.enable = true;
  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  programs.yubikey-touch-detector.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  virtualisation.docker.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = ["phil"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
