{
  lockedPkgs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    # package = lockedPkgs.zed-editor;

    extensions = [
      "csharp"
      "catppuccin-icons"
      "csv"
      "elisp"
      "elixir"
      "emmet"
      "git-firefly"
      "html"
      "log"
      "lua"
      "meson"
      "nix"
      "plantuml"
      "toml"
      "vue"
    ];

    mutableUserSettings = true;
    mutableUserDebug = true;
    mutableUserTasks = true;
    mutableUserKeymaps = true;

    userSettings = {
      disable_ai = true;
      language_models = {
        "llama.cpp" = {
          api_url = "http://localhost:9931/v1";
        };
      };
      restore_on_startup = "launchpad";
      edit_predictions = {
        allow_data_collection = "no";
        provider = "open_ai_compatible_api";
        open_ai_compatible_api = {
          model = "prism-ml/Bonsai-8B-gguf:Q1_0";
          api_url = "http://localhost:9931/v1/chat/completions";
        };
      };
      document_symbols = "on";
      document_folding_ranges = "on";
      diagnostics.inline.enabled = true;
      semantic_tokens = "combined";
      telemetry = {
        diagnostics = false;
        metrics = false;
        anthropic_retention = false;
      };
      session.trust_all_workress = true;
      vim_mode = true;
      icon_theme = "Catppuccin Mocha";
      ui_font_size = 16;
      buffer_font_size = 15;

      buffer_font_family = "JetBrains Mono";
      ui_font_family = ".ZedSans";
      terminal = {
        font_family = "JetBrains Mono";
        font_size = 11.0;
      };
      collaboration_panel.button = false;
      outline_panel.dock = "right";
      agent.button = false;

      project_panel = {
        folder_indicator = "icon";
        hide_hidden = false;
        hide_root = false;
        git_status_indicator = true;
        diagnostic_badges = true;
        show_diagnostics = "all";
        scrollbar = {
          horizontal_scroll = true;
        };
        bold_folder_labels = true;
        git_status = true;
        file_icons = true;
        entry_spacing = "standard";
        hide_gitignore = false;
        dock = "left";
      };

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "One Dark";
      };
    };
  };
}
