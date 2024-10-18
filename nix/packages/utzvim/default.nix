{
  inputs,
  system,
}:
inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
  module = import ./config; # import the module directly
  # You can use `extraSpecialArgs` to pass additional arguments to your module files
  extraSpecialArgs = {
  };
}
