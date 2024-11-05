{lib, ...}: let
  mkWinKey' = mode: key: desc:
    assert (lib.isList key || lib.isString key); let
      k = lib.mergeAttrsList (
        lib.zipListsWith (name: value: {"${name}" = value;})
        ["pressed" "sent"] (
          if lib.isList key
          then key
          else lib.replicate 2 key
        )
      );
    in {
      inherit mode;
      key = "<leader>w${k.pressed}";
      action = "<cmd>wincmd ${k.sent}<cr>";
      options = {inherit desc;};
    };

  mkWinKey = mkWinKey' "n";

  mkPair' = mode: key: name: prev: next: [
    {
      inherit mode;
      key = "[${key}";
      action = prev;
      options.desc = "Prev ${name}";
    }
    {
      inherit mode;
      key = "]${key}";
      action = next;
      options.desc = "Next ${name}";
    }
  ];

  mkPair = mkPair' "n";

  bufferKeys = lib.concatLists [
    [
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>bd!<cr>";
        options.desc = "Delete buffer (force)";
      }
      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>e #<cr>";
        options.desc = "Most recent buffer";
      }
    ]

    (lib.forEach ["n" "]"] (k: {
      mode = "n";
      key = "<leader>b${k}";
      action = "<cmd>bnext<cr>";
      options.desc = "Next buffer";
    }))

    (lib.forEach ["p" "["] (k: {
      mode = "n";
      key = "<leader>b${k}";
      action = "<cmd>bprev<cr>";
      options.desc = "Prev buffer";
    }))
  ];

  tabKeys = lib.concatLists [
    [
      {
        mode = "n";
        key = "<leader><tab><space>";
        action = "<cmd>wincmd T<cr>";
        options.desc = "Open in new tab";
      }
      {
        mode = "n";
        key = "<leader><tab>o";
        action = "<cmd>tabe<cr>";
        options.desc = "Open a new blank tab";
      }
      {
        mode = "n";
        key = "<leader><tab>s";
        action = "<cmd>tabfirst<cr>";
        options.desc = "Open first tab";
      }
      {
        mode = "n";
        key = "<leader><tab>e";
        action = "<cmd>tablast<cr>";
        options.desc = "Open last tab";
      }
      {
        mode = "n";
        key = "<leader><tab>r";
        action = ":BufferLineTabRename ";
        options.desc = "Rename tab";
      }
      {
        mode = "n";
        key = "<leader><tab><tab>";
        action = "<cmd>wincmd g<tab><cr>";
        options.desc = "Most recent tab";
      }
    ]

    (lib.forEach ["n" "]"] (k: {
      mode = "n";
      key = "<leader><tab>${k}";
      action = "<cmd>tabnext<cr>";
      options.desc = "Next tab";
    }))

    (lib.forEach ["p" "["] (k: {
      mode = "n";
      key = "<leader><tab>${k}";
      action = "<cmd>tabprev<cr>";
      options.desc = "Prev tab";
    }))

    (lib.forEach ["q" "d"] (k: {
      mode = "n";
      key = "<leader><tab>${k}";
      action = "<cmd>tabclose<cr>";
      options.desc = "Close tab";
    }))
  ];

  other = [
    {
      mode = ["n" "i"];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save file";
      };
    }
    {
      mode = ["n" "i"];
      key = "<esc>";
      action = "<cmd>nohl<cr><esc>";
      options.desc = "Clear highlighting";
    }
    {
      mode = "n";
      key = "<leader>qq";
      action = "<cmd>xa<cr>";
      options.desc = "Write all and quit";
    }
  ];
in {
  keymaps = lib.concatLists [
    (lib.concatLists
      [
        (mkPair "b" "buffer" "<cmd>bprev<cr>" "<cmd>bnext<cr>")
        (mkPair "<tab>" "tab" "<cmd>tabprev<cr>" "<cmd>tabnext<cr>")
        (mkPair "q" "quickfix" "<cmd>cprev<cr>" "<cmd>cnext<cr>")
        (mkPair "l" "location" "<cmd>lprev<cr>" "<cmd>lnext<cr>")
      ])
    [
      (mkWinKey "+" "Increase height")
      (mkWinKey "-" "Decrease height")
      (mkWinKey ">" "Increase width")
      (mkWinKey "<" "Decrease width")
      (mkWinKey "=" "Equal width/height")
      (mkWinKey "_" "Max height")
      (mkWinKey "|" "Max width")
      (mkWinKey "h" "Focus left")
      (mkWinKey "j" "Focus below")
      (mkWinKey "k" "Focus above")
      (mkWinKey "l" "Focus right")
      (mkWinKey "o" "Close other windows")
      (mkWinKey "q" "Close this window")
      (mkWinKey ["d" "q"] "Close this window")
      (mkWinKey "s" "Split horizontal")
      (mkWinKey "v" "Split vertical")
      (mkWinKey "T" "Break into tab")
      (mkWinKey "w" "Focus previous")
      (mkWinKey "x" "Swap with next")
    ]
    bufferKeys
    tabKeys
    other
  ];
}
