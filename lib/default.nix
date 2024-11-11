{lib, ...}: let
  mkPath = p:
    with lib;
    with path.subpath;
      pipe p [join (removePrefix "./")];
in rec {
  mkIfInstalled' = config:
    assert (lib.hasAttrByPath ["home" "packages"] config);
      pkg:
        lib.mkIf (lib.elem pkg config.home.packages);

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

  bash.loggers = builtins.readFile ./loggers.sh;

  vars = {
    paths = rec {
      flake = "nix-config";
      flakeRoot = flake;
      packages = mkPath [flakeRoot "packages"];
      modules = mkPath [flakeRoot "modules"];
      homeModules = mkPath [modules "home"];
      darwinModules = mkPath [modules "darwin"];
      tmux = mkPath [homeModules "tmux"];
      tmuxp = mkPath [tmux "tmuxp" "sessions"];
    };

    styles = {
      font = {
        family = "0xProto Nerd Font Propo";
        size = 12;
        weight = 400;
        leading = 1.2;
      };
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

  mkOutOfStoreSymlink' = config: path:
    lib.pipe path [
      (path: (lib.path.subpath.join [
        lib.internal.vars.paths.homeModules
        (lib.internal.path.getLastComponent (builtins.dirOf path))
        (builtins.baseNameOf path)
      ]))

      (lib.path.append
        (/. + config.home.homeDirectory))

      config.lib.file.mkOutOfStoreSymlink
    ];
}
