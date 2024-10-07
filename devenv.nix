{pkgs, ...}: {
  # https://devenv.sh/basics/
  env.GREET = ''
    # TheUtz's Flake

    Here's where I figure out what I'm made of.
  '';

  # https://devenv.sh/packages/
  packages = [
    pkgs.git
    pkgs.gum
    pkgs.alejandra
  ];

  languages.nix.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    gum format "$GREET"
    echo
    echo
  '';

  enterShell = ''
    hello
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  pre-commit.hooks = {
    shellcheck.enable = true;
    alejandra.enable = true;
    check-merge-conflicts.enable = true;
    check-shebang-scripts-are-executable.enable = true;
    check-toml.enable = true;
    check-yaml.enable = true;
    commitizen.enable = true;
    deadnix.enable = true;
    flake-checker.enable = true;
    markdownlint.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
