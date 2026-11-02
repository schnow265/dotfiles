{
  lib,
  pkgs,
  enableMiseInstall ? true,
  ...
}:
{
  programs.mise = {
    enable = true;

    globalConfig = {
      env = {
        CMAKE_GENRATOR = "Ninja";
      };

      settings = {
        experimental = true;
        idiomatic_version_file_enable_tools = [ "python" ];
        python.uv_venv_auto = "create|source";
        minimum_release_age = "1d";
        aqua = {
          cosign = true;
          github_attestations = true;
          minisign = true;
        };
        auto_install = true;
        cargo = {
          binstall = true;
          binstall_native = true;
        };
        disable_backends = [
          "asdf"
          "pypi"
          "conda"
        ];
        disable_update_warning = true;
        github_attestations = true;
        go = {
          repo = "https://github.com/golang/go";
          set_gobin = true;
        };
        gpg_verify = true;
        lockfile = true;
        node = {
          cflags = "-O3 -march=native";
          compile = true;
          corepack = true;
          npm_shim = true;
          ninja = true;
          configure_opts = "--use_clang --enable-lto --enable-all-experimentals --with-corepack";
        };
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
      mise install --yes $VERBOSE_ARG
      mise prune --yes $VERBOSE_ARG
    '';

    miseUpdate = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.mise}/bin:$PATH"
      mise upgrade $VERBOSE_ARG
    '';
  };
}
