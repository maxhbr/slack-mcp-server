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
            make
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

      in
      {
        devShells = {
          default = dev-shell;
        };
      }
    );
}