{
  mkShell,
  pkgs,
  ...
} @ inputs: let
  utzvim = import ./utzvim.nix inputs;
  up = import ./up.nix inputs;
in
  mkShell {
    packages = with pkgs; [
      gum
      up
      utzvim
    ];

    shellHook = ''
      gum format <<EOF
      # Welcome to TheUtz's Flake ❄️

      ## Commands

      | Command | Description |
      | --- | --- |
      | up | start the dev server |
      | utzvim | edit the neovim configuration on a loop |
      EOF
    '';
  }
