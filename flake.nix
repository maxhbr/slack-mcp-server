{
  description = "Slack MCP Server - Model Context Protocol server for Slack Workspaces";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        dev-shell = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            gopls
            gotools
            go-tools
            gotestsum
            godot
            gnumake
            git
            jq
            docker
            docker-compose
          ];

          shellHook = ''
            echo "╔════════════════════════════════════════════════╗"
            echo "║   Slack MCP Server Development Environment      ║"
            echo "╠════════════════════════════════════════════════╣"
            echo "║   Go version: $(go version | awk '{print $3}')   ║"
            echo "╚════════════════════════════════════════════════╝"
            echo ""
            echo "Available commands:"
            echo "  nix develop --command make build     - Build the project"
            echo "  nix develop --command make test      - Run tests"
            echo "  nix develop --command make tidy      - Tidy go modules"
            echo "  nix develop --command make clean     - Clean build artifacts"
            echo "  nix develop --command make help      - Show all make targets"
            echo ""
            echo "Or enter the shell first:"
            echo "  nix develop"
            echo "  make build"
            echo ""
          '';
        };

      package = pkgs.buildGoModule rec {
          pname = "slack-mcp-server";
          version = "0.1.0";

          src = ./.;

          vendorHash = "sha256-ddbYtTjNC4Ig9PSSylXd069Vtlxmc5utDgmoFRpqgWQ=";

          mod = "mod";

          doCheck = false;

          ldflags = [
            "-s"
            "-w"
          ];

          meta = with pkgs.lib; {
            description = "Model Context Protocol server for Slack Workspaces";
            homepage = "https://github.com/example/slack-mcp-server";
            license = licenses.mit;
            mainProgram = "slack-mcp-server";
          };
        };

      in
      {
        packages = {
          default = package;
        };

        apps = {
          default = {
            type = "app";
            program = "${package}/bin/slack-mcp-server";
          };
        };

        devShells = {
          default = dev-shell;
        };
      }
    );
}