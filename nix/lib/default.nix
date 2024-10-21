{lib, ...}: {
  modules = import ./modules.nix {inherit lib;};
  vars = import ./vars.nix {inherit lib;};
}
