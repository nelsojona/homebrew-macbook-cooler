cask "macbook-cooler-app" do
  version "1.1.0"
  sha256 :no_check

  url "https://github.com/nelsojona/macbook-cooler/releases/download/v#{version}/MacBookCooler-v#{version}.dmg"
  name "MacBook Cooler"
  desc "Menu bar app for thermal management on Apple Silicon MacBooks"
  homepage "https://github.com/nelsojona/macbook-cooler"

  depends_on macos: ">= :ventura"

  app "MacBook Cooler.app"

  postflight do
    # Install CLI tools if not already installed
    unless File.exist?("/opt/homebrew/bin/thermal-monitor")
      system_command "/opt/homebrew/bin/brew",
                     args: ["tap", "nelsojona/macbook-cooler"],
                     sudo: false
      system_command "/opt/homebrew/bin/brew",
                     args: ["install", "macbook-cooler"],
                     sudo: false
    end
    # Start the background service
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

    Features:
    • Real-time temperature monitoring (Fahrenheit/Celsius toggle)
    • Light/Dark/System appearance modes
    • Automatic power mode switching
    • Quick access to thermal management tools

    The CLI tools will be automatically installed and the
    background service will be started.

    To start the app at login, add it to:
    System Settings → General → Login Items
  EOS
end
