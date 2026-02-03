# Nix Support

This project provides a Nix development environment for reproducible builds.

## Development Environment

### Enter the shell

```bash
nix develop
```

Then use make commands:

```bash
make build
make test
make tidy
make help
```

### Build with a single command

```bash
nix develop --command make build
```

### Run tests

```bash
nix develop --command make test
```

### Build all platforms

```bash
nix develop --command make build-all-platforms
```

## Features

- **Reproducible environment**: All dependencies are pinned
- **Cross-platform**: Works on Linux and macOS
- **Complete Go toolchain**: Go 1.24.x with all development tools
- **No Go installation needed**: Nix manages all dependencies
- **Uses existing makefile**: Leverages the project's Makefile

For more details, see [.nix/README.md](.nix/README.md)