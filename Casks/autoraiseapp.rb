cask "autoraiseapp" do
  version "5.2"
  sha256 :no_check

  url "https://github.com/sbmpost/AutoRaise/raw/master/AutoRaise.dmg"
  name "AutoRaise.app"
  desc "Focus-follows-mouse"
  homepage "https://github.com/sbmpost/AutoRaise"

  livecheck do
    url "https://github.com/sbmpost/AutoRaise/tags"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on macos: ">= :catalina"

  app "AutoRaise.app"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.sbmpost.autoraise.*",
    "~/Library/Logs/AutoRaise.log",
    "~/Library/Preferences/com.sbmpost.AutoRaise.plist",
  ]
end

