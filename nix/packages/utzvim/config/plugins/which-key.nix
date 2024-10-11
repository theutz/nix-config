{lib, ...}: let
  inherit (lib) map elemAt mapAttrsToList;

  groups = {
    "<tab>" = "Tabs";
    "b" = "Buffers";
    "g" = "Git";
    "q" = "Quit/session";
    "s" = "Search";
    "w" = "Window";
  };

  mkGroup = key: group: {
    inherit group;
    __unkeyed-1 = "<leader>${key}";
  };

  groupSpec = mapAttrsToList mkGroup groups;
in {
  plugins.which-key = {
    enable = true;

    settings = {
      preset = "modern";
      spec =
        groupSpec
        ++ [
          {
            __unkeyed-1 = "gs";
            group = "surround";
          }
        ];
    };
  };
}
