{
  lib,
  pkgs,
  ...
}:
{
  programs.mise = {
    enable = true;

    enableZshIntegration = true;
    globalConfig = {
      env = {
        CMAKE_GENRATOR = "Ninja";
      };

      settings = {
        experimental = true;
        idiomatic_version_file_enable_tools = ["python"];
        python.uv_venv_auto = "create|source";
      };

      tools = {
        elixir = "1.20.4-otp-29";
        erlang = "29.1";

        # latest version of funny tools
        elixir-ls = "latest";
        ruff = "latest";
        ty = "latest";
        uv = "latest";

        # other things
        node = "lts";
        pnpm = "latest";

        # compiling tools
        ninja = "latest";
        ccache = "latest";
        sccache = "latest";
        meson = "latest";
      };
    };
  };

  home.activation.miseInstall =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.mise}/bin:$PATH"
      mise install --yes
    '';
}
