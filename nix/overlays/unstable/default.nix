{channels, ...}: final: prev: {
  inherit
    (channels.unstable)
    bash-language-server
    devenv
    diagnostic-languageserver
    fzf
    mods
    hugo
    just
    neovide
    neovim
    stylelint-lsp
    tmux
    tmuxp
    typescript-language-server
    vimPlugins
    yazi
    ;
}
