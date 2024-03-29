class Autoraise < Formula
  version "5.1"
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  url "https://github.com/sbmpost/AutoRaise/archive/refs/tags/v#{version}.tar.gz"
  sha256 "893bca61023e7b8eff5a22c9ef37779c7fae34251beffad7ddf99bbefd14e38b"
  license "GPL-3.0"

  head do
    url "https://github.com/sbmpost/AutoRaise.git"
  end

  option "with-dalternative_task_switcher", "Build with compile flag -DALTERNATIVE_TASK_SWITCHER"
  option "with-dold_activation_method", "Build with compile flag -DOLD_ACTIVATION_METHOD"
  option "with-dexperimental_focus_first", "Build with compile flag -DEXPERIMENTAL_FOCUS_FIRST"

  def install
    opts = []
    opts << "-DALTERNATIVE_TASK_SWITCHER" if build.with? "dalternative_task_switcher"
    opts << "-DOLD_ACTIVATION_METHOD"     if build.with? "dold_activation_method"
    opts << "-DEXPERIMENTAL_FOCUS_FIRST"  if build.with? "dexperimental_focus_first"
    cxxflags = "CXXFLAGS='#{opts.join(" ")}'" unless opts.empty?

    system "make", "clean"
    system ["make", cxxflags].join(" ")
    bin.install "AutoRaise"
  end

  service do
    run opt_bin/"AutoRaise"
    log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
    error_log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
  end

  test do
    system "false"
  end
end
