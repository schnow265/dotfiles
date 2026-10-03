{
  ...
}:
{
  programs.mise = {
    enable = true;

    enableZshIntegration = true;
    globalConfig = {
      settings = {
        experimental = true;
      };

      tools = {
        elixir = "1.20.4-otp-29";
        erlang = "29.1";
      };
    };
  };
}
