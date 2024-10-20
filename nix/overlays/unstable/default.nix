{channels, ...}: final: prev: {
  inherit
    (channels.unstable)
    devenv
    fzf
    vimPlugins
    typescript-language-server
    stylelint-lsp
    diagnostic-languageserver
    bash-language-server
    neovim
    neovide
    hugo
    just
    yazi
    ;
}
