cask "scribl" do
  version "0.1.0"
  sha256 "50401c031e5927e4fb1e9df5492218a9236eaafa2cf044eef3ae3b1907a5357d"

  url "https://github.com/shadowmkj/scribl/releases/download/v#{version}/scribl_#{version}_aarch64.dmg"
  name "Scribl"
  desc "Minimal, modal, keyboard-centric canvas for infinite thinking"
  homepage "https://github.com/shadowmkj/scribl"

  depends_on arch: :arm64

  app "scribl.app"

  zap trash: [
    "~/.config/scribl",
    "~/Library/Application Support/com.milan.scribl",
    "~/Library/Preferences/com.milan.scribl.plist",
    "~/Library/Saved Application State/com.milan.scribl.savedState",
  ]
end
