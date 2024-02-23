{ pkgs, ... }:

# Platform-independent terminal setup
{
  # Nix packages to install to $HOME
  #
  # Search for packages here: https://search.nixos.org/packages
  home.packages = with pkgs; [
    # Unix tools
    ripgrep # Better `grep`
    fd
    sd
    lf
    gh
    tree
    xdragon
    pistol
    thunderbird
    tldr
    dtrx

    # Nix dev
    cachix
    nil # Nix language server
    nix-info
    nixpkgs-fmt
    nixci

    # Dev
    just
    lazygit # Better git UI
    tmate

    nix-health

    rofi-power-menu

    rbw
    rofi-rbw
    pavucontrol

    fira-code-nerdfont
    nitrogen
    bitwarden-cli

    # C++
    # cmake
    cmakeCurses
    ccache
    ninja

    #monitor
    arandr

    zotero
    droidcam

    openconnect
    vpnc-scripts
    #python
    conda
  ];

  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    cat = "bat";
  };

  services.copyq.enable = true;

  # Programs natively supported by home-manager.
  programs = {
    bat.enable = true;
    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    nix-index.enable = true;
    
    gh = {
      enable = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
      };
      gitCredentialHelper.enable = true;
    };

    btop.enable= true;
    eza = {
      enable = true;
      enableAliases = true;
    };

    autorandr.enable = true;
    rofi = {
      enable = true;
      plugins = [
        pkgs.rofi-power-menu
        pkgs.rofi-rbw
      ];
    };
    carapace = {
      enable = true;
      enableFishIntegration = true;
    };

    k9s.enable = true;


    # on macOS, you probably don't need this
    bash = {
      enable = true;
      initExtra = ''
        # Make Nix and home-manager installed things available in PATH.
        export BW_SESSION=$(cat /home/ls/.bwsession)
        export PATH=/home/ls/.cargo/bin:/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        ${pkgs.fish}/bin/fish
      '';
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        if [ $(tty) = "/dev/tty1" ] 
          startx 
        end
      '';
      shellInit = ''
        set fish_greeting
      '';
    };

    # https://zero-to-flakes.com/direnv
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # https://nixos.asia/en/git
    git = {
      enable = true;
      userName = "Lukas Schwerdtfeger";
      userEmail = "lukas.schwerdtfeger@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
