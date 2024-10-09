{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: let
  name = lib.theutz.getLastComponent ./.;
  unstable = inputs.unstable.legacyPackages.${system};
in
  pkgs.writeShellApplication {
    inherit name;

    runtimeInputs = [
      unstable.fzf
      pkgs.tmux
      pkgs.tmux
    ];

    text = ''
      filename=$(tmuxp ls | fzf --tmux=left,30)
      file="''${XDG_CONFIG_HOME:-$HOME/.config}"/tmuxp/"$filename".yml

      if [[ -n "$TMUX" ]]; then
      	tmux popup -x 120 -y 90% -EE "$EDITOR $file"
      else
      	$EDITOR "$file"
      fi
    '';
  }
