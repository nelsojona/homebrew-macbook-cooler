cask "macbook-cooler-app" do
  version "1.0.0"
  sha256 :no_check

  url "https://github.com/nelsojona/macbook-cooler/releases/download/v#{version}/MacBookCooler.dmg"
  name "MacBook Cooler"
  desc "Menu bar app for thermal management on Apple Silicon MacBooks"
  homepage "https://github.com/nelsojona/macbook-cooler"

  depends_on macos: ">= :ventura"
  depends_on formula: "nelsojona/macbook-cooler/macbook-cooler"

  app "MacBook Cooler.app"

  postflight do
    # Ensure CLI tools are installed and service is running
    system_command "/opt/homebrew/bin/brew",
                   args: ["services", "start", "macbook-cooler"],
                   sudo: false
  end

  uninstall quit: "com.nelsojona.MacBookCooler"

  zap trash: [
    "~/Library/Application Support/MacBookCooler",
    "~/Library/Caches/com.nelsojona.MacBookCooler",
    "~/Library/Preferences/com.nelsojona.MacBookCooler.plist",
  ]

  caveats <<~EOS
    MacBook Cooler menu bar app has been installed!

    The app provides a beautiful glassmorphism interface for:
    • Real-time temperature monitoring
    • Automatic power mode switching
    • Quick access to thermal management tools

    The CLI tools (macbook-cooler formula) are automatically installed
    as a dependency and the background service will be started.

    To start the app at login, add it to:
    System Settings → General → Login Items
  EOS
end
