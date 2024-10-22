{
  inputs,
  system,
  channels,
}:
inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
  pkgs = channels.unstable;
  module = import ./config; # import the module directly
  # You can use `extraSpecialArgs` to pass additional arguments to your module files
  extraSpecialArgs = {
  };
}
