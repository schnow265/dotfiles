{
  lib,
  pkgs,
  enableMiseInstall ? true,
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
        idiomatic_version_file_enable_tools = [ "python" ];
        python.uv_venv_auto = "create|source";
        minimum_release_age = "7d";
      };

      tools = {
        uv = "latest";

        # compiling tools
        ninja = "latest";
        ccache = "latest";
        meson = "latest";
        cmake = "latest";
      };
    };
  };

  home.activation = lib.mkIf enableMiseInstall {
    miseInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.mise}/bin:$PATH"
      mise install --yes
    '';

    miseUpdate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.mise}/bin:$PATH"
      mise upgrade
    '';
  };
}
