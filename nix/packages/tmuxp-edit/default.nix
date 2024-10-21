{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellApplication {
  name = lib.theutz.modules.getLastComponent ./.;

  runtimeInputs = with pkgs; [
    fzf
    tmux
    tmuxp
  ];

  text = ''
    filename=$(tmuxp ls | fzf --tmux=left,30)
    file="$HOME/${lib.theutz.vars.paths.tmuxp}/$filename.yml"

    if [[ -n "$TMUX" ]]; then
    	tmux popup -x 120 -y 90% -EE "$EDITOR $file"
    else
    	$EDITOR "$file"
    fi
  '';
}
