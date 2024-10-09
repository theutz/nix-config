{pkgs, ...}:
pkgs.writeShellApplication {
  name = "sesh";

  runtimeInputs = with pkgs; [
    fzf
    tmuxp
  ];

  text = ''
    case $1 in

    *)
      tmuxp ls | fzf | xargs tmuxp attach -d
    esac
  '';
}
