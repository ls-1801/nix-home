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

    fira-code-nerdfont

  ];

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    g = "git";
    lg = "lazygit";
    cat = "bat";
  };

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

    feh.enable = true;
    autorandr.enable = true;
    rofi.enable = true;
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
        export PATH=/run/current-system/sw/bin/:/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:$PATH
        ${pkgs.fish}/bin/fish
      '';
    };

    fish = {
      enable = true;
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
