{
  config,
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;
    initContent = ''
      # Keybindings
      bindkey " " magic-space

      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey '^X^E' edit-command-line

      bindkey '^[.' insert-last-word
      bindkey '^[_' copy-prev-word

      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word

      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line

      bindkey '^W' backward-kill-word
      bindkey '^H' backward-delete-char
      bindkey '^K' kill-line
      bindkey '^U' backward-kill-line

      bindkey '^/' undo
      bindkey '^?' backward-delete-char
      bindkey '^[/' redo

      source "$HOME/.config/zsh/config.zsh"

      fastfetch

      case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
      [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
    '';
    envExtra = ''
      export PATH="/Users/scaletto/.local/bin:$PATH"
    '';
    profileExtra = ''
      # Added by Toolbox App
      export PATH="$PATH:/Users/scaletto/Library/Scripts/JB_Toolbox/"

      eval "$(/opt/homebrew/bin/brew shellenv zsh)"

      case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
    '';

    # History
    history = {
      path = "$HOME/.zsh_history";
      size = 50000;
      save = 50000;

      ignoreDups = true;
      ignoreSpace = true;

      share = true;
    };

    # Shell options
    setOptions = [
      "INC_APPEND_HISTORY"
    ];

    # Dedicated Home Manager integrations
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Additional plugins
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
      }
    ];
    shellAliases = {
      cls = "clear";

      ls = "lsd";
      ll = "lsd -Al";

      cat = "bat";
      nvy = "neovide";
    };
  };

  programs.fzf = {
    enable = true;

    enableZshIntegration = true;
    historyWidget.options = [
      "--reverse"
      "--preview 'echo {}'"
      "--preview-window down:3:hidden:wrap"
      "--bind '?:toggle-preview'"
    ];
  };

  programs.bat = {
    enable = true;
  };

  programs.zk.settings.tool = {
    fzf-preview = "bat -p --color always {-1}";
  };

  programs.starship = {
    enable = true;
    presets = [
      "bracketed-segments"
    ];
    enableZshIntegration = true;
    validateFiles.config = true;

    settings = {
      battery.disabled = true;
      dotnet.detect_extensions = [
        "csproj"
        "fsproj"
        "xproj"
        "sln"
        "slnx"
      ];
      elixir = {
        format = "\[[$symbol($version-otp-$otp_version)]($style)\]";
        version_format = "$\{raw}";
      };
      nix_shell = {
        symbol = "❄️";
        format = "[$symbol]";
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    mise.enable = config.programs.mise.enable;
    nix-direnv.enable = true;
    enableGitIntegration = true;
    enableZshIntegration = true;
  };

  programs.devenv = {
    enable = true;
    enableFishIntegration = true;
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
}
