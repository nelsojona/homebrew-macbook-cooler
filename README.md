# Homebrew Tap for MacBook Cooler

This is a [Homebrew](https://brew.sh/) tap for the [MacBook Pro Thermal Management Suite](https://github.com/nelsojona/macbook-cooler).

## Installation

```bash
brew tap nelsojona/macbook-cooler
brew install macbook-cooler
```

## Usage

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

```bash
brew uninstall macbook-cooler
brew untap nelsojona/macbook-cooler
```

## More Information

For detailed documentation, visit the [main repository](https://github.com/nelsojona/macbook-cooler).
