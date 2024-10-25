{lib, ...}: {
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = lib.map (lib.setAttr {} "name") [
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
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
      };
    };
  };
}
