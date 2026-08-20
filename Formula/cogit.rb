class Cogit < Formula
  desc "Fast, AI-powered conventional commit assistant for Git"
  homepage "https://github.com/shadowmkj/cogit"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/cogit/releases/download/v#{version}/cogit-aarch64-apple-darwin.tar.gz"
      # sha256 "REPLACE_WITH_SHA256_AARCH64_APPLE_DARWIN"
    else
      url "https://github.com/shadowmkj/cogit/releases/download/v#{version}/cogit-x86_64-apple-darwin.tar.gz"
      # sha256 "REPLACE_WITH_SHA256_X86_64_APPLE_DARWIN"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/cogit/releases/download/v#{version}/cogit-aarch64-unknown-linux-gnu.tar.gz"
      # sha256 "REPLACE_WITH_SHA256_AARCH64_UNKNOWN_LINUX_GNU"
    else
      url "https://github.com/shadowmkj/cogit/releases/download/v#{version}/cogit-x86_64-unknown-linux-gnu.tar.gz"
      # sha256 "REPLACE_WITH_SHA256_X86_64_UNKNOWN_LINUX_GNU"
    end
  end

  def install
    bin.install "cogit"
  end

  test do
    assert_match "cogit #{version}", shell_output("#{bin}/cogit --version")
  end
end

