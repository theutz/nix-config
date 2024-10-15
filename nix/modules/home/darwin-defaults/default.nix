{
  config,
  namespace,
  lib,
  ...
}: let
  mod = "darwin-defaults";
  cfg = config.${namespace}.${mod};
  inputSources = [
    {
      InputSourceKind = "Keyboard Layout";
      "KeyboardLayout ID" = -2;
      "KeyboardLayout Name" = "US Extended";
    }
    {
      InputSourceKind = "Keyboard Layout";
      "KeyboardLayout ID" = -36;
      "KeyboardLayout Name" = "Turkish-QWERTY-PC";
    }
    {
      "Bundle ID" = "com.apple.CharacterPaletteIM";
      InputSourceKind = "Non Keyboard Input Method";
    }
  ];
in {
  options.${namespace}.${mod} = {
    enable = lib.mkEnableOption "`defaults write` configurations";
  };

  config = lib.mkIf cfg.enable {
    targets.darwin = {
      defaults = {
        "com.apple.controlcenter" = {
          BatteryShowPercentage = false;
        };

        "com.apple.screensaver" = {
          askForPassword = 1;
          askForPasswordDelay = 0;
        };

        "com.apple.dock" = {
          autohide = false;
        };

        "com.apple.finder" = {
          AppleShowAllFiles = true;
          ShowPathBar = true;
          ShowStatusBar = true;
        };

        "com.apple.HIToolbox" = {
          AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.USExtended";
          AppleEnabledInputSources = inputSources;
          AppleSelectedInputSources = inputSources;
        };

        NSGlobalDomain = {
          ApplePressAndHoldEnabled = false;
          AppleShowAllExtensions = true;
          KeyRepeat = 2;
          InitialKeyRepeat = 12;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticDashSubstitutionEnabled = false;
          NSAutomaticInlinePredictionEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticQuoteSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          NSAutomaticWindowAnimationsEnabled = false;
        };
      };

      currentHostDefaults = {
        "com.apple.HIToolbox" = {
          AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.USExtended";
          AppleEnabledInputSources = inputSources;
          AppleSelectedInputSources = inputSources;
        };
      };
    };
  };
}
