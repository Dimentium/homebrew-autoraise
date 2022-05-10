class Autoraise < Formula
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  version "2.9"
  url "https://github.com/sbmpost/AutoRaise/archive/refs/tags/v#{version}.tar.gz"
  sha256 "7f3918bebf046eda37d93f8ae30745638810b08e61eb236657e0e26ece577c51"
  license "GPL-3.0"

  head do
    url "https://github.com/sbmpost/AutoRaise.git"
  end

  def install
    system "make clean"
    system "make"
    bin.install "AutoRaise"
  end

  plist_options :manual => "AutoRaise"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
          <string>#{opt_bin}/AutoRaise</string>
          </array>
          <key>StandardErrorPath</key>
          <string>#{ENV["HOME"]}/Library/Logs/AutoRaise.log</string>
          <key>StandardOutPath</key>
          <string>#{ENV["HOME"]}/Library/Logs/AutoRaise.log</string>
          <key>RunAtLoad</key>
          <true/>
        </dict>
      </plist>
    EOS
  end

  test do
    system "false"
  end
end
