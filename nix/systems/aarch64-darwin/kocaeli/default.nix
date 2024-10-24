{
  pkgs,
  config,
  ...
}: {
  snowfallorg.users = {
    michael = {
      create = true;
      home = {
        enable = true;
        config = {
        };
      };
    };

    oyuncu = {
      create = true;
      home = {
        enable = true;
        config = {
        };
      };
    };
  };

  theutz = {
    home-manager.enable = true;
    homebrew.enable = true;
  };

  users.knownUsers = ["oyuncu"];

  users.users.michael = {
    isHidden = false;
    createHome = true;
    description = "Michael Utz";
    shell = pkgs.zsh;
    uid = 501;
    home = "/Users/michael";
  };

  users.users.oyuncu = {
    isHidden = false;
    createHome = true;
    description = "Oyuncu";
    shell = pkgs.zsh;
    uid = 502;
    home = "/Users/oyuncu";
  };

  system = {
    stateVersion = 5;

    checks = {
      verifyBuildUsers = true;
      verifyNixChannels = true;
      verifyNixPath = false; # not useful with flakes
    };
  };

  services = {
    nix-daemon.enable = true;
  };

  nix = {
    nixPath = {nixpkgs = "flake:nixpkgs";};

    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "michael"];
    };
  };

  environment.shells = [
    pkgs.bashInteractive
    pkgs.zsh
  ];

  environment.systemPackages = with pkgs; [
    tmux
    pam-reattach
    snowfallorg.flake
  ];

  environment = {
    etc."pam.d/sudo_local" = {
      text = ''
        auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
        auth       sufficient     pam_tid.so
      '';
    };
  };

  programs = {
    zsh.enable = true;
  };
}
