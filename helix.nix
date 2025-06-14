{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedarker";
      editor.file-picker = {
        hidden = false;
        git-ignore = true;
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "tsx";
          language-servers = [
            "eslint_d"
            "emmet-ls"
            "typescript-language-server"
            "tailwindcss-ls"
          ];
          formatter = {
            command = "prettierd";
            args = [
              "--parser"
              "typescript"
            ];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            "eslint_d"
            "emmet-ls"
            "typescript-language-server"
            "tailwindcss-ls"
          ];
          formatter = {
            command = "prettierd";
            args = [
              "--parser"
              "typescript"
            ];
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [
            {
              name = "ruff";
              only-features = [
                "format"
                "diagnostics"
              ];
            }
            {
              name = "pyright";
              except-features = [
                "format"
                "diagnostics"
              ];
            }
          ];
          formatter = {
            command = "bash";
            args = [
              "-c"
              "ruff check --fix - | ruff format -"
            ];
          };
          file-types = [
            "py"
            "ipynb"
          ];
          comment-token = "#";
          shebangs = [ "python" ];
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [
            {
              name = "rust-analyzer";
            }
          ];
        }
      ];

      language-server.pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        pyright.config.python.analysis = {
          typeCheckingMode = "basic";
          autoImportCompletions = true;
        };
      };

      language-server.ruff = {
        name = "ruff";
        args = [
          "server"
          "--preview"
        ];
        environment = {
          "RUFF_TRACE" = "messages";
        };
        ruff.config.settings.format = {
          preview = true;
        };
      };
      language-server.rust-analyzer.config = {
        check = {
          command = "clippy";
        };
        cargo = {
          features = "all";
        };
      };
    };
  };
}
