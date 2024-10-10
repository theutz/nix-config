{pkgs, ...}: {
  plugins.spectre = {
    enable = true;
    # findPackage = pkgs.rg;
    # replacePackage = pkgs.gnused;
  };
}
