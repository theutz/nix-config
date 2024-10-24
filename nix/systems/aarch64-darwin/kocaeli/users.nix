{pkgs, ...}: {
  snowfallorg.users = {
    michael = {
      create = true;
      home = {
        enable = true;
        config = {};
      };
    };

    oyuncu = {
      create = true;
      home = {
        enable = true;
        config = {};
      };
    };
  };

  users = {
    knownUsers = ["oyuncu"];

    users.michael = {
      isHidden = false;
      createHome = true;
      description = "Michael Utz";
      shell = pkgs.zsh;
      uid = 501;
      home = "/Users/michael";
    };

    users.oyuncu = {
      isHidden = false;
      createHome = true;
      description = "Oyuncu";
      shell = pkgs.zsh;
      uid = 502;
      home = "/Users/oyuncu";
    };
  };
}
