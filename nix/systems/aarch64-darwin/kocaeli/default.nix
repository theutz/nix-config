{pkgs, ...}: {
  system = {
    stateVersion = 5;

    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };

      CustomUserPreferences = {
        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };

        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        "com.apple.HIToolbox" = {
          AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.USExtended";
          AppleEnabledInputSources = [
            {
              InputSourceKind = "Keyboard Layout";
              "KeyboardLayout ID" = "-36";
              "KeyboardLayout Name" = "Turkish-QWERTY-PC";
            }
            {
              "Bundle ID" = "com.apple.CharacterPaletteIM";
              InputSourceKind = "Non Keyboard Input Method";
            }
            {
              InputSourceKind = "Keyboard Layout";
              "KeyboardLayout ID" = "-2";
              "KeyboardLayout Name" = "US Extended";
            }
          ];
        };
      };

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = true;
      };
    };
  };

  services = {
    nix-daemon.enable = true;
  };

  nix = {
    nixPath = "nixpkgs=flake:nixpkgs";
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

  users.users = {
    michael = {
      name = "michael";
      createHome = true;
      description = "Michael Utz";
      home = "/Users/michael";
    };

    playcore = {
      name = "playcore";
      createHome = true;
      description = "PlayCore";
      home = "/Users/playcore";
    };
  };

  programs = {
    zsh.enable = true;
  };
}
