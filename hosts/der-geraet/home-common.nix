{
  config,
  pkgs,
  lib,
  ...
}: {
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {autoSetupRemote = true;};
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
    };
  };
  # add .gitconfig since some tools like devcontainer rely on that file
  home.file = {
    ".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/git/config";
  };

  nixpkgs.config.allowUnfree = true;
  programs.vscode = {
    enable = true;
    userSettings = {
      "explorer.confirmDelete" = false;
      "files.autoSave" = "afterDelay";
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "git.autoStash" = true;
      "git.allowForcePush" = true;
      "git.fetchOnPull" = true;
      "git.mergeEditor" = true;
      "git.pullBeforeCheckout" = true;
      "editor.formatOnSave" = true;
    };
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      eamodio.gitlens
      james-yu.latex-workshop
      k--kato.intellij-idea-keybindings
    ];
  };

  services.gnome-keyring.components = ["pkcs11" "secrets"];
  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "utcclock@injcristianrojas.github.com"
      ];
    };
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 2;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "LEFT";
      dock-fixed = true;
      extend-height = true;
      show-icons-emblems = false;
      scroll-action = "cycle-windows";
      custom-theme-shrink = true;
      apply-custom-theme = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Console";
      binding = "<Control><Alt>t";
      command = "kgx";
    };
  };

  home.sessionVariables = {
    EDITOR = "nano";
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.1password/agent.sock";
    REQUESTS_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
    SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
  };
  systemd.user.sessionVariables = config.home.sessionVariables;
}
