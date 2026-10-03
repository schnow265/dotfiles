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
        idiomatic_version_file_enable_tools = ["python"];
        python.uv_venv_auto = "create|source";
      };

      tools = {
        elixir = "1.20.4-otp-29";
        erlang = "29.1";

        # latest version of funny tools
        uv = "latest";
      };
    };
  };
}
