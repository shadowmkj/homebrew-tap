cask "scribl" do
  version "0.1.1"
  sha256 "8b186e57be9c5f674efcce4792ea7c39ce59c4378f0bbe757bebf8dc25c9dd56"

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
