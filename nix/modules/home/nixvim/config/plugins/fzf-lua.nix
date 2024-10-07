{...}: let
  inherit (builtins) map elemAt;

  act = key: action: desc: {
    mode = ["n"];
    key = "<leader>${key}";
    action = "<cmd>FzfLua ${action}<cr>";
    options = {inherit desc;};
  };
in {
  plugins.fzf-lua = {
    enable = true;
  };

  keymaps = map (def: act (elemAt def 0) (elemAt def 1) (elemAt def 2)) [
    [" " "git_files" "Find files (current repo)"]
    ["'" "marks" "Marks"]
    ["," "buffers" "Buffers"]
    ["." "blines" "Grep files (current buffer)"]
    ["/" "live_grep" "Grep files (current repo)"]
    ["sa" "autocmds" "Autocmds"]
    ["sb" "buffers" "Buffers"]
    ["sC" "command_history" "Command history"]
    ["sc" "commands" "Commands"]
    ["sf" "files" "Files (pwd)"]
    ["sF" "filetypes" "Filetypes"]
    ["sh" "helptags" "Help"]
    ["sm" "manpages" "Manpages"]
    ["sq" "quickfix" "Quickfix"]
    ["sr" "resume" "Resume last search"]
    ["ss" "search_history" "Search history"]
    ["st" "tabs" "Tabs"]
    ["sz" "builtin" "Fzf builtins"]
    [''"'' "registers" "Registers"]
  ];
}
