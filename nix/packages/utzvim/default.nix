{
  inputs,
  system,
  pkgs,
}: let
  nixvim = inputs.nixvim.legacyPackages.${system};
  nixvimModule = {
    inherit pkgs;
    module = import ./config; # import the module directly
    # You can use `extraSpecialArgs` to pass additional arguments to your module files
    extraSpecialArgs = {
    };
  };
  nvim = nixvim.makeNixvimWithModule nixvimModule;
in
  nvim
