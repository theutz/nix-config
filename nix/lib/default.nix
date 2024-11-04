{lib, ...}: let
  mkPath = (lib.flip lib.pipe) [
    lib.path.subpath.join
    (lib.removePrefix "./")
  ];
in rec {
  modules = rec {
    /*
    Return the name of the module from the directory name
    */
    getModName = path.getLastComponent;

    /*
    Return the path array to be used with {get,set}Attrs{From,By}Path
    */
    getModPath = namespace: path: [namespace getModName path];
  };

  vars = {
    paths = rec {
      flake = "nix-config";
      flakeRoot = mkPath [flake "nix"];
      modules = mkPath [flakeRoot "modules"];
      homeModules = mkPath [modules "home"];
      darwinModules = mkPath [modules "darwin"];
      tmux = mkPath [homeModules "tmux"];
      tmuxp = mkPath [tmux "tmuxp" "sessions"];
    };
  };

  package = import ./package.nix {inherit lib;};

  path = {
    /*
    Return the last component of a path as a string.
    */
    getLastComponent = (lib.flip lib.pipe) [
      lib.path.splitRoot
      (lib.getAttr "subpath")
      lib.path.subpath.components
      lib.last
    ];
  };
}
