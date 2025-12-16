class MacbookCooler < Formula
  desc "Thermal management scripts for Apple Silicon MacBook Pro"
  homepage "https://github.com/nelsojona/macbook-cooler"
  url "https://github.com/nelsojona/macbook-cooler/archive/refs/tags/v1.1.0.tar.gz"
  sha256 :no_check  # Update with actual SHA256 after release
  license "MIT"
  head "https://github.com/nelsojona/macbook-cooler.git", branch: "main"

  depends_on :macos

  def install
    # Install shell scripts to libexec
    libexec.install Dir["scripts/*.sh"]
    
    # Make scripts executable
    (libexec/"thermal_monitor.sh").chmod 0755
    (libexec/"auto_power_mode.sh").chmod 0755
    (libexec/"thermal_throttle.sh").chmod 0755
    (libexec/"thermal_scheduler.sh").chmod 0755
    (libexec/"fan_control.sh").chmod 0755
    (libexec/"system_optimizer.sh").chmod 0755

    # Create command-line wrappers in bin
    (bin/"thermal-monitor").write_env_script libexec/"thermal_monitor.sh", {}
    (bin/"thermal-power").write_env_script libexec/"auto_power_mode.sh", {}
    (bin/"thermal-throttle").write_env_script libexec/"thermal_throttle.sh", {}
    (bin/"thermal-schedule").write_env_script libexec/"thermal_scheduler.sh", {}
    (bin/"thermal-fan").write_env_script libexec/"fan_control.sh", {}
    (bin/"thermal-optimize").write_env_script libexec/"system_optimizer.sh", {}

    # Install config file to etc
    (etc/"thermal-management").mkpath
    (etc/"thermal-management/thermal_config.conf").write <<~EOS
      # MacBook Cooler Thermal Management Configuration
      # ================================================

      # Temperature Thresholds (Celsius)
      HIGH_THRESHOLD=80
      LOW_THRESHOLD=65
      CRITICAL_THRESHOLD=95

      # CPU Usage Threshold for Throttling (percentage)
      CPU_THRESHOLD=50

      # Fan Control Settings
      DEFAULT_FAN_PROFILE=balanced

      # Logging
      LOG_DIR=/var/log/thermal-management
      LOG_LEVEL=INFO

      # Scheduler Settings
      COOL_TEMP_THRESHOLD=60
      QUEUE_FILE=~/.thermal_task_queue
    EOS

    # Create log directory
    (var/"log/thermal-management").mkpath
  end

  def caveats
    <<~EOS
      Thermal Management Suite has been installed!

      Most commands require sudo to access system metrics:
        sudo thermal-monitor
        sudo thermal-power --daemon

      Configuration file is located at:
        #{etc}/thermal-management/thermal_config.conf

      Logs are stored in:
        #{var}/log/thermal-management/

      To start the auto power mode service:
        brew services start macbook-cooler

      For more information, run:
        thermal-monitor --help
    EOS
  end

  service do
    run [opt_bin/"thermal-power", "--daemon"]
    keep_alive true
    log_path var/"log/thermal-management/power_service.log"
    error_log_path var/"log/thermal-management/power_service_error.log"
  end

  test do
    assert_match "Thermal", shell_output("#{bin}/thermal-monitor --help 2>&1", 1)
  end
end
