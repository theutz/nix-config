{
  config,
  lib,
  ...
}: let
  cfg = config.plugins.toggleterm;
in {
  plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<C-_>]]";
      insert_mappings = true;
      terminal_mappings = true;
    };
  };

  autoCmd = lib.mkIf cfg.enable [
    {
      event = ["TermEnter"];
      # If you don't add this autocmd, then ToggleTerm can prevent the normal
      # exit behavior for vim when running :wq, :wqa, :wq!, and :wqa!
      callback.__raw = ''
        function()
          for _, buffers in ipairs(vim.fn.getbufinfo()) do
            local filetype = vim.api.nvim_buf_get_option(buffers.bufnr, "filetype")
            if filetype == "toggleterm" then
              vim.api.nvim_create_autocmd({ "BufWriteCmd", "FileWriteCmd", "FileAppendCmd" }, {
                buffer = buffers.bufnr,
                command = "q!",
              })
            end
          end
        end
      '';
    }
  ];
}
