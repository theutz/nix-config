{pkgs, ...}: {
  plugins.none-ls = {
    enable = false;
    sources = {
      code_actions = {
        gitrebase.enable = true;
        gitsigns.enable = true;
        proselint.enable = true;
        refactoring.enable = true;
        statix.enable = true;
        textlint.enable = true;
        textlint.package = pkgs.textlint;
      };

      diagnostics = {
        codespell.enable = true;
        commitlint.enable = true;
        deadnix.enable = true;
        dotenv_linter.enable = true;
        editorconfig_checker.enable = true;
        gitlint.enable = true;
        golangci_lint.enable = true;
        markdownlint.enable = true;
        phpstan.enable = true;
        proselint.enable = true;
        rubocop.enable = true;
        selene.enable = true;
        statix.enable = true;
        stylelint.enable = true;
        textlint.enable = true;
        textlint.package = pkgs.textlint;
        todo_comments.enable = true;
        trail_space.enable = true;
        yamllint.enable = true;
        zsh.enable = true;
      };

      hover = {
        dictionary.enable = true;
      };
    };
  };
}
