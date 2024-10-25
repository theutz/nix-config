_: let
  inherit (builtins) map;
in {
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = map (name: {inherit name;}) [
        "nvim_lsp"
        "path"
        "buffer"
        "calc"
        "digraphs"
        "emojis"
        "rg"
        "tmux"
        "treesitter"
      ];

      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
}
