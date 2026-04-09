class Leetrs < Formula
  desc "A command-line tool to interact with LeetCode."
  homepage "https://github.com/shadowmkj/leetrs"
  version "1.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.4/leetrs-aarch64-apple-darwin.tar.xz"
      sha256 "c5e2f20ec1d004d73ce28b9c0e40c94dc019cb28f49e504a6766a3c7d3775d41"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.4/leetrs-x86_64-apple-darwin.tar.xz"
      sha256 "62b496f1ae40e1cc974990a81c56a44c31c2a99dd6b40d6f184ecf27f597abd8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.4/leetrs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9bd06dad58b586b24ed07ca5ee8bdf5a232b42b85fed32347878a0b981926ec9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shadowmkj/leetrs/releases/download/v1.0.4/leetrs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0e56a5183a6750019235160a8899c92e4d862aa82946e28bf9dba1c1d491c7f0"
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
