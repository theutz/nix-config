{
  config,
  lib,
  ...
}: let
  inherit (builtins) map elemAt;
  inherit (lib) mkIf;

  act = key: action: desc: {
    mode = ["n"];
    key = "<leader>${key}";
    action = "<cmd>FzfLua ${action}<cr>";
    options = {inherit desc;};
  };

  cfg = config.plugins.fzf-lua;
in {
  plugins.fzf-lua = {
    enable = true;
    profile = "fzf-native";
    settings = {
      keymap = {
        fzf = {
          "ctrl-d" = "preview-page-down";
          "ctrl-u" = "preview-page-up";
        };
      };
    };
  };

  keymaps = mkIf cfg.enable (map (def: act (elemAt def 0) (elemAt def 1) (elemAt def 2)) [
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
    ["sk" "keymaps" "keymaps"]
    ["sq" "quickfix" "Quickfix"]
    ["sr" "resume" "Resume last search"]
    ["ss" "search_history" "Search history"]
    ["st" "tabs" "Tabs"]
    ["sz" "builtin" "Fzf builtins"]
    [''"'' "registers" "Registers"]
  ]);
}
