{
  lib,
  scal,
  pkgs,
  username,
  system,
  enableGuiTools ? false,
  nixZshCompletions,
  ...
}:
let
  binExtract = scal.lib.binExtract { inherit pkgs; };

  path = if lib.hasSuffix "-darwin" system then "/Users" else "/home";

  isLinux = pkgs.stdenv.hostPlatform.isLinux;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #
  # Paths set automagically
  home.username = username;
  home.homeDirectory = "${path}/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.packages =
    with pkgs;
    [
      aria2
      bat
      btop
      chezmoi
      delta
      devenv
      direnv
      lsd
      ripgrep
      tlrc
    ]
    ++ (if enableGuiTools then [ keepassxc ] else [ (binExtract pkgs.keepassxc "keepassxc-cli") ]);

  home.sessionVariables = {
    # other ones
    HF_HUB_DISABLE_XET = "1";
    UV_TORCH_BACKEND = "auto";
  };

  home.file = {
    ".local/share/external/zsh/nixos-completions".source = nixZshCompletions;
  };

  programs.ghostty = {
    enable = enableGuiTools;
    package = (if isLinux then pkgs.ghostty else pkgs.ghostty-bin);

    enableZshIntegration = true;
    installBatSyntax = true;
    settings = {
      #theme = "Nvim Dark";
      font-family = "JetBrains Mono";
      font-family-bold = "JetBrains Mono";
      font-family-italic = "JetBrains Mono";
      font-family-bold-italic = "JetBrains Mono";
      font-feature = "-calt, -liga, -dlig";
      gtk-titlebar = false;
      macos-secure-input-indication = false;
    };
  };

  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        cleanup = true;
        assume_yes = true;

        first = [
          "chezmoi"
          "home_manager"
        ];

        disable = [
          "system"
          "shell"
          "vim"
          "pnpm"
          "mise"
          "node"
        ]
        ++ pkgs.lib.optionals isLinux [
          "config_update"
        ]
        ++ pkgs.lib.optionals isDarwin [
          "ruby_gems"
          "gem"
          "tmux"
        ];

        ignore_failures = [
          "powershell"
          "nix"
          "pi"
        ]
        ++ pkgs.lib.optionals isDarwin [
          "containers"
          "vagrant"
        ];
      };

      git = {
        max_concurrency = 10;
        repos = [
          "~/Projects/*/"
        ];
        arguments = "--ff-only";
      };
      commands = {
        "Nix Profiles" = "nix profile upgrade --all";
      };
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        source = "";
        color = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "";
        };
        width = null;
        height = null;
        padding = {
          top = 0;
          left = 0;
          bottom = 0;
          right = 4;
        };
        printRemaining = true;
        preserveAspectRatio = false;
        position = "left";
      };

      display = {
        stat = false;
        pipe = false;
        showErrors = false;
        disableLinewrap = false;
        hideCursor = false;
        separator = ": ";
        color = {
          keys = "";
          title = "";
          output = "";
          separator = "";
        };
        brightColor = true;

        duration = {
          abbreviation = false;
          spaceBeforeUnit = "default";
        };

        size = {
          maxPrefix = "YB";
          binaryPrefix = "iec";
          ndigits = 2;
          spaceBeforeUnit = "default";
        };

        temp = {
          unit = "D";
          ndigits = 1;
          color = {
            green = "32";
            yellow = "93";
            red = "91";
          };
          spaceBeforeUnit = "default";
        };

        percent = {
          type = [
            "num"
            "num-color"
          ];
          ndigits = 0;
          color = {
            green = "32";
            yellow = "93";
            red = "91";
          };
          spaceBeforeUnit = "default";
          width = 0;
        };

        bar = {
          char = {
            elapsed = "■";
            total = "-";
          };
          border = {
            left = "[ ";
            right = " ]";
            leftElapsed = "";
            rightElapsed = "";
          };
          color = {
            elapsed = "auto";
            total = "97";
            border = "97";
          };
          width = 10;
        };

        fraction = {
          ndigits = 2;
          trailingZeros = "default";
        };

        noBuffer = false;

        key = {
          width = 0;
          type = "string";
          paddingLeft = 0;
        };

        freq = {
          ndigits = 2;
          spaceBeforeUnit = "default";
        };

        constants = [ ];
      };

      general = {
        thread = true;
        processingTimeout = 5000;
        detectVersion = true;
        playerName = "";
      };

      modules = [
        {
          type = "title";
          key = " ";
          keyIcon = "";
          fqdn = false;
          color = {
            user = "";
            at = "";
            host = "";
          };
        }

        {
          type = "separator";
          string = "-";
          outputColor = "";
          times = 0;
        }

        {
          type = "host";
          keyIcon = "󰌢";
        }

        {
          type = "kernel";
          keyIcon = "";
        }

        {
          type = "packages";
          keyIcon = "󰏖";
          disabled = [ "winget" ];
          combined = false;
        }

        {
          type = "shell";
          keyIcon = "";
        }

        {
          type = "de";
          keyIcon = "";
        }

        {
          type = "icons";
          keyIcon = "";
        }

        {
          type = "terminal";
          keyIcon = "";
        }

        {
          type = "terminalfont";
          keyIcon = "";
        }

        {
          type = "cpu";
          keyIcon = "";
          temp = false;
          showPeCoreCount = true;
          tempSensor = "";
        }

        {
          type = "gpu";
          keyIcon = "󰾲";
          driverSpecific = false;
          detectionMethod = "auto";
          temp = false;
          hideType = "none";
          percent = {
            green = 50;
            yellow = 80;
            type = 0;
          };
        }

        {
          type = "memory";
          keyIcon = "";
          percent = {
            green = 50;
            yellow = 80;
            type = 0;
          };
        }

        {
          type = "swap";
          percent = {
            green = 50;
            yellow = 80;
            type = 0;
          };
          keyIcon = "󰓡";
          separate = false;
        }

        {
          type = "battery";
          keyIcon = "";
          temp = false;
          percent = {
            green = 50;
            yellow = 20;
            type = 0;
          };
        }

        "break"

        {
          type = "colors";
          key = " ";
          keyIcon = "";
          symbol = "block";
          paddingLeft = 0;
          block = {
            width = 3;
            range = [
              0
              15
            ];
          };
          brightness = "default";
        }
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
