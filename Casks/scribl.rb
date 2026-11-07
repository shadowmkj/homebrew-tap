cask "scribl" do
  version "0.1.0"
  sha256 "e47ec508fb8668a383ad8e4b1d4882e93167ed2bc441a115b04ce5d8496e217f"

  url "https://github.com/shadowmkj/scribl/releases/download/v#{version}/scribl_#{version}_aarch64.dmg"
  name "Scribl"
  desc "Minimal, modal, keyboard-centric canvas for infinite thinking"
  homepage "https://github.com/shadowmkj/scribl"

  depends_on arch: :arm64

  app "scribl.app"

  postflight do
    system_command "xattr",
      args: ["-cr", "#{appdir}/scribl.app"]
    system_command "codesign",
      args: ["--force", "--deep", "--sign", "-", "#{appdir}/scribl.app"]
  end

  zap trash: [
    "~/.config/scribl",
    "~/Library/Application Support/com.milan.scribl",
    "~/Library/Preferences/com.milan.scribl.plist",
    "~/Library/Saved Application State/com.milan.scribl.savedState",
  ]
end
