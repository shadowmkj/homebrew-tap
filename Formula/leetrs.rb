class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.3/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "a4a05b687ccff6173addeccc479fc16abd053c26d03fb76fabf920e7861c94bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.3/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "e6fd0d3a8b9fd3f0cc9c9cd4859fa86a95d3dcaa28cc31868763b834baf0172a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.3/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "245223d9b59e52cf2e2eb7545cd86b61310ec8de8a5478bd82183ca910d844ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.3/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5fab937ea722edb475acb285bdb0a9de8dd52ba1f734ac2662197f8716523f0f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "leetrs" if OS.mac? && Hardware::CPU.arm?
    bin.install "leetrs" if OS.mac? && Hardware::CPU.intel?
    bin.install "leetrs" if OS.linux? && Hardware::CPU.arm?
    bin.install "leetrs" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
