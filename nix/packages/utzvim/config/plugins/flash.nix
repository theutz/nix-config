{
  plugins.flash = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "s";
      action.__raw = ''
        function ()
          require("flash").jump()
        end
      '';
      options.desc = "Jump (Flash)";
    }
  ];
}
