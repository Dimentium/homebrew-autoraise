class Autoraise < Formula
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  version "3.3"
  url "https://github.com/sbmpost/AutoRaise/archive/refs/tags/v#{version}.tar.gz"
  sha256 "a8397cf6226b53dcd8f6cbb83b9209b923ecb114372df49f9fdc4f0fd90d6297"
  license "GPL-3.0"

  option "with-dalternative_task_switcher", "Build with compile flag -DALTERNATIVE_TASK_SWITCHER"
  option "with-dold_activation_method", "Build with compile flag -DOLD_ACTIVATION_METHOD"
  option "with-dexperimental_focus_first", "Build with compile flag -DEXPERIMENTAL_FOCUS_FIRST"

  head do
    url "https://github.com/sbmpost/AutoRaise.git"
  end

  def install
    opts = []
    opts << "-DALTERNATIVE_TASK_SWITCHER" if build.with? "dalternative_task_switcher"
    opts << "-DOLD_ACTIVATION_METHOD"     if build.with? "dold_activation_method"
    opts << "-DEXPERIMENTAL_FOCUS_FIRST"  if build.with? "dexperimental_focus_first"
    cxxflags = "CXXFLAGS='#{opts.join(' ')}'" if !opts.empty?

    system "make clean"
    system ["make", cxxflags].join(' ')
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
