{
  system = {
    stateVersion = 5;

    checks = {
      verifyBuildUsers = true;
      verifyNixChannels = true;
      verifyNixPath = false; # not useful with flakes
    };
  };
}
