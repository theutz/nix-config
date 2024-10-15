{
  pkgs,
  config,
  ...
}: {
  snowfallorg.users = {
    michael = {
      create = true;
      # admin = true;
      home = {
        enable = true;
        config = {};
      };
    };

    oyuncu = {
      create = false;
      # admin = false;
      home = {
        enable = false;
        config = {};
      };
    };
  };

  users.knownUsers = ["oyuncu"];

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

    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
      NSGlobalDomain = {
        AppleShowAllFiles = true;
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleFontSmoothing = 0; # 0, 1, 2
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3; # Full control
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowScrollBars = "WhenScrolling"; # "WhenScrolling", "Always", or "Automatic"
        AppleScrollerPagingBehavior = true; # Jump to the spot that's clicked on the scroll bar
        AppleSpacesSwitchOnActivate = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDisableAutomaticTermination = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 1; # Size of finder sidebar items 1-3 (small-big)
        NSScrollAnimationEnabled = true; # Smooth scrolling
        NSWindowResizeTime = 0.20;
        NSWindowShouldDragOnGesture = true; # Drag anywhere to move window
        InitialKeyRepeat = 8;
        KeyRepeat = 2;
        "com.apple.keyboard.fnState" = true; # Use function keys as F1, F2, ...
        "com.apple.mouse.tapBehavior" = 1; # 1 = tap to click
        "com.apple.trackpad.enableSecondaryClick" = true;
        "com.apple.trackpad.forceClick" = true;
        AppleMetricUnits = 1;
        AppleICUForce24HourTime = true;
        _HIHideMenuBar = true;
      };
    };

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
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

  environment.shells = [pkgs.zsh];
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
