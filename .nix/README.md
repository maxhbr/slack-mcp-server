# Nix Flake

This directory contains the Nix flake configuration for a reproducible development environment for the Slack MCP Server.

## Quick Start

### Enter Development Environment

```bash
nix develop
```

This provides:
- Go 1.24.x
- Development tools (gopls, gotools, etc.)
- Make and Git
- Docker/Docker Compose

### Build with Nix dev environment

```bash
# Single command build
nix develop --command make build

# Enter shell then build
nix develop
make build

# Run tests
nix develop --command make test

# Build for multiple platforms
nix develop --command make build-all-platforms
```

### Using the dev environment

```bash
# Enter the shell
nix develop

# Then use any make command
make build
make test
make tidy
make clean
make help
```

## Available Make Targets

Inside the Nix development environment, you can use all the project's Makefile targets:

- `make build` - Build the project
- `make test` - Run the tests
- `make tidy` - Tidy up the go modules
- `make deps` - Download dependencies
- `make clean` - Clean build artifacts
- `make help` - Show all available targets
- `make build-all-platforms` - Build for all platforms

## CI/CD

The flake can be used in CI/CD pipelines:

```yaml
# Example GitHub Actions
- name: Setup Nix
  uses: cachix/install-nix-action@v22
  with:
    extra_nix_config: |
      experimental-features = nix-command flakes
- name: Build with Nix
  run: nix develop --command make build
- name: Run tests with Nix
  run: nix develop --command make test
```

## Troubleshooting

### Old Nix version

If you get an error about experimental features, enable them in your `~/.config/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

### Build issues

```bash
# Clean and rebuild
make clean
nix develop --command make build
```

## Reproducibility

The Nix flake ensures that:
- All dependencies are pinned
- Development environment is reproducible
- No need for Go installation on host system
- Consistent environment across different machines

See the official Nix documentation for more details:
https://nixos.wiki/wiki/Flakes