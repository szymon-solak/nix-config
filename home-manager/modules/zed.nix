{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "catppuccin"
    ];

    userSettings = {
      vim_mode = true;
      relative_line_numbers = true;

      auto_update = false;
      load_direnv = "shell_hook";
      hour_format = "hour24";
      show_whitespace = "all";

      theme = "Catppuccin Mocha";

      ui_font_family = "Iosevka Nerd Font";
      ui_font_size = 16;

      buffer_font_family = "Iosevka NFM";
      buffer_font_size = 16;

      scrollbar = {
        show = "never";
      };

      terminal = {
        copy_on_select = false;
        dock = "left";
        line_height = "comfortable";
        shell = "system";
        font_family = "Iosevka NFM";
      };

      inlay_hints = {
        enabled = false;
      };

      project_panel = {
        dock = "right";
      };

      outline_pane = {
        dock = "right";
      };

      collaboration_panel = {
        button = false;
        dock = "left";
      };

      notification_panel = {
        button = false;
        dock = "left";
      };

      chat_panel = {
        button = false;
        dock = "left";
      };

      language_models = {
        ollama = {
          api_url = "http://localhost:11434";
          available_models = [
            {
              name = "mistral";
              display_name = "mistral";
              max_tokens = 16384;
            }
          ];
        };
      };

      assistant = {
        dock = "left";
        version = "2";
        enabled = true;
        default_model = {
          provider = "ollama";
          model = "mistral";
        };
      };
    };

    userKeymaps = [
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          ctrl-h = ["workspace:ActivatePaneInDirection" "Left"];
          ctrl-l = ["workspace:ActivatePaneInDirection" "Right"];
          ctrl-k = ["workspace:ActivatePaneInDirection" "Up"];
          ctrl-j = ["workspace:ActivatePaneInDirection" "Down"];
          "space c a" = "editor::ToggleCodeActions";
          "space ." = "editor::ToggleCodeActions";
          "space c r" = "editor::Rename";
          "g d" = "editor::GoToDefinition";
          "g D" = "editor::GoToDefinitionSplit";
          "g i" = "editor::GoToImplementation";
          "g I" = "editor::GoToImplementationSplit";
          "g t" = "editor::GoToTypeDefinition";
          "g T" = "editor::GoToTypeDefinitionSplit";
          "g r" = "editor::FindAllReferences";
          "] d" = "editor::GoToDiagnostic";
          "[ d" = "editor::GoToPrevDiagnostic";
          "] e" = "editor::GoToDiagnostic";
          "[ e" = "editor::GoToPrevDiagnostic";
          "shift-h" = "pane::ActivatePrevItem";
          "shift-l" = "pane::ActivateNextItem";
          "space o f" = "pane::RevealInProjectPanel";
          "space s p" = "pane::DeploySearch";
        };
      }
      {
        "context" = "Editor && vim_mode == visual && !VimWaiting && !menu";
        "bindings" = {
          "g c" = "editor::ToggleComments";
        };
      }
      {
        "context" = "Editor && vim_mode == insert && !menu";
        "bindings" = {
          "j j" = "vim::NormalBefore";
          "j k" = "vim::NormalBefore";
        };
      }
      {
        "context" = "Dock";
        "bindings" = {
          "ctrl-w h" = ["workspace::ActivatePaneInDirection" "Left"];
          "ctrl-w l" = ["workspace::ActivatePaneInDirection" "Right"];
          "ctrl-w k" = ["workspace::ActivatePaneInDirection" "Up"];
          "ctrl-w j" = ["workspace::ActivatePaneInDirection" "Down"];
        };
      }
      {
        "context" = "Workspace";
        "bindings" = {
          "space o p" = "workspace::ToggleRightDock";
        };
      }
    ];
  };
}
