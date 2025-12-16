# Homebrew Tap for MacBook Cooler

This is a [Homebrew](https://brew.sh/) tap for [MacBook Cooler](https://github.com/nelsojona/macbook-cooler) - a comprehensive thermal management solution for Apple Silicon MacBooks.

## Available Packages

| Package | Type | Description |
|---------|------|-------------|
| `macbook-cooler` | Formula | CLI thermal management tools |
| `macbook-cooler-app` | Cask | Native macOS menu bar application |

## Installation

### Menu Bar App (Recommended for most users)

```bash
brew tap nelsojona/macbook-cooler
brew install --cask macbook-cooler-app
```

The cask will automatically install the CLI tools and start the background service.

### CLI Tools Only

```bash
brew tap nelsojona/macbook-cooler
brew install macbook-cooler
```

## CLI Commands

After installation, the following commands are available:

| Command | Description |
|---------|-------------|
| `thermal-monitor` | Real-time temperature monitoring |
| `thermal-power` | Automatic power mode switching |
| `thermal-throttle` | Process throttling during thermal events |
| `thermal-schedule` | Task scheduling for cooler periods |
| `thermal-fan` | Fan control and custom profiles |
| `thermal-optimize` | System optimization tools |

Most commands require `sudo` to access system metrics:

```bash
sudo thermal-monitor
sudo thermal-power --daemon
```

## Starting the Service

To run the automatic power mode switching as a background service:

```bash
brew services start macbook-cooler
```

## Uninstallation

### Menu Bar App

```bash
brew uninstall --cask macbook-cooler-app
```

### CLI Tools

```bash
brew uninstall macbook-cooler
brew untap nelsojona/macbook-cooler
```

## More Information

For detailed documentation, visit the [main repository](https://github.com/nelsojona/macbook-cooler).

## Author

Created by [Jonathan Nelson](https://github.com/nelsojona)
